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
      <html-el:form action="/admin/${class_name}">
		<html-el:hidden property="method" value="list" />
		<html-el:hidden property="mod_id" />
	    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="tableClassSearch">
	      <tr>
	        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" align="left">
	            <tr><td>
	<#assign haveDate = ""> 
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
	 			<#lt><html-el:text property="${x.column_name?lower_case}_like" style="width:90px;" maxlength="20" styleId="${x.column_name?lower_case}_like" styleClass="webinput" />
	 		<#else>
	 			<#lt><html-el:text property="${x.column_name?lower_case}" style="width:90px;" maxlength="20" styleId="${x.column_name?lower_case}" styleClass="webinput" />
	 		</#if>
		</#if>
	</#list>  	            
	                &nbsp;
	                <input type="button" value="查 询" class="bgButton" id="btn_submit" /></td>
	            </tr>
	          </table></td>
	      </tr>
	    </table>
	  </html-el:form>
	  <%@ include file="/commons/pages/messages.jsp" %>
	  <html-el:form action="/admin/${class_name}">
	    <div style="padding-bottom:5px;">
	      <logic-el:match name="popedom" value="+4+">
	        <input type="button" name="delete" id="delete" class="bgButton" value="删除所选" onclick="this.form.action += '?method=delete&' + $('#bottomPageForm').serialize();confirmDeleteAll(this.form);" />
	      </logic-el:match>
	      <logic-el:match name="popedom" value="+1+">
	        <input type="button" name="add" id="add" class="bgButton" value="添加" onclick="location.href='${class_name}.do?method=add&mod_id=${r'${af.map.mod_id}'}';" />
	      </logic-el:match>
		  <input type="hidden" name="method" id="method" value="delete" />
	      <input type="hidden" name="mod_id" id="mod_id" value="${r'${af.map.mod_id}'}" />
	    </div>
		<table width="100%" border="0" cellpadding="1" cellspacing="1" class="tableClass">
	      <tr>
	        <th width="5%" nowrap="nowrap"> <c:if test="${r'$'}{fn:contains(popedom, '+4+')}" var="isDelete">
	            <input name="chkAll" type="checkbox" id="chkAll" value="-1" onclick="checkAll(this);" />
	          </c:if>
	          <c:if test="${r'$'}{not isDelete}"> 序号 </c:if>
	        </th>
	<#list columnInfoList as x> 
		<#if x.column_comment?? && x.list_hidden != true>
	          <th nowrap="nowrap">${x.column_comment}</th>	
		</#if>
	</#list> 
	        <c:if test="${r'$'}{fn:contains(popedom, '+2+') or fn:contains(popedom, '+4+') or fn:contains(popedom, '+8+')}" var="isContains">
	          <th width="10%" nowrap="nowrap">操作</th>
	        </c:if>
	      </tr>
      <c:forEach var="cur" items="${r'${entityList}'}" varStatus="vs">
	      <tr align="center">
          	<td nowrap="nowrap"><c:if test="${r'$'}{fn:contains(popedom, '+4+')}" var="isDelete">
              <input name="pks" type="checkbox" id="pks_${r'$'}{cur.id}" value="${r'$'}{cur.id}" />
            </c:if>
            <c:if test="${r'$'}{not isDelete}"> ${r'$'}{vs.count} </c:if></td>
<#list columnInfoList as x> 
	<#if x.column_comment?? && x.list_hidden != true>
		<#if x.ibatis_db_type?contains("DATETIME")>
			<td align="center" nowrap="nowrap"><fmt:formatDate value="${r'${'}cur.${x.column_name?lower_case}}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		<#elseif x.ibatis_db_type?contains("DATE") || x.ibatis_db_type?contains("TIMESTAMP")>
			<td align="center" nowrap="nowrap"><fmt:formatDate value="${r'${'}cur.${x.column_name?lower_case}}" pattern="yyyy-MM-dd"/></td>
		<#elseif x.ibatis_db_type?contains("DECIMAL") || x.ibatis_db_type?contains("INTEGER")>	
			<td align="right" nowrap="nowrap">${r'$'}{cur.${x.column_name?lower_case}}</td>
		<#else>
			<td align="left"><#rt><#if x.html_node_type?has_content>
					<#if x.html_node_type == "checkbox" || x.html_node_type == "radio" || x.html_node_type == "select">
						<#lt><c:choose>					
						<#list x.html_node_values?keys as mapKey> 
								<c:when test="${r'$'}{'${mapKey}' eq cur.${x.column_name?lower_case}}">${x.html_node_values[mapKey]}</c:when>
						</#list>
						</c:choose><#rt>
					<#elseif x.html_node_type == "textarea">
						<#lt>${'$'}{fn:replace(fn:escapeXml(cur.${x.column_name?lower_case}), g_java_n, g_html_br)}<#rt>
					</#if>
				<#else>
					<#lt>${r'$'}{fn:escapeXml(cur.${x.column_name?lower_case})}<#rt>
				</#if><#lt></td>
		</#if>
	</#if>
