package ${base_package}.${project_name}.web;

import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.beanutils.DynaProperty;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.params.ConnManagerParams;
import org.apache.http.conn.params.ConnPerRouteBean;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionServlet;
import org.springframework.util.Assert;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.util.CookieGenerator;
import org.springframework.web.util.WebUtils;

import com.ebiz.ssi.web.struts.BaseSsiAction;
import com.ebiz.ssi.web.struts.util.QueryStringUtils;
import com.ebiz.yjhxsspt.domain.ModPopedom;
import com.ebiz.yjhxsspt.domain.MuserBguserpopd;
import com.ebiz.yjhxsspt.domain.RoleUser;
import com.ebiz.yjhxsspt.domain.SysModule;
import com.ebiz.yjhxsspt.service.Facade;

<#include "/copyright_java.ftl">
public abstract class BaseAction extends BaseSsiAction {

	private Facade facade;

	protected HttpClient httpClient = null;

	/**
	 * the powerful method to return facade with all services(method)
	 * 
	 * @return facade
	 */
	protected Facade getFacade() {
		return this.facade;
	}

	public void setServlet(ActionServlet actionServlet) {
		super.setServlet(actionServlet);
		Assert.notNull(actionServlet, "actionServlet is can not be null");
		ServletContext servletContext = actionServlet.getServletContext();
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		this.facade = (Facade) wac.getBean("facade");
	}

	protected void setMetaMsgToRequestScope(HttpServletRequest request, String keywords, String description) {
		request.setAttribute("keywords", keywords);

		if (null != description) {
			description = description.replaceAll("<[^>].*?>", "").replaceAll("(\\s)+", "");
			// description = StringUtils.substring(description, 0, 200);
			description = StringUtils.trim(StringUtils.substring(description.replace("&nbsp;", " "), 0, 80));
			request.setAttribute("description", description);
		}
	}

	/**
	 * @author Hui,Gang
	 * @version Build 2009.12.11
	 */
	public void encodeCharacterForGetMethod(Object object, HttpServletRequest request) throws Exception {
		if (!StringUtils.equalsIgnoreCase(request.getMethod(), "GET")) {
			return;
		}

		if (object instanceof DynaBean) {
			DynaBean dynaBean = (DynaBean) object;
			DynaProperty origDescriptors[] = dynaBean.getDynaClass().getDynaProperties();
			for (int i = 0; i < origDescriptors.length; i++) {
				String name = origDescriptors[i].getName();
				if (getBeanUtilsBean().getPropertyUtils().isWriteable(dynaBean, name)) {
					Object value = dynaBean.get(name);
					if (value instanceof String) {
						getBeanUtilsBean().copyProperty(dynaBean, name, URLDecoder.decode(value.toString(), "UTF-8"));
					}
				}
			}
		} else {// is a standard JavaBean
			PropertyDescriptor origDescriptors[] = getBeanUtilsBean().getPropertyUtils().getPropertyDescriptors(object);
			for (int i = 0; i < origDescriptors.length; i++) {
				String name = origDescriptors[i].getName();
				if ("class".equals(name)) {
					continue; // No point in trying to set an object's class
				}
				if (getBeanUtilsBean().getPropertyUtils().isReadable(object, name)
						&& getBeanUtilsBean().getPropertyUtils().isWriteable(object, name)) {
					Object value = getBeanUtilsBean().getPropertyUtils().getSimpleProperty(object, name);
					if (value instanceof String) {
						getBeanUtilsBean().copyProperty(object, name, URLDecoder.decode(value.toString(), "UTF-8"));
					}
				}
			}
		}
	}

	/**
	 * @author Hui,Gang
	 * @version Build 2009.12.11
	 */
	public BeanUtilsBean getBeanUtilsBean() {
		return BeanUtilsBean.getInstance();
	}

	/**
	 * @author Hui,Gang
	 * @version Build 2009.12.24
	 * @version Build 2010.01.18
	 * @throws Exception
	 */
	public void saveParamsToCookie(ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		DynaBean dynaBean = (DynaBean) form;
		String returnURL = (String) dynaBean.get("returnURL");

		// returnURL = new String(returnURL.getBytes("ISO8859-1"), "UTF-8");
		returnURL = QueryStringUtils.encodeSerializedQueryString(returnURL, "UTF-8");

		CookieGenerator cg = new CookieGenerator();
		cg.setCookieMaxAge(60 * 60 * 24);
		cg.setCookieName("yjhxssptUrlParams");
		cg.addCookie(response, returnURL);
	}

	/**
	 * @author Hui,Gang
	 * @version Build 2009.12.24
	 * @version Build 2010.01.18
	 */
	public ActionForward returnFatherModule(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Cookie paramsCookie = WebUtils.getCookie(request, "yjhxssptUrlParams");
		if (null == paramsCookie) {
			return mapping.findForward("list");
		}

		String url = paramsCookie.getValue();
		super.renderJavaScript(response, "location.href='" + url + "'");
		return null;
	}

	// TODO 导航，暂时简单处理
	public void setNaviStringToRequestScope(ActionForm form, HttpServletRequest request) {
		String mod_code = request.getParameter("mod_code");
		String naviString = "";
		if (StringUtils.isBlank(mod_code)) {
			request.setAttribute("naviString", naviString);
			return;
		}

		SysModule sysModule = new SysModule();
		sysModule.setMod_code(new Long(mod_code));
		sysModule = getFacade().getSysModuleService().getSysModule(sysModule);
		if (null != sysModule) {
			request.setAttribute("naviString", sysModule.getMod_name());
		}

		return;
	}

