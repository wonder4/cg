package utils;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

/**
 * @author Hui,Gang
 * @version Build 2010-8-16 上午10:46:23
 * @version Build 2010-8-23 下午11:04:57
 */
public class DBTypeToIbatisTypeUtil {

	private static Map<String, String> typeCcollections = null;

	static {
		typeCcollections = new HashMap<String, String>();

		typeCcollections.put("INT", "INTEGER");
		typeCcollections.put("NUMBER", "DECIMAL");
		typeCcollections.put("CHAR", "VARCHAR");
		typeCcollections.put("VARCHAR", "VARCHAR");
		typeCcollections.put("VARCHAR2", "VARCHAR");
		typeCcollections.put("NVARCHAR2", "VARCHAR");

		// oracle
		typeCcollections.put("ORACLE_CLOB", "VARCHAR");
		typeCcollections.put("ORACLE_DATE", "DATE");
		typeCcollections.put("ROWID", "VARCHAR");
		
		// mysql
		typeCcollections.put("MYSQL_DATE", "TIMESTAMP");
		typeCcollections.put("MYSQL_DATETIME", "TIMESTAMP");
		typeCcollections.put("MYSQL_TIMESTAMP", "TIMESTAMP");
		typeCcollections.put("MYSQL_BIT", "BIT");
		typeCcollections.put("MYSQL_DECIMAL", "DECIMAL");
		typeCcollections.put("MYSQL_TEXT", "VARCHAR");
		typeCcollections.put("MYSQL_LONGTEXT", "VARCHAR");
	}

	public static String getIbatisDBType(String db_type, String column_name) {
		String ibatisDBType = typeCcollections.get(StringUtils.upperCase(column_name));
		if (null == ibatisDBType) {
			ibatisDBType = typeCcollections.get(StringUtils.upperCase(db_type + "_" + column_name));
		}

		return ibatisDBType;
	}

	public static void main(String[] args) {
		System.out.print(getIbatisDBType("oracle", "int"));
	}
}