</#list>
          <c:if test="${r'$'}{isContains}" >
            <td nowrap="nowrap"><logic-el:match name="popedom" value="+0+">
				<a class="butbase" href="javascript:void(0);"><span class="icon-search" onclick="doNeedMethod(null, '${class_name}.do', 'view','${first_column}=${r'$'}{cur.${first_column}}&mod_id=${r'$'}{af.map.mod_id}')">查看</span></a>
			  </logic-el:match>
              <logic-el:match name="popedom" value="+8+">
				<a class="butbase" href="javascript:void(0);"><span class="icon-ok" onclick="doNeedMethod(null, '${class_name}.do', 'audit','${first_column}=${r'$'}{cur.${first_column}}&mod_id=${r'$'}{af.map.mod_id}&'+${r'$'}('#bottomPageForm').serialize())">审核</span></a>
			  </logic-el:match>
              <logic-el:match name="popedom" value="+2+">
                <a class="butbase" href="javascript:void(0);"><span class="icon-edit" onclick="confirmUpdate(null, '${class_name}.do', '${first_column}=${r'$'}{cur.${first_column}}&' + ${r'$'}('#bottomPageForm').serialize())">修改</span></a>
              </logic-el:match>
              <logic-el:match name="popedom" value="+4+">
                <a class="butbase" href="javascript:void(0);"><span class="icon-remove" onclick="confirmDelete(null, '${class_name}.do', '${first_column}=${r'$'}{cur.${first_column}}&' + ${r'$'}('#bottomPageForm').serialize())">删除</span></a>
              </logic-el:match></td>
          </c:if>
        <c:if test="${r'$'}{vs.last eq true}">
          <c:set var="i" value="${r'$'}{vs.count}" />
        </c:if>
	      </tr>
      </c:forEach>
        <c:forEach begin="${r'${'}i}" end="${r'${'}af.map.pager.pageSize - 1}">
          <tr align="center">
            <td>&nbsp;</td>
<#list columnInfoList as x> 
	<#if x.column_comment?? && x.list_hidden != true>
            <td>&nbsp;</td>       	
	</#if>
</#list>            
            <c:if test="${r'$'}{isContains}"><td>&nbsp;</td></c:if>
          </tr>
        </c:forEach>
    </table>
  </html-el:form>
  <div class="pageClass">
    <form id="bottomPageForm" name="bottomPageForm" method="post" action="${class_name}.do">
      <table width="98%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="10"><script type="text/javascript" src="${r'$'}{ctx}/commons/scripts/pager.js">;</script> 
            <script type="text/javascript">
	            var pager = new Pager(document.bottomPageForm, ${r'${'}af.map.pager.recordCount}, ${r'${'}af.map.pager.pageSize}, ${r'${'}af.map.pager.currentPage});
	            pager.addHiddenInputs("method", "list");
	            pager.addHiddenInputs("mod_id", "${r'$'}{af.map.mod_id}");
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
            	</script></td>
        </tr>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/jquery.js"></script> 
<script type="text/javascript" src="${r'${ctx}'}/scripts/rowEffect.js"></script> 
<#if haveDate?length &gt; 0>
<script type="text/javascript" src="${r'${ctx}'}/commons/scripts/calendar/WdatePicker.js"></script> 
</#if>
<script type="text/javascript">//<![CDATA[
$(document).ready(function(){
	$("#btn_submit").click(function(){
		this.form.submit();
	});
});
//]]></script>
<jsp:include page="../_global_manager_page_bottom.jsp" flush="true" />
</body>
</html>