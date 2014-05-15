<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE sqlMapConfig 
		PUBLIC "-//ibatis.apache.org//DTD SQL Map Config 2.0//EN" 
		"http://ibatis.apache.org/dtd/sql-map-config-2.dtd">

<#include "/copyright_xml.ftl">
<sqlMapConfig>
	<settings cacheModelsEnabled="false" enhancementEnabled="false" lazyLoadingEnabled="true"
		useStatementNamespaces="false" statementCachingEnabled="true" classInfoCacheEnabled="true" />
<#if db_type == 'oracle'>

	<typeHandler jdbcType="BLOB" javaType="[B" callback="org.springframework.orm.ibatis.support.BlobByteArrayTypeHandler" />
	<typeHandler jdbcType="CLOB" javaType="java.lang.String" callback="org.springframework.orm.ibatis.support.ClobStringTypeHandler" />
</#if>

<#list tableInfoList as x>
	<sqlMap resource="${base_package}/${project_name}/dao/ibatis/maps/${x.table_name?upper_case}_SqlMap.xml" />
</#list>

</sqlMapConfig>