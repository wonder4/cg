<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/pages/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>---</title>
<link href="${r'${ctx}'}/commons/styles/themes/blue/styles/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div align="center">
  <div align="left" style="width:99%;">
    <div align="left" class="nav">${r'${naviString}'}</div>
    <br />
    <html-el:form action="/admin/${class_name}" enctype="multipart/form-data">
      <html-el:hidden property="${first_column}" styleId="${first_column}" />
      <html-el:hidden property="mod_code" styleId="mod_code" />
      <html-el:hidden property="method" styleId="method" value="save" />
      <html-el:hidden property="queryString" styleId="queryString" />
      <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="datagrid">
        <tr>
          <th colspan="2" class="form_title">编辑</th>
        </tr>
<#list columnInfoList as x> 
	<#if x.column_comment??>
	<#assign maxlength = "">
	<#if x.column_length?? && x.column_length?number gt 0>
		<#assign maxlength = 'maxlength="${(x.column_length?number / 2)?int}" '>
	</#if>
		<tr>
          <td nowrap="nowrap" class="title_item">${x.column_comment}：</td>
          <td><html-el:text property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}" style="width:380px;" styleClass="webinput" ${maxlength}/></td>
        </tr>	
	</#if>
</#list>        
        <tr>
          <td>&nbsp;</td>
          <td><html-el:button property="" value="提 交" styleClass="websub" styleId="btn_submit" />
            <html-el:button property="" value="重 置" styleClass="websub" styleId="btn_reset" onclick="this.form.reset();" />
            <html-el:button property="" value="返 回" styleClass="websub" styleId="btn_back" onclick="history.back();" /></td>
        </tr>
      </table>
    </html-el:form>
  </div>
</div>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/validator.js"></script> 
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/jquery.js"></script> 
<script type="text/javascript">//<![CDATA[
$(document).ready(function(){
<#list columnInfoList as x> 
	<#if x.column_comment??>
	${r"$"}("#${x.column_name?lower_case}").attr("dataType", "Require").attr("msg", "请填写${x.column_comment}");
	</#if>
</#list> 
	
	$("#btn_submit").click(function(){
		if(Validator.Validate(this.form, 3)){
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