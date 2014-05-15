package com.ebiz.baida.middle.domain;

import java.io.Serializable;

import com.ebiz.baida.middle.service.Facade;

/**
 * @author Hui,Gang
 * @version Build 2010-8-17 上午09:59:39
 */
public class GenerateCodeConfig extends BaseDomain implements Serializable {

	private static final long serialVersionUID = -1L;

	private Facade facade;

	private TableInfo tableInfo;

	private String project_name;

	private String basePackage;

	private String basePath;

	private String execute_sql;

	private String db_type;

	public GenerateCodeConfig() {

	}

	public Facade getFacade() {
		return facade;
	}

	public void setFacade(Facade facade) {
		this.facade = facade;
	}

	public TableInfo getTableInfo() {
		return tableInfo;
	}

	public void setTableInfo(TableInfo tableInfo) {
		this.tableInfo = tableInfo;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String projectName) {
		project_name = projectName;
	}

	public String getBasePackage() {
		return basePackage;
	}

	public void setBasePackage(String basePackage) {
		this.basePackage = basePackage;
	}

	public String getBasePath() {
		return basePath;
	}

	public void setBasePath(String basePath) {
		this.basePath = basePath;
	}

	public String getExecute_sql() {
		return execute_sql;
	}

	public void setExecute_sql(String executeSql) {
		execute_sql = executeSql;

	}

	public String getDb_type() {
		return db_type;
	}

	public void setDb_type(String dbType) {
		db_type = dbType;
	}
}