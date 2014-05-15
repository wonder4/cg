<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd" >

<#include "/copyright_xml.ftl">
<#assign table_name = table_name?upper_case>
<sqlMap namespace="${table_name}">
	<#assign domain_entity = domain_name?uncap_first>
	
	<typeAlias alias="${domain_entity}" type="${base_package}.${project_name}.domain.${domain_name}" />

	<cacheModel id="oneDayCache" type="OSCACHE">
		<flushInterval hours="24" />
		<flushOnExecute statement="insert${domain_name}" />
		<flushOnExecute statement="update${domain_name}" />
		<flushOnExecute statement="delete${domain_name}" />
	</cacheModel>

	<resultMap id="${domain_entity}ResultForList" class="${domain_entity}">
	<#list columnNameAndTypeList as x>
		<result column="${x.column_name?upper_case}" property="${x.column_name?lower_case}" jdbcType="${x.ibatis_db_type}" />
	</#list>	
	</resultMap>

	<resultMap id="${domain_entity}Result" class="${domain_entity}" extends="${domain_entity}ResultForList">
	</resultMap>

	<sql id="sf-${domain_entity}">
<#list columnNameAndTypeList as x>
		<isNotEmpty prepend=" and " property="${x.column_name?lower_case}">${x.column_name?upper_case} = #${x.column_name?lower_case}:${x.ibatis_db_type}#</isNotEmpty>
	<#if x.is_like>
		<isNotEmpty prepend=" and " property="map.${x.column_name?lower_case}_like">${x.column_name?upper_case} like '%' #map.${x.column_name?lower_case}_like# '%'</isNotEmpty>
	</#if>
</#list>	
	</sql>

	<select id="select${domain_name}" resultMap="${domain_entity}Result" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		select * from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
	</select>

	<select id="select${domain_name}List" resultMap="${domain_entity}ResultForList" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		select * from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
		order by ${first_column} desc
		<isNotEmpty property="row.count">
			limit 0, #row.count#
        </isNotEmpty>
	</select>

	<select id="select${domain_name}Count" resultClass="int" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		select count(*) from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
	</select>

	<select id="select${domain_name}PaginatedList" resultMap="${domain_entity}ResultForList" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		select * from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
		order by ${first_column} desc
		<isNotEmpty property="row.count">
			limit #row.first#, #row.count#
        </isNotEmpty>
	</select>

	<insert id="insert${domain_name}" parameterClass="${domain_entity}">
		<![CDATA[insert into ${table_name} (]]>
		<dynamic prepend=" ">
		<#list columnNameAndTypeList as x>
			<isNotNull prepend="," property="${x.column_name?lower_case}">${x.column_name?upper_case}</isNotNull>	
		</#list>			
		</dynamic>
		<![CDATA[) values (]]>
		<dynamic prepend=" ">
		<#list columnNameAndTypeList as x>
			<isNotNull prepend="," property="${x.column_name?lower_case}">#${x.column_name?lower_case}:${x.ibatis_db_type}#</isNotNull>	
		</#list>				
		</dynamic>
		<![CDATA[)]]>
		<selectKey resultClass="int" keyProperty="id">SELECT LAST_INSERT_ID()</selectKey>
	</insert>

	<update id="update${domain_name}" parameterClass="${domain_entity}">
		update ${table_name}
		<dynamic prepend="set">
		<#list columnNameAndTypeList as x>
			<isNotNull prepend="," property="${x.column_name?lower_case}">${x.column_name?upper_case} = #${x.column_name?lower_case}:${x.ibatis_db_type}#</isNotNull>
		</#list>		
		</dynamic>
		where
		<isNotEmpty prepend=" " property="${first_column}">${first_column?upper_case} = #${first_column}#</isNotEmpty>
	</update>

	<delete id="delete${domain_name}" parameterClass="${domain_entity}">
		delete from ${table_name} where
		<isNotEmpty prepend=" " property="${first_column}">${first_column?upper_case} = #${first_column}#</isNotEmpty>
		<isEmpty prepend=" " property="${first_column}">
			<isNotEmpty prepend=" " property="map.pks">
				${first_column?upper_case} in
				<iterate close=")" open="(" conjunction="," property="map.pks">#map.pks[]#</iterate>
			</isNotEmpty>
		</isEmpty>
	</delete>

</sqlMap>