package ${base_package}.${project_name}.service;

import java.util.List;

import ${base_package}.${project_name}.domain.${domain_name};

<#include "/copyright_java.ftl">
public interface ${domain_name}Service {

	${return_number_type} create${domain_name}(${domain_name} t);

	int modify${domain_name}(${domain_name} t);

	int remove${domain_name}(${domain_name} t);

	${domain_name} get${domain_name}(${domain_name} t);

	List<${domain_name}> get${domain_name}List(${domain_name} t);

	${return_number_type} get${domain_name}Count(${domain_name} t);

	List<${domain_name}> get${domain_name}PaginatedList(${domain_name} t);

}