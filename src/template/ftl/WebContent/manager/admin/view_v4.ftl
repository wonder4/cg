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
  <table width="100%" border="0" cellpadding="1" cellspacing="1" class="tableClass">
	<#list columnInfoList as x> 
		<#if x.column_comment?? && x.form_hidden != true>
			<tr class="tt2c">
	          <td class="title_item" nowrap="nowrap" width="15%">${x.column_comment}：</td>
	          <td class="tt2c" align="left" width="85%"><#rt>
			<#if x.ibatis_db_type?contains("DATE") || x.ibatis_db_type?contains("TIMESTAMP")>
				<#lt><fmt:formatDate value="${r'$'}{af.map.${x.column_name?lower_case}}" pattern="yyyy-MM-dd" /><#rt>
			<#else>
				<#if x.html_node_type?has_content>
					<#if x.html_node_type == "checkbox" || x.html_node_type == "radio" || x.html_node_type == "select">
						<#lt><c:choose>					
						<#list x.html_node_values?keys as mapKey> 
								<c:when test="${r'$'}{'${mapKey}' eq af.map.${x.column_name?lower_case}}">${x.html_node_values[mapKey]}</c:when>
						</#list>
						</c:choose><#rt>
					<#elseif x.html_node_type == "textarea">
						<#lt>${'$'}{fn:replace(fn:escapeXml(af.map.${x.column_name?lower_case}), g_java_n, g_html_br)}<#rt>
					</#if>
				<#else>
					<#lt>${r'$'}{fn:escapeXml(af.map.${x.column_name?lower_case})}<#rt>
				</#if>
			</#if>
	          <#lt></td>
			</tr>	
		</#if>
	</#list>   
            <tr>
	          <td>&nbsp;</td>
	          <td><html-el:button property="" value="返 回" styleClass="bgButton" styleId="btn_back" onclick="history.back();" /></td>
	        </tr>		             
  </table>
</div>
<jsp:include page="../_global_manager_page_bottom.jsp" flush="true" />
</body>
</html>