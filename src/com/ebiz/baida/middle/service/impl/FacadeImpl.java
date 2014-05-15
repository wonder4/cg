package com.ebiz.baida.middle.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ebiz.baida.middle.service.Facade;
import com.ebiz.baida.middle.service.GenerateActionService;
import com.ebiz.baida.middle.service.GenerateDaoService;
import com.ebiz.baida.middle.service.GenerateDaoSqlMapImplService;
import com.ebiz.baida.middle.service.GenerateDomainService;
import com.ebiz.baida.middle.service.GenerateFacadeImplService;
import com.ebiz.baida.middle.service.GenerateFacadeService;
import com.ebiz.baida.middle.service.GenerateJspFormService;
import com.ebiz.baida.middle.service.GenerateJspListService;
import com.ebiz.baida.middle.service.GenerateJspViewService;
import com.ebiz.baida.middle.service.GenerateServiceImplService;
import com.ebiz.baida.middle.service.GenerateServiceService;
import com.ebiz.baida.middle.service.GenerateSqlMapConfigService;
import com.ebiz.baida.middle.service.GenerateSqlMapService;
import com.ebiz.baida.middle.service.RoleInfoService;
import com.ebiz.baida.middle.service.TableInfoService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-23 下午05:03:00
 */
@Component("facade")
public class FacadeImpl extends BaseFacadeImpl implements Facade {

	@Resource
	RoleInfoService roleInfoService;

	@Resource
	TableInfoService tableInfoService;

	@Resource
	TemplateService templateService;

	@Resource
	GenerateDomainService generateDomainService;

	@Resource
	GenerateDaoService generateDaoService;

	@Resource
	GenerateDaoSqlMapImplService generateDaoSqlMapImplService;

	@Resource
	GenerateSqlMapService generateSqlMapService;

	@Resource
	GenerateServiceService generateServiceService;

	@Resource
	GenerateFacadeImplService generateFacadeImplService;

	@Resource
	GenerateFacadeService generateFacadeService;

	@Resource
	GenerateServiceImplService generateServiceImplService;

	@Resource
	GenerateSqlMapConfigService generateSqlMapConfigService;

	@Resource
	GenerateActionService generateActionService;

	@Resource
	GenerateJspFormService generateJspFormService;

	@Resource
	GenerateJspListService generateJspListService;

	@Resource
	GenerateJspViewService generateJspViewService;

	public RoleInfoService getRoleInfoService() {
		return roleInfoService;
	}

	public TableInfoService getTableInfoService() {
		return tableInfoService;
	}

	public TemplateService getTemplateService() {
		return templateService;
	}

	public GenerateDomainService getGenerateDomainService() {
		return generateDomainService;
	}

	public GenerateDaoService getGenerateDaoService() {
		return generateDaoService;
	}

	public GenerateDaoSqlMapImplService getGenerateDaoSqlMapImplService() {
		return generateDaoSqlMapImplService;
	}

	public GenerateSqlMapService getGenerateSqlMapService() {
		return generateSqlMapService;
	}

	public GenerateServiceService getGenerateServiceService() {
		return generateServiceService;
	}

	public GenerateFacadeImplService getGenerateFacadeImplService() {
		return generateFacadeImplService;
	}

	public GenerateFacadeService getGenerateFacadeService() {
		return generateFacadeService;
	}

	public GenerateServiceImplService getGenerateServiceImplService() {
		return generateServiceImplService;
	}

	public GenerateSqlMapConfigService getGenerateSqlMapConfigService() {
		return generateSqlMapConfigService;
	}

	public GenerateActionService getGenerateActionService() {
		return generateActionService;
	}

	public GenerateJspFormService getGenerateJspFormService() {
		return generateJspFormService;
	}

	public GenerateJspListService getGenerateJspListService() {
		return generateJspListService;
	}

	public GenerateJspViewService getGenerateJspViewService() {
		return generateJspViewService;
	}

}