package ${base_package}.${project_name}.web.struts.manager;

import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.springframework.web.util.CookieGenerator;
import org.springframework.web.util.WebUtils;

import ${base_package}.${project_name}.domain.${userinfo_table_name};
import ${base_package}.${project_name}.web.Constants;
import ${base_package}.${project_name}.web.struts.BaseAction;
import com.ebiz.security.DESPlus;

<#include "/copyright_java.ftl">
public class LoginAction extends BaseAction {
	private static final String DEFAULT_PASSWORD = "......";

	public ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return this.showLoginForm(mapping, form, request, response);
	}

	public ActionForward showLoginForm(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setAttribute("isEnabledCode", super.getSysSetting("isEnabledCode"));
		setCookies2RequestScope(request);
		return mapping.findForward("login");
	}

	public ActionForward login(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		if (!StringUtils.equalsIgnoreCase(request.getMethod(), "POST")) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return null;
		}

		DynaBean lazyForm = (DynaBean) form;

		String user_name = (String) lazyForm.get("${user_name}");
		String password = (String) lazyForm.get("${password}");
		String verificationCode = (String) lazyForm.get("verificationCode");
		// String is_remember = (String) lazyForm.get("is_remember");

		String msg = null;
		if (StringUtils.isBlank(user_name)) {
			msg = super.getMessage(request, "login.failed.username.isEmpty");
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');location.href='login.do'}");
			return null;
		}

		if (StringUtils.isBlank(password)) {
			msg = super.getMessage(request, "login.failed.password.isEmpty");
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');location.href='login.do'}");
			return null;
		}

		HttpSession session = request.getSession();
		if ("1".equals(super.getSysSetting("isEnabledCode"))) {
			if (StringUtils.isBlank(verificationCode)) {
				msg = super.getMessage(request, "login.failed.verificationCode.isEmpty");
				super.renderJavaScript(response, "window.onload=function(){alert('" + msg
						+ "');location.href='login.do'}");
				return null;
			}

			if (!verificationCode.equals((String) session.getAttribute("verificationCode"))) {
				msg = super.getMessage(request, "login.failed.verificationCode.invalid");
				super.renderJavaScript(response, "window.onload=function(){alert('" + msg
						+ "');location.href='login.do'}");
				return null;
			}
		}

		user_name = user_name.trim();
		${userinfo_table_name} entity = new ${userinfo_table_name}();
		entity.set${user_name?cap_first}(user_name);
		//entity.setUser_state(0);
		List<${userinfo_table_name}> entityList = getFacade().get${userinfo_table_name}Service().get${userinfo_table_name}List(entity);
		if (null == entityList || entityList.size() == 0) {
			msg = super.getMessage(request, "login.failed.username.invalid");
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');location.href='login.do'}");
			return null;
		} else if (entityList.size() > 1) {
			msg = super.getMessage(request, "login.failed.username.repeat");
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');location.href='login.do'}");
			return null;
		}

		Cookie passwordCookie = WebUtils.getCookie(request, "${password}");
		if (null != passwordCookie && DEFAULT_PASSWORD.equals(password)) {
			entity.set${password?cap_first}(passwordCookie.getValue());
		} else {
			DESPlus des = new DESPlus();
			entity.set${password?cap_first}(des.encrypt(password));
		}
		${userinfo_table_name} ${userinfo_table_name?uncap_first} = getFacade().get${userinfo_table_name}Service().get${userinfo_table_name}(entity);
		if (null == ${userinfo_table_name?uncap_first}) {
			msg = super.getMessage(request, "login.failed.password.invalid");
			super.renderJavaScript(response, "window.onload=function(){alert('" + msg + "');location.href='login.do'}");
			return null;
		} else {
			CookieGenerator cg = new CookieGenerator();
			//// if (is_remember != null) {
			//// cg.setCookieMaxAge(60 * 60 * 24 * 14);
			//// cg.setCookieName("user_name");
			//// cg.addCookie(response, URLEncoder.encode(user_name, "UTF-8"));
			//// cg.setCookieName("password");
			//// cg.addCookie(response, URLEncoder.encode(entity.getPassword(), "UTF-8"));
			//// cg.setCookieName("is_remember");
			//// cg.addCookie(response, URLEncoder.encode(is_remember, "UTF-8"));
			//// } else {
			cg.setCookieMaxAge(0);
			cg.setCookieName("${user_name}");
			cg.removeCookie(response);
			cg.setCookieName("${password}");
			cg.removeCookie(response);
			//// cg.setCookieName("is_remember");
			//// cg.removeCookie(response);
			//// }

			// update login count
			${userinfo_table_name} _${userinfo_table_name?uncap_first} = new ${userinfo_table_name}();
			//ui.setId(userInfo.getId());
			//ui.setLogin_count(userInfo.getLogin_count().longValue() + 1);
			//ui.setLast_login_time(new Date());
			//ui.setLast_login_ip(this.getIpAddr(request));
			getFacade().get${userinfo_table_name}Service().modify${userinfo_table_name}(ui);

			//${userinfo_table_name?uncap_first}.setLogin_count(userInfo.getLogin_count().longValue() + 1);
			//${userinfo_table_name?uncap_first}.setLast_login_time(ui.getLast_login_time());
			//${userinfo_table_name?uncap_first}.setLast_login_ip(ui.getLast_login_ip());

			session.setAttribute(Constants.USER_INFO, userInfo);
			return mapping.findForward("success");

		}
	}

	public ActionForward logout(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if (null != session) {
			session.removeAttribute(Constants.USER_INFO);
			session.invalidate();
		}
		setCookies2RequestScope(request);
		return mapping.findForward("login");
	}

	private void setCookies2RequestScope(HttpServletRequest request) throws Exception {
		Cookie user_name = WebUtils.getCookie(request, "${user_name}");
		Cookie password = WebUtils.getCookie(request, "${password}");
		Cookie is_remember = WebUtils.getCookie(request, "is_remember");

		if (null != user_name) {
			request.setAttribute("user_name", URLDecoder.decode(user_name.getValue(), "UTF-8"));
		}
		if (null != password) {
			request.setAttribute("password", DEFAULT_PASSWORD);
		}
		if (null != is_remember) {
			request.setAttribute("is_remember", URLDecoder.decode(is_remember.getValue(), "UTF-8"));
		}
	}

	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}