package ${base_package}.${project_name}.service;

import com.ebiz.ssi.service.BaseFacade;

<#include "/copyright_java.ftl">
public interface Facade extends BaseFacade {
	
<#list domains as x>
	${x}Service get${x}Service();
	
</#list> 	
}