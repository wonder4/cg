<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd" >

<#include "/copyright_xml.ftl">
<sqlMap namespace="${table_name}">
	<#assign domain_entity = domain_name?uncap_first />
	<#assign order_str = "" />
	
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
		<#if x.column_name?upper_case == "ORDER_VALUE">
			<#assign order_str = "ORDER_VALUE desc, " />
		</#if>
	</#list>	
	</resultMap>

	<resultMap id="${domain_entity}Result" class="${domain_entity}" extends="${domain_entity}ResultForList">
	</resultMap>

	<sql id="sf-${domain_entity}">
<#list columnNameAndTypeList as x>
		<isNotEmpty prepend=" and " property="${x.column_name?lower_case}">${x.column_name?upper_case} = #${x.column_name?lower_case}:${x.ibatis_db_type}#</isNotEmpty>
	<#if x.is_like>
		<isNotEmpty prepend=" and " property="map.${x.column_name?lower_case}_like">${x.column_name?upper_case} like '%' || #map.${x.column_name?lower_case}_like# || '%'</isNotEmpty>
	</#if>		
</#list>	
	</sql>

	<select id="select${domain_name}" resultMap="${domain_entity}Result" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		select * from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
	</select>

	<select id="select${domain_name}List" resultMap="${domain_entity}ResultForList" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		<isNotEmpty property="row.count">
			<![CDATA[ select * from ( ]]>
		</isNotEmpty>
		select * from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
		order by ${order_str}${first_column?upper_case} desc
		<isNotEmpty property="row.count">
			<![CDATA[ ) where rownum <= #row.count# ]]>
		</isNotEmpty>
	</select>

	<select id="select${domain_name}Count" resultClass="long" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		select count(*) from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
	</select>

	<select id="select${domain_name}PaginatedList" resultMap="${domain_entity}ResultForList" parameterClass="${domain_entity}" cacheModel="oneDayCache">
		<![CDATA[ select * from ( select t_.*, rownum rn_ from ( ]]>
		select * from ${table_name} where 1 = 1
		<include refid="sf-${domain_entity}" />
		order by ${order_str}${first_column?upper_case} desc
		<![CDATA[ ) t_ where rownum <= (#row.first# + #row.count#)) where rn_ >= (#row.first# + 1) ]]>
	</select>

	<insert id="insert${domain_name}" parameterClass="${domain_entity}">
		<selectKey resultClass="long" keyProperty="id">select SEQ_BASE.nextval as id from dual</selectKey>
		<![CDATA[insert into ${table_name} (]]>
		<dynamic prepend=" ">
		<#list columnNameAndTypeList as x>
			<isNotNull prepend="," property="${x.column_name?lower_case}">${x.column_name?upper_case}</isNotNull>	
		</#list>			
		</dynamic>
		<![CDATA[) values (]]>
		<dynamic prepend=" ">
	<#list columnNameAndTypeList as x>
		<#if x.ibatis_db_type?contains("DATE")>
			<isNotNull prepend="," property="${x.column_name?lower_case}">#${x.column_name?lower_case}:DATETIME#</isNotNull>	
		<#else>	
			<isNotNull prepend="," property="${x.column_name?lower_case}">#${x.column_name?lower_case}:${x.ibatis_db_type}#</isNotNull>	
		</#if>
	</#list>				
		</dynamic>
		<![CDATA[)]]>
	</insert>

	<update id="update${domain_name}" parameterClass="${domain_entity}">
		update ${table_name}
		<dynamic prepend="set">
<#list columnNameAndTypeList as x>
	<#if x.ibatis_db_type?contains("DATE")>	
			<isNotNull prepend="," property="${x.column_name?lower_case}">${x.column_name?upper_case} = #${x.column_name?lower_case}:DATETIME#</isNotNull>		
	<#else>
			<isNotNull prepend="," property="${x.column_name?lower_case}">${x.column_name?upper_case} = #${x.column_name?lower_case}:${x.ibatis_db_type}#</isNotNull>
	</#if>
</#list>		
		</dynamic>
		where
		<isNotEmpty prepend=" " property="${first_column}">${first_column?upper_case} = #${first_column}#</isNotEmpty>
		<isEmpty prepend=" " property="${first_column}">
			<isNotEmpty prepend=" " property="map.pks">
				${first_column?upper_case} in
				<iterate close=")" open="(" conjunction="," property="map.pks">#map.pks[]#</iterate>
			</isNotEmpty>
		</isEmpty>
	</update>

	<delete id="delete${domain_name}" parameterClass="${domain_entity}">
<#assign have_is_del = false />		
<#list columnNameAndTypeList as x>
	<#if x.column_name?upper_case == "IS_DEL">
		<#assign have_is_del = true />		
	</#if>
</#list>			
<#if have_is_del>
		update ${table_name} set is_del = 1 where
<#else>
		delete from ${table_name} where
</#if>	
		<isNotEmpty prepend=" " property="${first_column}">${first_column?upper_case} = #${first_column}#</isNotEmpty>
		<isEmpty prepend=" " property="${first_column}">
			<isNotEmpty prepend=" " property="map.pks">
				${first_column?upper_case} in
				<iterate close=")" open="(" conjunction="," property="map.pks">#map.pks[]#</iterate>
			</isNotEmpty>
		</isEmpty>
	</delete>

</sqlMap>