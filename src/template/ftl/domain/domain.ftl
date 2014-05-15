package ${base_package}.${project_name}.domain;

import java.io.Serializable;
<#list importClassList as x> 
${x}
</#list>

import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.ebiz.ssi.domain.BaseDomain;

<#include "/copyright_java.ftl">
public class ${class_name} extends BaseDomain implements Serializable {
 	
	private static final long serialVersionUID = -1L;

<#list columnInfoList as x> 
	<#if x.column_comment??>
	/**
	 * ${x.column_comment}
	 */
	</#if>
    private ${x.java_type} ${x.column_name?lower_case};
           
</#list>
	public ${class_name}() {

	}
 
<#list columnInfoList as x>  
	<#assign c_name = x.column_name?lower_case>
	<#if x.column_comment??>
	/**
	 * ${x.column_comment}
	 */
	</#if>
 	public void set${c_name?cap_first}(${x.java_type} ${c_name}) {
		this.${c_name} = ${c_name};
	}
	
	<#if x.column_comment??>
	/**
	 * ${x.column_comment}
	 */
	</#if>
	public ${x.java_type} get${c_name?cap_first}() {
		return ${c_name};
	}
           
</#list>	
	@Override 
    public String toString() { 
   		return ReflectionToStringBuilder.toString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
    
 }