<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/pages/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>---</title>
<link rel="stylesheet" type="text/css" href="${r'${ctx}'}/styles/common.css" />
<link rel="stylesheet" type="text/css" href="${r'${ctx}'}/styles/appliback.css" />
</head>
<body>
<div class="oarcont">
  <div class="oartop"><img src="${r'${ctx}'}/images/icon4.gif" />当前位置：${r'${naviString}'}</div>
   <div class="rtabcont1">
    <div class="rtab3">   
      <html-el:form action="/admin/${class_name}">
        <html-el:hidden property="method" value="list" />
        <html-el:hidden property="mod_code" />
		<div class="rtab3s">
	<#assign column_count = 0>   
	<#list columnInfoList as x> 
		<#if x.column_comment?? && x.list_hidden != true>
			<#assign column_count = column_count + 1>  
		</#if>
		<#if x.column_comment?? && x.query_hidden != true>
	 		&nbsp;${x.column_comment}：<#rt>
	 		<#if x.html_node_type?has_content && (x.html_node_type == "select" || x.html_node_type == "radio" || x.html_node_type == "checkbox")>
		 		<#lt><html-el:select property="${x.column_name?lower_case}" styleId="${x.column_name?lower_case}">
					<html-el:option value="">请选择...</html-el:option>	
				<#list x.html_node_values?keys as mapKey> 
					<html-el:option value="${mapKey_index}">${x.html_node_values[mapKey]}</html-el:option>
				</#list>	
		 		</html-el:select>
	 		<#elseif x.is_like>
	 			<#lt><html-el:text property="${x.column_name?lower_case}_like" size="20" maxlength="20" styleId="${x.column_name?lower_case}_like" styleClass="input1" />
	 		<#else>
	 			<#lt><html-el:text property="${x.column_name?lower_case}" size="20" maxlength="20" styleId="${x.column_name?lower_case}" styleClass="input1" />
	 		</#if>
		</#if>
	</#list>       			
		</div>
        <div class="but1"><html-el:button property="" value="查 询" styleId="btn_submit" styleClass="but2" onclick="this.form.submit();" /></div>
        <div class="clear"></div>
      </html-el:form>
    </div>
    <div style="margin:14px 7px 0 7px;">
		<input class="but2" type="button" name="add" value="新增" onclick="location.href='${class_name}.do?method=add&mod_code=${r'${af.map.mod_code}'}';" />&nbsp;
        <input class="but2" type="button" name="batdel" value="批量删除" onclick="confirmDeleteAll(document.getElementById('listForm'));"/>
    </div>
    <div class="rtab2">
        <%@ include file="/commons/pages/messages.jsp" %>
	    <form id="listForm" name="listForm" method="post" action="${class_name}.do">
		  <input type="hidden" name="method" id="method" value="delete" />
	      <input type="hidden" name="mod_code" id="mod_code" value="${r'${af.map.mod_code}'}" />
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr class="tt2c">
	          <td colspan="${column_count + 2}">${r'${naviString}'}列表</td>
	        </tr>
	        <tr class="tt2c">
	          <td width="3%" align="center" ><input name="chkAll" type="checkbox" id="chkAll" value="-1" onclick="checkAll(this);" /></td>
	<#list columnInfoList as x> 
		<#if x.column_comment?? && x.list_hidden != true>
	          <td nowrap="nowrap">${x.column_comment}</td>	
		</#if>
	</#list>          
	          <td width="10%" nowrap="nowrap" align="center">操作</td>
	        </tr>
	        <c:forEach var="cur" items="${r'${entityList}'}" varStatus="vs">
	          <tr>
	            <td align="center" nowrap="nowrap"><input name="pks" type="checkbox" id="pks" value="${r'${'}cur.${first_column}}" /></td>
	<#list columnInfoList as x> 
		<#if x.column_comment?? && x.list_hidden != true>
				<#if x.ibatis_db_type?contains("DATETIME")>
					<td align="center" nowrap="nowrap"><fmt:formatDate value="${r'${'}cur.${x.column_name?lower_case}}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<#elseif x.ibatis_db_type?contains("DATE") || x.ibatis_db_type?contains("TIMESTAMP")>
					<td align="center" nowrap="nowrap"><fmt:formatDate value="${r'${'}cur.${x.column_name?lower_case}}" pattern="yyyy-MM-dd"/></td>
				<#else>
					<td align="left">${r'${'}fn:escapeXml(cur.${x.column_name?lower_case})}</td>
				</#if>
		</#if>
	</#list>
	            <td align="center" nowrap="nowrap"><span style="cursor:pointer; margin:0 7px 0 7px;" onclick="confirmUpdate(null, '${class_name}.do', '${first_column}=${r'${'}cur.${first_column}}&' + $('#bottomPageForm').serialize())">修改</span><span style="cursor:pointer; margin-left:7px;" onclick="confirmDelete(null, '${class_name}.do', '${first_column}=${r'${'}cur.${first_column}}&' + $('#bottomPageForm').serialize())">删除</span></td>
	          </tr>
	          <c:if test="${r'${'}vs.last eq true}">
	            <c:set var="i" value="${r'${'}vs.count}" />
	          </c:if>
	        </c:forEach>
	        <c:forEach begin="${r'${'}i}" end="${r'${'}af.map.pager.pageSize - 1}">
	          <tr align="center">
	            <td>&nbsp;</td>
	<#list columnInfoList as x> 
		<#if x.column_comment?? && x.list_hidden != true>
	            <td>&nbsp;</td>       	
		</#if>
	</#list>            
	            <td>&nbsp;</td>
	          </tr>
	        </c:forEach>        
	      </table>
	    </form>
    </div>
    <div class="position">
	    <form id="bottomPageForm" name="bottomPageForm" method="post" action="${class_name}.do">
	      <table width="99%" border="0" cellpadding="0" cellspacing="0">
	        <tr>
	          <td height="40" align="center">
	              <script type="text/javascript" src="${r'${ctx}'}/commons/scripts/pager.js">;</script> 
	              <script type="text/javascript">
		            var pager = new Pager(document.bottomPageForm, ${r'${'}af.map.pager.recordCount}, ${r'${'}af.map.pager.pageSize}, ${r'${'}af.map.pager.currentPage});
		            pager.addHiddenInputs("method", "list");
		            pager.addHiddenInputs("mod_code", "${r'$'}{af.map.mod_code}");
		<#list columnInfoList as x> 
			<#if x.column_comment?? && x.query_hidden != true>
				<#if x.is_like>
					pager.addHiddenInputs("${x.column_name?lower_case}_like", "${r'${'}fn:escapeXml(af.map.${x.column_name?lower_case}_like)}");	
				<#else>
					pager.addHiddenInputs("${x.column_name?lower_case}", "${r'${'}fn:escapeXml(af.map.${x.column_name?lower_case})}");	
				</#if>
			</#if>
		</#list>  			
		            document.write(pager.toString());
	              </script>
	            </td>
	        </tr>
	      </table>
	    </form>
   </div>
   <div class="clear"></div>
  </div>
  <div class="clear"></div>
</div>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/jquery.js"></script> 
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/rowEffect.js"></script> 
<script type="text/javascript">//<![CDATA[
$(document).ready(function(){
	// javascript...
});
//]]></script>
</body>
</html>