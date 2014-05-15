package ${base_package}.${project_name}.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ${base_package}.${project_name}.dao.${domain_name}Dao;
import ${base_package}.${project_name}.domain.${domain_name};
import ${base_package}.${project_name}.service.${domain_name}Service;

<#include "/copyright_java.ftl">
 @Service
public class ${domain_name}ServiceImpl implements ${domain_name}Service {
	<#assign domain_entity = domain_name?uncap_first>
	
	@Resource
	private ${domain_name}Dao ${domain_entity}Dao;

	public ${return_number_type} create${domain_name}(${domain_name} t) {
		return this.${domain_entity}Dao.insertEntity(t);
	}

	public ${domain_name} get${domain_name}(${domain_name} t) {
		return this.${domain_entity}Dao.selectEntity(t);
	}

	public ${return_number_type} get${domain_name}Count(${domain_name} t) {
		return this.${domain_entity}Dao.selectEntityCount(t);
	}

	public List<${domain_name}> get${domain_name}List(${domain_name} t) {
		return this.${domain_entity}Dao.selectEntityList(t);
	}

	public int modify${domain_name}(${domain_name} t) {
		return this.${domain_entity}Dao.updateEntity(t);
	}

	public int remove${domain_name}(${domain_name} t) {
		return this.${domain_entity}Dao.deleteEntity(t);
	}

	public List<${domain_name}> get${domain_name}PaginatedList(${domain_name} t) {
		return this.${domain_entity}Dao.selectEntityPaginatedList(t);
	}	

}