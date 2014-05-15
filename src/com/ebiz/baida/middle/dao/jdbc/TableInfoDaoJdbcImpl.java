package com.ebiz.baida.middle.dao.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;
import org.springframework.stereotype.Repository;

import com.ebiz.baida.middle.dao.TableInfoDao;
import com.ebiz.baida.middle.domain.ColumnInfo;
import com.ebiz.baida.middle.domain.TableInfo;

/**
 * @author Hui,Gang
 * @version Build 2010-8-12 下午04:40:05
 * @version Build 2010-8-17 上午11:16:53
 * @version Build 2010-8-18 下午05:33:08
 */
@Repository
public class TableInfoDaoJdbcImpl extends SimpleJdbcDaoSupport implements TableInfoDao {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	ParameterizedRowMapper<ColumnInfo> rowMapperForColumnInfoList = new ParameterizedRowMapper<ColumnInfo>() {
		public ColumnInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
			ColumnInfo columnInfo = new ColumnInfo();
			columnInfo.setColumn_name(rs.getString("column_name"));
			columnInfo.setColumn_type(rs.getString("data_type"));
			// columnInfo.setColumn_comment(rs.getString("column_comment"));
			columnInfo.setColumn_length(rs.getString("column_length"));
			columnInfo.setData_precision(rs.getString("data_precision"));
			columnInfo.setData_scale(rs.getString("data_scale"));

			String comment = StringUtils.replace(rs.getString("column_comment"), "\n", "");
			String acg = StringUtils.substringBetween(comment, "[acg:", "]");
			if (StringUtils.isBlank(acg)) {// comment中没有注明需要特殊处理的
				columnInfo.setColumn_comment(comment);
			} else {
				// 各模块是否显示
				if (StringUtils.indexOf(comment, "l0") != -1) {// list_hidden
					columnInfo.setList_hidden(true);
				}
				if (StringUtils.indexOf(comment, "f0") != -1) {// form_hidden
					columnInfo.setForm_hidden(true);
				}
				if (StringUtils.indexOf(comment, "q1") != -1) {// query_hidden
					columnInfo.setIs_like(true);
				} else if (StringUtils.indexOf(comment, "q0") != -1) {// query_hidden
					columnInfo.setQuery_hidden(true);
				}
				if (StringUtils.indexOf(comment, "m0") != -1) {// must_input
					columnInfo.setNo_must_input(true);
				}

				// 在页面显示的方式
				if (StringUtils.indexOf(comment, "checkbox") != -1) {// checkbox
					columnInfo.setHtml_node_type("checkbox");
				} else if (StringUtils.indexOf(comment, "radio") != -1) {// radio
					columnInfo.setHtml_node_type("radio");
				} else if (StringUtils.indexOf(comment, "textarea") != -1) {// textarea
					columnInfo.setHtml_node_type("textarea");
				} else if (StringUtils.indexOf(comment, "select") != -1) {// select
					columnInfo.setHtml_node_type("select");
				}

				if (StringUtils.isNotBlank(columnInfo.getHtml_node_type())) {
					String[] node_values = StringUtils.split(StringUtils.substringBetween(comment, "{", "}"), ",");
					if (null != node_values) {
						Map<String, String> html_node_values = new HashMap<String, String>();
						for (String v : node_values) {
							html_node_values.put(StringUtils.substringBefore(v, ":"), StringUtils
									.substringAfter(v, ":"));
						}
						columnInfo.setHtml_node_values(html_node_values);
					}
				}
				columnInfo.setColumn_comment(comment.replace("[acg:" + acg + "]", ""));
			}

			return columnInfo;
		}
	};

	ParameterizedRowMapper<TableInfo> rowMapperForTableInfoList = new ParameterizedRowMapper<TableInfo>() {
		public TableInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
			TableInfo tableInfo = new TableInfo();
			tableInfo.setTable_name(rs.getString("table_name"));
			tableInfo.setTable_schema(rs.getString("table_schema"));
			return tableInfo;
		}
	};

	public List<TableInfo> selectEntityList(TableInfo t) throws DataAccessException {
		List<TableInfo> tableInfoList = null;

		tableInfoList = super.getSimpleJdbcTemplate().query(t.getBaseDbOper().getQuerySql(), rowMapperForTableInfoList,
				new BeanPropertySqlParameterSource(t));

		if (null == tableInfoList) {
			logger.info("【not found any tables!】");
			return null;
		}

		for (TableInfo ti : tableInfoList) {
			List<ColumnInfo> columnInfoList = null;
			columnInfoList = super.getSimpleJdbcTemplate().query(t.getBaseDbOper().getOneTableQuerySql(),
					rowMapperForColumnInfoList, new BeanPropertySqlParameterSource(ti));

			ti.setColumnInfoList(columnInfoList);
		}

		return tableInfoList;
	}

	@Override
	public int deleteEntity(TableInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Long insertEntity(TableInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TableInfo selectEntity(TableInfo t) throws DataAccessException {
		StringBuffer sb = new StringBuffer();

		List<ColumnInfo> columnInfoList = null;

		sb
				.append("select t.column_name , t.data_type from User_Tab_Columns t where T.TABLE_NAME =:table_name order by t.COLUMN_ID asc ");
		columnInfoList = super.getSimpleJdbcTemplate().query(sb.toString(), rowMapperForColumnInfoList,
				new BeanPropertySqlParameterSource(t));

		t.setColumnInfoList(columnInfoList);

		return t;
	}

	@Override
	public Long selectEntityCount(TableInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TableInfo> selectEntityPaginatedList(TableInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateEntity(TableInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return 0;
	}

	protected String getConditionSql(TableInfo t) {
		StringBuffer sb = new StringBuffer();
		// like CONCAT('%', :contact, '%')"

		if (StringUtils.isNotBlank(t.getTable_names())) {
			sb.append("and table_name in ('");
			sb.append(StringUtils.join(StringUtils.split(t.getTable_names(), ","), "','"));
			sb.append("')");
		}

		return sb.toString();
	}
}