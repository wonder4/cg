package ${base_package}.${project_name}.web.struts.manager.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.validator.GenericValidator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import ${base_package}.${project_name}.domain.${domain_name};
import ${base_package}.${project_name}.web.EntpBaseAction;

<#include "/copyright_java.ftl">
public class ${domain_name}Action extends EntpBaseAction {

	public ActionForward add2(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("-----------------------------------------------------");
		
		return mapping.findForward("input2");
	}
	
	public ActionForward add3(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (isCancelled(request)) {
			return goToReportList(mapping, form, request, response);
		}
		if (!isTokenValid(request)) {
			saveError(request, "errors.token");
			return goToReportList(mapping, form, request, response);
		}

		if (null == super.checkUserModPopeDom(form, request, "1")) {
			return super.checkPopedomInvalid(request, response);
		}

		saveToken(request);
		
		${domain_name} entity = new ${domain_name}();
		super.copyProperties(entity, form);
		Long id = getFacade().get${domain_name}Service().create${domain_name}(entity);

		DynaBean dynaBean = (DynaBean) form;
		dynaBean.set("id", id);

		return mapping.findForward("form3");
	}
	
	public ActionForward add4(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (null == super.checkUserModPopeDom(form, request, "1")) {
			return super.checkPopedomInvalid(request, response);
		}

		if (isCancelled(request)) {
			return goToReportList(mapping, form, request, response);
		}
		if (!isTokenValid(request)) {
			saveError(request, "errors.token");
			return goToReportList(mapping, form, request, response);
		}

		if (null == super.checkUserModPopeDom(form, request, "1")) {
			return super.checkPopedomInvalid(request, response);
		}

		saveToken(request);

		DynaBean dynaBean = (DynaBean) form;
		String id = (String) dynaBean.get("id");

		if (!GenericValidator.isLong(id)) {
			saveError(request, "errors.param", new String[] { id });
			return goToReportList(mapping, form, request, response);
		}
		
		${domain_name} entity = new ${domain_name}();
		super.copyProperties(entity, form);
		super.getFacade().get${domain_name}Service().modify${domain_name}(entity);

		return mapping.findForward("form4");
	}
	
	public ActionForward add5(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (null == super.checkUserModPopeDom(form, request, "1")) {
			return super.checkPopedomInvalid(request, response);
		}

		if (isCancelled(request)) {
			return goToReportList(mapping, form, request, response);
		}
		if (!isTokenValid(request)) {
			saveError(request, "errors.token");
			return goToReportList(mapping, form, request, response);
		}

		if (null == super.checkUserModPopeDom(form, request, "1")) {
			return super.checkPopedomInvalid(request, response);
		}

		saveToken(request);

		DynaBean dynaBean = (DynaBean) form;
		String id = (String) dynaBean.get("id");

		if (!GenericValidator.isLong(id)) {
			saveError(request, "errors.param", new String[] { id });
			return goToReportList(mapping, form, request, response);
		}
		
		${domain_name} entity = new ${domain_name}();
		super.copyProperties(entity, form);
		super.getFacade().get${domain_name}Service().modify${domain_name}(entity);

		return mapping.findForward("form5");
	}	
}