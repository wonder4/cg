package com.ebiz.baida.middle.domain;

import java.io.Serializable;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Hui,Gang
 * @version Build 2011-2-15 下午02:01:53
 */
public class PropertiesConfig extends BaseDomain implements Serializable {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	private static final long serialVersionUID = -1L;

	private String jdbc_driverClassName;

	private String jdbc_url;

	private String jdbc_username;

	private String jdbc_password;

	private String table_schema;

	private String autogc_config_output_project_name;

	private String autogc_config_output_alltables;

	private String autogc_config_output_table_names;

	private String autogc_config_output_table_querysql;

	private String project_base_directory;

	private String project_base_package;

	private String autogc_config_output_base_directory;

	private String project_base_generator_web_files;

	private String project_generator_jsp_files;

	public PropertiesConfig() {

	}

	public String getJdbc_driverClassName() {
		return jdbc_driverClassName;
	}

	public void setJdbc_driverClassName(String jdbcDriverClassName) {
		jdbc_driverClassName = jdbcDriverClassName;
	}

	public String getJdbc_url() {
		return jdbc_url;
	}

	public void setJdbc_url(String jdbcUrl) {
		jdbc_url = jdbcUrl;
	}

	public String getJdbc_username() {
		return jdbc_username;
	}

	public void setJdbc_username(String jdbcUsername) {
		jdbc_username = jdbcUsername;
	}

	public String getJdbc_password() {
		return jdbc_password;
	}

	public void setJdbc_password(String jdbcPassword) {
		jdbc_password = jdbcPassword;
	}

	public String getTable_schema() {
		if (StringUtils.isBlank(table_schema)) {
			table_schema = jdbc_username;
		}

		logger.info("====>table_schema:{}", table_schema);

		return table_schema;
	}

	public void setTable_schema(String tableSchema) {
		table_schema = tableSchema;
	}

	public String getAutogc_config_output_project_name() {
		if (StringUtils.isBlank(autogc_config_output_project_name)) {
			autogc_config_output_project_name = jdbc_username;
		}
		return autogc_config_output_project_name;
	}

	public void setAutogc_config_output_project_name(String autogcConfigOutputProjectName) {
		autogc_config_output_project_name = autogcConfigOutputProjectName;
	}

	public String getAutogc_config_output_alltables() {
		return autogc_config_output_alltables;
	}

	public void setAutogc_config_output_alltables(String autogcConfigOutputAlltables) {
		autogc_config_output_alltables = autogcConfigOutputAlltables;
	}

	public String getAutogc_config_output_table_names() {
		return autogc_config_output_table_names;
	}

	public void setAutogc_config_output_table_names(String autogcConfigOutputTableNames) {
		autogc_config_output_table_names = autogcConfigOutputTableNames;
	}

	public String getAutogc_config_output_table_querysql() {
		return autogc_config_output_table_querysql;
	}

	public void setAutogc_config_output_table_querysql(String autogcConfigOutputTableQuerysql) {
		autogc_config_output_table_querysql = autogcConfigOutputTableQuerysql;
	}

	public String getProject_base_directory() {
		return project_base_directory;
	}

	public void setProject_base_directory(String projectBaseDirectory) {
		project_base_directory = projectBaseDirectory;
	}

	public String getProject_base_package() {
		return project_base_package;
	}

	public void setProject_base_package(String projectBasePackage) {
		project_base_package = projectBasePackage;
	}

	public String getAutogc_config_output_base_directory() {
		return autogc_config_output_base_directory;
	}

	public void setAutogc_config_output_base_directory(String autogcConfigOutputBaseDirectory) {
		autogc_config_output_base_directory = autogcConfigOutputBaseDirectory;
	}

	public String getProject_base_generator_web_files() {
		return project_base_generator_web_files;
	}

	public void setProject_base_generator_web_files(String projectBaseGeneratorWebFiles) {
		project_base_generator_web_files = projectBaseGeneratorWebFiles;
	}

	public String getProject_generator_jsp_files() {
		return project_generator_jsp_files;
	}

	public void setProject_generator_jsp_files(String projectGeneratorJspFiles) {
		project_generator_jsp_files = projectGeneratorJspFiles;
	}

}