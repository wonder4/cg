package com.ebiz.baida.middle.domain;

import java.io.Serializable;
import java.util.List;

import module.db.BaseDbOper;

/**
 * @author Hui,Gang
 * @version Build 2010-8-12 下午04:37:40
 */
public class TableInfo extends BaseDomain implements Serializable {

	private static final long serialVersionUID = -1L;

	private String table_name;

	private String db_type;

	private String query_type;

	private String query_sql;

	private String table_names;

	private BaseDbOper baseDbOper;

	private String table_schema;

	private List<ColumnInfo> columnInfoList;

	public TableInfo() {

	}

	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String tableName) {
		table_name = tableName;
	}

	public List<ColumnInfo> getColumnInfoList() {
		return columnInfoList;
	}

	public void setColumnInfoList(List<ColumnInfo> columnInfoList) {
		this.columnInfoList = columnInfoList;
	}

	public String getDb_type() {
		return db_type;
	}

	public void setDb_type(String dbType) {
		db_type = dbType;
	}

	public String getQuery_type() {
		return query_type;
	}

	public void setQuery_type(String queryType) {
		query_type = queryType;
	}

	public String getQuery_sql() {
		return query_sql;
	}

	public void setQuery_sql(String querySql) {
		query_sql = querySql;
	}

	public String getTable_names() {
		return table_names;
	}

	public void setTable_names(String tableNames) {
		table_names = tableNames;
	}

	public BaseDbOper getBaseDbOper() {
		return baseDbOper;
	}

	public void setBaseDbOper(BaseDbOper baseDbOper) {
		this.baseDbOper = baseDbOper;
	}

	public String getTable_schema() {
		return table_schema;
	}

	public void setTable_schema(String tableSchema) {
		table_schema = tableSchema;
	}

}