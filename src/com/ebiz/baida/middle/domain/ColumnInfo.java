package com.ebiz.baida.middle.domain;

import java.io.Serializable;
import java.util.Map;

/**
 * @author Hui,Gang
 * @version Build 2010-8-12 下午04:37:40
 */
public class ColumnInfo extends BaseDomain implements Serializable {

	private static final long serialVersionUID = -1L;

	private String column_name;

	private String column_type;

	private String column_comment;

	private String column_length;

	private String java_type;

	private String ibatis_db_type;

	private boolean list_hidden;

	private boolean form_hidden;

	private boolean query_hidden;

	private boolean no_must_input;

	private String html_node_type;

	private boolean is_like;

	private String data_precision;

	private String data_scale;

	private Map<String, String> html_node_values;

	public ColumnInfo() {

	}

	public String getData_scale() {
		return data_scale;
	}

	public void setData_scale(String dataScale) {
		data_scale = dataScale;
	}

	public String getColumn_name() {
		return column_name;
	}

	public void setColumn_name(String columnName) {
		column_name = columnName;
	}

	public String getColumn_type() {
		return column_type;
	}

	public void setColumn_type(String columnType) {
		column_type = columnType;
	}

	public String getJava_type() {
		return java_type;
	}

	public void setJava_type(String javaType) {
		java_type = javaType;
	}

	public String getColumn_comment() {
		return column_comment;
	}

	public void setColumn_comment(String columnComment) {
		column_comment = columnComment;
	}

	public String getColumn_length() {
		return column_length;
	}

	public void setColumn_length(String columnLength) {
		column_length = columnLength;
	}

	public String getIbatis_db_type() {
		return ibatis_db_type;
	}

	public void setIbatis_db_type(String ibatisDbType) {
		ibatis_db_type = ibatisDbType;
	}

	public boolean isList_hidden() {
		return list_hidden;
	}

	public void setList_hidden(boolean listHidden) {
		list_hidden = listHidden;
	}

	public boolean isForm_hidden() {
		return form_hidden;
	}

	public void setForm_hidden(boolean formHidden) {
		form_hidden = formHidden;
	}

	public boolean isQuery_hidden() {
		return query_hidden;
	}

	public void setQuery_hidden(boolean queryHidden) {
		query_hidden = queryHidden;
	}

	public boolean isNo_must_input() {
		return no_must_input;
	}

	public void setNo_must_input(boolean noMustInput) {
		no_must_input = noMustInput;
	}

	public String getHtml_node_type() {
		return html_node_type;
	}

	public void setHtml_node_type(String htmlNodeType) {
		html_node_type = htmlNodeType;
	}

	public boolean isIs_like() {
		return is_like;
	}

	public void setIs_like(boolean isLike) {
		is_like = isLike;
	}

	public Map<String, String> getHtml_node_values() {
		return html_node_values;
	}

	public void setHtml_node_values(Map<String, String> htmlNodeValues) {
		html_node_values = htmlNodeValues;
	}

	public String getData_precision() {
		return data_precision;
	}

	public void setData_precision(String dataPrecision) {
		data_precision = dataPrecision;
	}
}