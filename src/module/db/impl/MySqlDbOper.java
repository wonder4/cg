package module.db.impl;

import module.db.BaseDbOper;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Hui,Gang
 * @version Build 2010-8-19 下午03:30:48
 */
public class MySqlDbOper implements BaseDbOper {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	private String query_sql = " select distinct table_name, table_schema from information_schema.columns where 1 = 1 and table_schema =:table_schema  "; // table_schema

	private String query_one_table_sql = "select column_name, data_type, column_comment, character_maximum_length column_length, '0' as data_scale, numeric_precision as data_precision from information_schema.columns where table_schema =:table_schema and table_name =:table_name ";

	public void setAllTablesQuerySql() {
		// set query_all_table_sql;
	}

	public void setCustomizeTablesQuerySql(String table_names) {
		if (null == table_names) {
			return;
		}

		StringBuffer sb = new StringBuffer(" and table_name in ('");
		sb.append(StringUtils.join(StringUtils.split(table_names, ","), "','"));
		sb.append("') order by ordinal_position asc ");

		this.query_sql += sb.toString();
		
		logger.info(this.query_sql);
	}

	public void setCustomizeQuerySql(String query_sql) {
		this.query_sql = query_sql;
	}

	public String getQuerySql() {
		return query_sql;
	}

	public String getOneTableQuerySql() {
		return query_one_table_sql;
	}

}
