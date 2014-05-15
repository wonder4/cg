package ${base_package}.${project_name}.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ebiz.ssi.service.impl.BaseFacadeImpl;
import ${base_package}.${project_name}.service.Facade;
<#list domains as x>
import ${base_package}.${project_name}.service.${x}Service;
</#list>

<#include "/copyright_java.ftl">
@Component("facade")
public class FacadeImpl extends BaseFacadeImpl implements Facade {
	
<#list domains as x>
	@Resource
	${x}Service ${x?uncap_first}Service;
	
</#list> 	
<#list domains as x>
	public ${x}Service get${x}Service() {
		return ${x?uncap_first}Service;
	}
	
</#list> 
}