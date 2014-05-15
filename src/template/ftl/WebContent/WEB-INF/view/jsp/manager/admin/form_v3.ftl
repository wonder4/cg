<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/pages/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商务部商贸统计系统</title>
<meta content="商务部商贸统计系统关键字" name="keywords" />
<meta content="商务部商贸统计系统介绍" name="description" />
<link rel="stylesheet" type="text/css" href="${r'${ctx}'}/styles/global.css" />
<link rel="stylesheet" type="text/css" href="${r'${ctx}'}/styles/font.css" />
<link rel="stylesheet" type="text/css" href="${r'${ctx}'}/styles/commerce.css" />
</head>
<body>
<div class="oarcont">
	<div class="oartop"><img src="${r'${ctx}'}/images/icon4.gif" /> 当前位置：${r'${naviString}'}</div>
	<div class="rtabcont1">
	  <div class="rtab6">
	  	<h3 class="tt6"><span class="oartop">编辑 </span>(带<span class="redf">*</span>为必填项)</h3>
          <html-el:form action="/admin/${class_name}">
            <html-el:hidden property="${first_column}" styleId="${first_column}" />
            <html-el:hidden property="mod_code" styleId="mod_code" />
            <html-el:hidden property="method" styleId="method" value="save" />
            <html-el:hidden property="queryString" styleId="queryString" />
            <table width="99%" border="0" cellspacing="0" cellpadding="0">
        <#assign haveNum = "">    
        <#assign haveDate = ""> 
		<#list columnInfoList as x> 
			<#if x.column_comment?? && x.form_hidden != true>
				<tr class="tt2c">
		          <td nowrap="nowrap" align="right" width="15%">${x.column_comment}：</td>
		          <td align="left" class="tt2c" width="85%"><#rt>
				<#if x.ibatis_db_type?contains("DATE") || x.ibatis_db_type?contains("TIMESTAMP")>
					<#assign haveDate = "yes"> 
					<#lt><fmt:formatDate value="${r'$'}{af.map.${x.column_name?lower_case}}" pattern="yyyy-MM-dd" var="_${x.column_name?lower_case}" /><#rt>
                	<#lt><html-el:text property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}" size="10" maxlength="20" readonly="true" styleClass="input1" onclick="new Calendar(2000, 2999, 0).show(this);" style="cursor:pointer;" value="${r'$'}{_${x.column_name?lower_case}}" /><#rt>
				<#else>
					<#if x.html_node_type?has_content>
						<#if x.html_node_type == "checkbox">
							<#list x.html_node_values?keys as mapKey> 
								<#lt><html-el:checkbox property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}_${mapKey_index}" /> <label for="${x.column_name?lower_case}_${mapKey_index}">${x.html_node_values[mapKey]}</label> <#rt>
							</#list>
						<#elseif x.html_node_type == "radio">
							<#list x.html_node_values?keys as mapKey> 
								<#lt><html-el:radio property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}_${mapKey_index}" value="${x.html_node_values[mapKey]}" /> <label for="${x.column_name?lower_case}_${mapKey_index}">${x.html_node_values[mapKey]}</label> <#rt>
							</#list>						
						<#elseif x.html_node_type == "textarea">
							<#lt><html-el:textarea property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}" style="width:380px;height:50px;" styleClass="input1"></html-el:textarea><#rt>
						<#elseif x.html_node_type == "select">
							<#lt><html-el:select property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}">
								<html-el:option value="">请选择...</html-el:option>							
							<#list x.html_node_values?keys as mapKey> 
								<html-el:option value="${mapKey_index}">${x.html_node_values[mapKey]}</html-el:option>
							</#list>	
							</html-el:select><#rt>				
						</#if>
					<#else>
						<#assign maxlength = "">
						<#if x.column_length?? && x.column_length?number gt 0>
							<#assign maxlength = 'maxlength="${x.column_length?number}" '>
						</#if>
						<#if x.ibatis_db_type?contains("DECIMAL") || x.ibatis_db_type?contains("INTEGER")>
							<#assign haveNum = "${haveNum}, #${x.column_name?lower_case}">   
						</#if>	
                		<#lt><html-el:text property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}" style="width:380px;" styleClass="input1" ${maxlength}/><#rt>
					</#if>
				</#if>
		          <#lt> <#if x.no_must_input != true><span class="redf">*</span></#if></td>
				</tr>	
			</#if>
		</#list>   
	            <tr>
		          <td>&nbsp;</td>
		          <td><html-el:button property="" value="提 交" styleClass="but2" styleId="btn_submit" />&nbsp;
		            <html-el:button property="" value="重 置" styleClass="but2" styleId="btn_reset" onclick="this.form.reset();" />&nbsp;
		            <html-el:button property="" value="返 回" styleClass="but2" styleId="btn_back" onclick="history.back();" /></td>
		        </tr>		             
            </table>
          </html-el:form>
   	  </div>
	  <div class="clear"></div>
	</div>
<div class="clear"></div>
</div>   
<#if haveDate?length &gt; 0>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/calendar.js"></script>
</#if>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/validator.js"></script> 
<script type="text/javascript">//<![CDATA[
$(document).ready(function(){
<#list columnInfoList as x> 
	<#if x.column_comment?? && x.form_hidden != true && x.no_must_input != true>
		<#if x.html_node_type?has_content && x.html_node_type == "textarea" && x.column_length?? && x.column_length?number gt 0>
	${r"$"}("#${x.column_name?lower_case}").attr({"dataType":"Limit","max":"${x.column_length}","msg":"${x.column_comment}最多只能填写${x.column_length}个字符"});
		<#else>
	${r"$"}("#${x.column_name?lower_case}").attr({"dataType":"Require","msg":"请填写${x.column_comment}"});
		</#if>
	</#if>
</#list> 
<#if haveNum?length &gt; 0>
	initNumberValidator("${haveNum?substring(2)}");
</#if>
	
	$("#btn_submit").click(function(){
		if(Validator.Validate(this.form, 2)){
            $("#btn_submit").attr("value", "正在提交...").attr("disabled", "true");
            $("#btn_reset").attr("disabled", "true");
            $("#btn_back").attr("disabled", "true");
			this.form.submit();
		}
	});
});
//]]></script>
</body>
</html>