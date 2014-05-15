package ${base_package}.${project_name}.web.struts.manager.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.GenericValidator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.ebiz.ssi.web.struts.bean.Pager;
import ${base_package}.${project_name}.domain.${domain_name};
import ${base_package}.${project_name}.web.BaseAction;

<#include "/copyright_java.ftl">
public class ${domain_name}Action extends BaseAction {
	public ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return this.list(mapping, form, request, response);
	}

	public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (null == super.checkUserModPopeDom(form, request, "1")) {
			return super.checkPopedomInvalid(request, response);
		}
					
		saveToken(request);
		// setNaviStringToRequestScope(form, request);

		return mapping.findForward("input");
	}

	public ActionForward list(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (null == super.checkUserModPopeDom(form, request, "0")) {
			return super.checkPopedomInvalid(request, response);
		}
		super.getModPopeDom(form, request);
					
		// setNaviStringToRequestScope(form, request);
		
		DynaBean dynaBean = (DynaBean) form;
		super.encodeCharacterForGetMethod(dynaBean, request);

		Pager pager = (Pager) dynaBean.get("pager");

		${domain_name} entity = new ${domain_name}();
		super.copyProperties(entity, form);
		
<#assign have_like=false>
<#list columnInfoList as x>
	<#if x.is_like>
		entity.getMap().put("${x.column_name?lower_case}_like", (String)dynaBean.get("${x.column_name?lower_case}_like"));
		<#assign have_like=true>
	</#if>
</#list>
<#if have_like>
	${"\r"}
</#if>
		Long recordCount = getFacade().get${domain_name}Service().get${domain_name}Count(entity);
		pager.init(recordCount, pager.getPageSize(), pager.getRequestPage());
		entity.getRow().setFirst(pager.getFirstRow());
		entity.getRow().setCount(pager.getRowCount());
		List<${domain_name}> entityList = getFacade().get${domain_name}Service().get${domain_name}PaginatedList(entity);
		request.setAttribute("entityList", entityList);

		return mapping.findForward("list");
	}

	public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (null == super.checkUserModPopeDom(form, request, "2")) {
			return super.checkPopedomInvalid(request, response);
		}
		
		saveToken(request);
		// setNaviStringToRequestScope(form, request);

		DynaBean dynaBean = (DynaBean) form;
		String ${first_column} = (String) dynaBean.get("${first_column}");
		
		if (!GenericValidator.isLong(${first_column})) {
			this.saveError(request, "errors.long", new String[] { ${first_column} });
			return mapping.findForward("list");		
		}

		${domain_name} entity = new ${domain_name}();
		entity.set${first_column?cap_first}(Long.valueOf(${first_column}));
		entity = super.getFacade().get${domain_name}Service().get${domain_name}(entity);
		if (null == entity) {
			saveMessage(request, "entity.missing");
			return mapping.findForward("list");
		}
		
		// the line below is added for pagination
		entity.setQueryString(super.serialize(request, "${first_column}", "method"));
		// end
		
		super.copyProperties(form, entity);
		
		return mapping.findForward("input");
	}
	
	public ActionForward save(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (isCancelled(request)) {
			return list(mapping, form, request, response);
		}
		if (!isTokenValid(request)) {
			saveError(request, "errors.token");
			return list(mapping, form, request, response);
		}
		resetToken(request);

		DynaBean dynaBean = (DynaBean) form;
		String mod_code = (String) dynaBean.get("mod_code");

		${domain_name} entity = new ${domain_name}();
		super.copyProperties(entity, form);

		if (null == entity.get${first_column?cap_first}()) {// insert
			super.getFacade().get${domain_name}Service().create${domain_name}(entity);
			saveMessage(request, "entity.inserted");
		} else if (null != entity) {// update
			getFacade().get${domain_name}Service().modify${domain_name}(entity);
			saveMessage(request, "entity.updated");
		}

		// the line below is added for pagination
		StringBuffer pathBuffer = new StringBuffer();
		pathBuffer.append(mapping.findForward("success").getPath());
		pathBuffer.append("&mod_code=" + mod_code);
		pathBuffer.append("&");
		pathBuffer.append(super.encodeSerializedQueryString(entity.getQueryString()));
		ActionForward forward = new ActionForward(pathBuffer.toString(), true);
		// end
		return forward;
	}

	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (null == super.checkUserModPopeDom(form, request, "4")) {
			return super.checkPopedomInvalid(request, response);
		}
					
		DynaBean dynaBean = (DynaBean) form;

		String ${first_column} = (String) dynaBean.get("${first_column}");
		String[] pks = (String[]) dynaBean.get("pks");
		String mod_code = (String) dynaBean.get("mod_code");

		if (!StringUtils.isBlank(${first_column}) && GenericValidator.isLong(${first_column})) {
			${domain_name} entity = new ${domain_name}();
			entity.set${first_column?cap_first}(new Long(${first_column}));
			super.getFacade().get${domain_name}Service().remove${domain_name}(entity);
			saveMessage(request, "entity.deleted");
		} else if (!ArrayUtils.isEmpty(pks)) {
			${domain_name} entity = new ${domain_name}();
			entity.getMap().put("pks", pks);
			super.getFacade().get${domain_name}Service().remove${domain_name}(entity);
			saveMessage(request, "entity.deleted");
		}
		
		// the line below is added for pagination
		StringBuffer pathBuffer = new StringBuffer();
		pathBuffer.append(mapping.findForward("success").getPath());
		pathBuffer.append("&mod_code=" + mod_code);
		pathBuffer.append("&");
		pathBuffer.append(super.encodeSerializedQueryString(super.serialize(request, "${first_column}", "pks", "method")));
		ActionForward forward = new ActionForward(pathBuffer.toString(), true);
		// end
		
		return forward;
	}
}