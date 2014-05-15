package module.db;

/**
 * @author Hui,Gang
 * @version Build 2010-8-18 下午05:05:31
 */

public interface BaseDbOper {

	String getQuerySql();

	String getOneTableQuerySql();

	void setCustomizeTablesQuerySql(String table_names);

	void setAllTablesQuerySql();

	void setCustomizeQuerySql(String query_sql);

}