	// TODO 权限判断
	public Object checkUserModPopeDom(ActionForm form, HttpServletRequest request, String... popedoms) {
		boolean legitimate = false;
		String modPopedom = this.getModPopeDom(form, request);

		if ("+".equals(modPopedom)) {
			return null;
		}

		for (String popedom : popedoms) {
			popedom = popedom.concat("+");
			if (StringUtils.indexOf(modPopedom, popedom) == -1) {
				legitimate = false;
				break;
			}
			legitimate = true;
		}

		if (legitimate) {
			return legitimate;
		}
		return null;
	}

	public String getModPopeDom(ActionForm form, HttpServletRequest request) {
		DynaBean dynaBean = (DynaBean) form;
		String mod_code = (String) dynaBean.get("mod_code");
		StringBuffer popedom = new StringBuffer();

		HttpSession session = request.getSession();
		MuserBguserpopd mg = (MuserBguserpopd) session.getAttribute(Constants.USER_INFO);

		RoleUser roleUser = new RoleUser();
		roleUser.setUser_id(mg.getUser_id());
		List<RoleUser> roleUserList = getFacade().getRoleUserService().getRoleUserList(roleUser);

		boolean legal = false;
		for (RoleUser roleUser1 : roleUserList) {
			if (null == roleUser1) {
				continue;
			}
			legal = true;
			ModPopedom webModPopedom = new ModPopedom();
			webModPopedom.setMod_id(Long.valueOf(mod_code));
			webModPopedom.setRole_id(roleUser1.getRole_id());
			webModPopedom = this.getFacade().getModPopedomService().getModPopedom(webModPopedom);
			if (null != webModPopedom) {
				popedom.append(webModPopedom.getMap().get("ppdm_detail"));
			}
		}
		if (legal) {
			popedom.append("+");
		}

		ModPopedom modPopedom = new ModPopedom();
		modPopedom.setMod_id(Long.valueOf(mod_code));
		modPopedom.setUser_id(mg.getUser_id());
		modPopedom = this.getFacade().getModPopedomService().getModPopedom(modPopedom);
		if (null != modPopedom) {
			popedom.append(modPopedom.getMap().get("ppdm_detail"));
		}
		popedom.append("+");

		request.setAttribute("popedom", popedom.toString());

		return popedom.toString();
	}

	public ActionForward checkPopedomInvalid(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		return invalidOperAndToPage(request, response, "popedom.check.invalid");
	}

	public ActionForward invalidOperAndToPage(HttpServletRequest request, HttpServletResponse response, String message)
			throws IOException {
		return this.invalidOperAndToPage(request, response, message, "");
	}

	public ActionForward invalidOperAndToPage(HttpServletRequest request, HttpServletResponse response, String message,
			String url) throws IOException {
		String msg = super.getMessage(request, message);
		String cPath = request.getContextPath().concat("/").concat(url);
		super.renderJavaScript(response, "alert('".concat(msg).concat("');location.href='".concat(cPath).concat("'")));
		return null;
	}

	public ActionForward invalidOperAndAlertMsg(HttpServletRequest request, HttpServletResponse response, String message)
			throws IOException {
		String msg = super.getMessage(request, message);
		super.renderJavaScript(response, "alert('".concat(msg).concat("');history.back();"));
		return null;
	}

	public void updateLeftMenu(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MuserBguserpopd muserBguserpopd = new MuserBguserpopd();
		muserBguserpopd = (MuserBguserpopd) session.getAttribute(Constants.USER_INFO);

		SysModule sysModule = new SysModule();
		sysModule.setUser_type(muserBguserpopd.getUser_type());
		sysModule.setCom_fin(muserBguserpopd.getCom_fin());
		sysModule.getMap().put("user_id", muserBguserpopd.getUser_id());
		List<SysModule> sysModuleList = getFacade().getSysModuleService().getSysModuleListForLeftMenu(sysModule);

		session.setAttribute("sysModuleList", sysModuleList);
	}

	public Boolean isAdminRole(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MuserBguserpopd mg = (MuserBguserpopd) session.getAttribute(Constants.USER_INFO);

		RoleUser ru = new RoleUser();
		ru.setUser_id(mg.getUser_id());
		ru.setRole_id(new Long(10));
		ru = this.facade.getRoleUserService().getRoleUser(ru);
		if (null != ru) {
			return true;
		}

		return false;
	}

	protected HttpResponse executePostMethod(String url, List<NameValuePair> formparams, String charset) {
		try {
			UrlEncodedFormEntity entity = new UrlEncodedFormEntity(formparams, charset);
			HttpPost httppost = new HttpPost(url);
			httppost.setEntity(entity);
			HttpResponse response = getHttpClient().execute(httppost);
			return response;
		} catch (UnsupportedEncodingException e) {
			logger.error(e.getMessage());
		} catch (ClientProtocolException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return null;
	}

	protected HttpClient getHttpClient() {
		if (httpClient == null) {
			HttpParams params = new BasicHttpParams();
			ConnManagerParams.setMaxTotalConnections(params, 200);
			ConnPerRouteBean connPerRoute = new ConnPerRouteBean(20);
			HttpHost localhost = new HttpHost("locahost", 80);
			connPerRoute.setMaxForRoute(new HttpRoute(localhost), 50);
			ConnManagerParams.setMaxConnectionsPerRoute(params, connPerRoute);

			SchemeRegistry schemeRegistry = new SchemeRegistry();
			schemeRegistry.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
			schemeRegistry.register(new Scheme("https", SSLSocketFactory.getSocketFactory(), 443));

			ClientConnectionManager cm = new ThreadSafeClientConnManager(params, schemeRegistry);
			httpClient = new DefaultHttpClient(cm, params);
		}
		return httpClient;
	}
}