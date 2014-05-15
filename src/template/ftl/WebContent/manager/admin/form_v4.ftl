<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/pages/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${r'${naviString}'}</title>
<link href="${r'${ctx}'}/commons/styles/blue/base.css" rel="stylesheet" type="text/css" />
<jsp:include page="../_global_manager_page_head.jsp" flush="true" />
</head>
<body>
<div class="divContent">
  <div class="subtitle">
    <h3>${r'${naviString}'}</h3>
  </div>
  <html-el:form action="/admin/${class_name}" enctype="multipart/form-data">
  	<html-el:hidden property="${first_column}" styleId="${first_column}" />
    <html-el:hidden property="queryString" styleId="queryString" />
    <html-el:hidden property="method" styleId="method" value="save" />
    <html-el:hidden property="mod_id" styleId="mod_id" />
	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="tableClass">
        <#assign haveNum = "">    
        <#assign haveDate = ""> 
		<#list columnInfoList as x> 
			<#if x.column_comment?? && x.form_hidden != true>
				<tr class="tt2c">
		          <td class="title_item" nowrap="nowrap" width="15%"><#if x.no_must_input != true><span style="color:#f00;">*</span></#if>${x.column_comment}：</td>
		          <td class="tt2c" align="left" width="85%"><#rt>
				<#if x.ibatis_db_type?contains("DATE") || x.ibatis_db_type?contains("TIMESTAMP")>
					<#assign haveDate = "yes"> 
					<#lt><fmt:formatDate value="${r'$'}{af.map.${x.column_name?lower_case}}" pattern="yyyy-MM-dd" var="_${x.column_name?lower_case}" /><#rt>
                	<#lt><html-el:text property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}" size="10" maxlength="20" readonly="true" styleClass="webinput" onclick="WdatePicker();" style="cursor:pointer;" value="${r'$'}{_${x.column_name?lower_case}}" /><#rt>
				<#else>
					<#if x.html_node_type?has_content>
						<#if x.html_node_type == "checkbox">
							<#list x.html_node_values?keys as mapKey> 
								<#lt><html-el:checkbox property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}_${mapKey_index}" /> <label for="${x.column_name?lower_case}_${mapKey_index}">${x.html_node_values[mapKey]}</label> <#rt>
							</#list>
						<#elseif x.html_node_type == "radio">
							<#list x.html_node_values?keys as mapKey> 
								<#lt><html-el:radio property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}_${mapKey_index}" value="${mapKey}" /> <label for="${x.column_name?lower_case}_${mapKey_index}">${x.html_node_values[mapKey]}</label> <#rt>
							</#list>						
						<#elseif x.html_node_type == "textarea">
							<#lt><html-el:textarea property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}" style="width:380px;height:50px;" styleClass="webinput"></html-el:textarea><#rt>
						<#elseif x.html_node_type == "select">
							<#lt><html-el:select property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}">
								<html-el:option value="">请选择...</html-el:option>							
							<#list x.html_node_values?keys as mapKey> 
								<html-el:option value="${mapKey}">${x.html_node_values[mapKey]}</html-el:option>
							</#list>	
							</html-el:select><#rt>				
						</#if>
					<#else>
						<#assign maxlength = "">
						<#if x.column_length?? && x.column_length?number gt 0>
							<#if x.column_type?contains("NUMBER")>
								<#assign maxlength = 'maxlength="${(x.data_precision?number - x.data_scale?number)?c}" '>
							<#else>
								<#assign maxlength = 'maxlength="${(x.column_length?number/2)?c}" '>
							</#if>
						</#if>
						<#if x.ibatis_db_type?contains("DECIMAL") || x.ibatis_db_type?contains("INTEGER")>
							<#assign haveNum = "${haveNum}, #${x.column_name?lower_case}">   
						</#if>	
                		<#lt><html-el:text property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}" style="width:380px;" styleClass="webinput" ${maxlength}/><#rt>
					</#if>
				</#if>
		          <#lt></td>
				</tr>	
			</#if>
		</#list>   
	            <tr>
		          <td>&nbsp;</td>
		          <td><html-el:button property="" value="保 存" styleClass="bgButton" styleId="btn_submit" /> &nbsp;
		              <html-el:button property="" value="重 填" styleClass="bgButton" styleId="btn_reset" onclick="this.form.reset();" /> &nbsp;
		              <html-el:button property="" value="返 回" styleClass="bgButton" styleId="btn_back" onclick="history.back();" /></td>
		        </tr>		             
	</table>
  </html-el:form>
</div>
<#if haveDate?length &gt; 0>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/calendar/WdatePicker.js"></script> 
</#if>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/jquery.js"></script> 
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/validator.js"></script> 
<script type="text/javascript">//<![CDATA[
$(document).ready(function(){
<#list columnInfoList as x> 
    <#assign validator_msg = "请填写"> 
	<#if x.column_comment?? && x.form_hidden != true && x.no_must_input != true>
		<#if x.html_node_type?has_content && x.html_node_type == "textarea" && x.column_length?? && x.column_length?number gt 0>
	${r"$"}("#${x.column_name?lower_case}").attr({"dataType":"Limit","max":"${x.column_length}","msg":"${x.column_comment?html?replace('\r','')}最多只能填写${x.column_length}个字符"});
		<#elseif x.ibatis_db_type?contains("DECIMAL") || x.ibatis_db_type?contains("INTEGER")>
	${r"$"}("#${x.column_name?lower_case}").attr({"dataType":"Integer","msg":"${validator_msg}${x.column_comment?html?replace('\r','')}且必须为整数"});		
		<#else>
			<#if x.html_node_type?has_content && (x.html_node_type == "checkbox" || x.html_node_type == "radio" || x.html_node_type == "select")>
				<#assign validator_msg = "请选择"> 
			</#if>
	${r"$"}("#${x.column_name?lower_case}").attr({"dataType":"Require","msg":"${validator_msg}${x.column_comment?html?replace('\r','')}"});
		</#if>
	</#if>
</#list> 
<#if haveNum?length &gt; 0>
	//${r'$'}("${haveNum?substring(2)}").attr("dataType", "Integer").attr("msg", "必须为整数");
	//${r'$'}("${haveNum?substring(2)}").focus(setOnlyNum);
</#if>

	$("#btn_submit").click(function(){
		if(Validator.Validate(this.form, 1)){
            $("#btn_submit").attr("value", "正在提交...").attr("disabled", "true");
            $("#btn_reset").attr("disabled", "true");
            $("#btn_back").attr("disabled", "true");
			this.form.submit();
		}
	});
});

<#if haveNum?length &gt; 0>
function setOnlyNum() {
	$(this).css("ime-mode", "disabled");
	$(this).attr("t_value", "");
	$(this).attr("o_value", "");
	$(this).bind("dragenter",function(){
		return false;
	});
	$(this).keypress(function (){
		if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value;
	}).keyup(function (){
		if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value;
	}).blur(function (){
		if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value;}
		//if(this.value.length == 0) this.value = "0";
	});
	this.text.selected;
}
</#if>
//]]></script>
<jsp:include page="../_global_manager_page_bottom.jsp" flush="true" />
</body>
</html>