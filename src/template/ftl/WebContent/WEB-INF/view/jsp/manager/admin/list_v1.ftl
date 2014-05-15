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
  <div align="center" style="width: 99%">
    <div align="left" class="nav">${r'${naviString}'}</div>
    <br />
    <fieldset>
      <legend>快速搜索</legend>
      <html-el:form action="/admin/${class_name}">
        <html-el:hidden property="method" value="list" />
        <html-el:hidden property="mod_code" value="${r'${af.map.mod_code}'}" />
<#list columnInfoList as x> 
	<#if x.column_comment??>
 		&nbsp;${x.column_comment}：
        <html-el:text property="${x.column_name?lower_case}" size="20" maxlength="20" styleId="${x.column_name?lower_case}" styleClass="webinput" />
	</#if>
</#list>         
        <html-el:submit value="快速搜索" />
      </html-el:form>
    </fieldset>
    <%@ include file="/commons/pages/messages.jsp" %>
    <br/>
    <form id="listForm" name="listForm" method="post" action="${class_name}.do?method=delete">
      <div style="text-align: left">
        <input type="button" name="delete" id="delete" value="删除所选" onclick="confirmDeleteAll(this.form);" />
        <input type="button" name="add" id="add" value="添加" onclick="location.href='${class_name}.do?method=add&mod_code=${r'${af.map.mod_code}'}';" />
        <input type="hidden" name="method" id="method" value="delete" />
        <input type="hidden" name="mod_code" id="mod_code" value="${r'${af.map.mod_code}'}" />
      </div>
      <br/>
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="datagrid">
        <tr>
          <th width="5%" nowrap="nowrap"><input name="chkAll" type="checkbox" id="chkAll" value="-1" onclick="checkAll(this);" /></th>
<#list columnInfoList as x> 
	<#if x.column_comment??>
          <th nowrap="nowrap">${x.column_comment}</th>	
	</#if>
</#list>
          <th width="10%">操作</th>
        </tr>
        <c:forEach var="cur" items="${r'${entityList}'}" varStatus="vs">
          <tr>
            <td align="center" nowrap="nowrap"><input name="pks" type="checkbox" id="pks" value="${r'${'}cur.${first_column}}" /></td>
<#list columnInfoList as x> 
	<#if x.column_comment??>
			<#if x.ibatis_db_type?contains("DATETIME")>
				<td align="center" nowrap="nowrap"><fmt:formatDate value="${r'${'}cur.${x.column_name?lower_case}}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<#elseif x.ibatis_db_type?contains("DATE") || x.ibatis_db_type?contains("TIMESTAMP")>
				<td align="center" nowrap="nowrap"><fmt:formatDate value="${r'${'}cur.${x.column_name?lower_case}}" pattern="yyyy-MM-dd"/></td>
			<#else>
				<td align="left">${r'${'}fn:escapeXml(cur.${x.column_name?lower_case})}</td>
			</#if>
	</#if>
</#list>
            <td align="center"><span style="cursor:pointer; margin:0 7px 0 7px;" onclick="confirmUpdate(null, '${class_name}.do', 'id=${r'${'}cur.id}&' + $('#bottomPageForm').serialize())">修改</span> <span style="cursor:pointer; margin-left:7px;" onclick="confirmDelete(null, '${class_name}.do', 'id=${r'${'}cur.id}&' + $('#bottomPageForm').serialize())">删除</span></td>
          </tr>
          <c:if test="${r'${'}vs.last eq true}">
            <c:set var="i" value="${r'${'}vs.count}" />
          </c:if>
        </c:forEach>
        <c:forEach begin="${r'${'}i}" end="${r'${'}af.map.pager.pageSize - 1}">
          <tr align="center">
            <td>&nbsp;</td>
<#list columnInfoList as x> 
	<#if x.column_comment??>
            <td>&nbsp;</td>       	
	</#if>
</#list>            
            <td>&nbsp;</td>
          </tr>
        </c:forEach>
      </table>
    </form>
    <br />
    <form id="bottomPageForm" name="bottomPageForm" method="post" action="${class_name}.do">
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="40" align="center"><script type="text/javascript" src="${r'${ctx}'}/commons/scripts/pager.js">;</script> 
            <script type="text/javascript">
            var pager = new Pager(document.bottomPageForm, ${r'${'}af.map.pager.recordCount}, ${r'${'}af.map.pager.pageSize}, ${r'${'}af.map.pager.currentPage});
            pager.addHiddenInputs("method", "list");
<#list columnInfoList as x> 
	<#if x.column_comment??>
			pager.addHiddenInputs("${x.column_name?lower_case}", "${r'${'}fn:escapeXml(af.map.${x.column_name?lower_case})}");	
	</#if>
</#list>  			
            document.write(pager.toString());
            </script></td>
        </tr>
      </table>
    </form>
  </div>
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