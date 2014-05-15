package module.db.impl;

import module.db.BaseDbOper;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Hui,Gang
 * @version Build 2010-8-18 下午04:20:36
 */

public class OracleDbOper implements BaseDbOper {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private String query_sql = "select table_name, tablespace_name table_schema from user_tables where 1 = 1";

	private String query_one_table_sql = "select a.column_name, a.data_type, b.comments column_comment, a.data_length column_length,a.data_precision, a.data_scale from (select * from User_Tab_Columns t where T.TABLE_NAME =:table_name) a left join (SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME =:table_name) b on a.column_name = b.column_name order by a.COLUMN_ID asc";

	public void setAllTablesQuerySql() {
		// set query_all_table_sql;
	}

	public void setCustomizeTablesQuerySql(String table_names) {
		if (null == table_names) {
			return;
		}

		StringBuffer sb = new StringBuffer(" and table_name in ('");
		sb.append(StringUtils.join(StringUtils.split(table_names, ","), "','"));
		sb.append("')");

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
