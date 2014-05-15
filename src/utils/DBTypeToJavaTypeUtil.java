package utils;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

/**
 * @author Hui,Gang
 * @version Build 2010-8-13 下午02:39:37
 * @version Build 2010-8-23 下午11:04:39
 */

public class DBTypeToJavaTypeUtil {

	private static Map<String, String> typeCcollections = null;

	static {
		typeCcollections = new HashMap<String, String>();

		typeCcollections.put("INT", "Long");
		typeCcollections.put("NUMBER", "Long");
		

		typeCcollections.put("INT_MYSQL", "Integer");
		typeCcollections.put("NUMBER_MYSQL", "Integer");

		typeCcollections.put("INT_ORACLE", "Long");
		typeCcollections.put("NUMBER_ORACLE", "Long");

		typeCcollections.put("CLOB", "String");
		typeCcollections.put("CHAR", "String");
		typeCcollections.put("VARCHAR", "String");
		typeCcollections.put("VARCHAR2", "String");
		typeCcollections.put("NVARCHAR2", "String");
		typeCcollections.put("DATE", "Date");
		typeCcollections.put("DATETIME", "Date");
		typeCcollections.put("TIMESTAMP", "Date");

		typeCcollections.put("BIT", "Integer");
		typeCcollections.put("DECIMAL", "BigDecimal");
		typeCcollections.put("TEXT", "String");
		typeCcollections.put("ROWID", "String");
		typeCcollections.put("LONGTEXT", "String");

		// oracle
		typeCcollections.put("FLOAT_NUMBER", "BigDecimal");// ORACLE中的小数，如number(14,4)，用于精确计算

		// 有些类型需要导入类
		typeCcollections.put("Date_impl", "import java.util.Date;");
		typeCcollections.put("BigDecimal_impl", "import java.math.BigDecimal;");

	}

	public static String getJavaType(String db_type) {
		return typeCcollections.get(StringUtils.upperCase(db_type));
	}

	/**
	 * @desc 有些字段会根据数据库不同而使用不同的类型。
	 * @author Hui,Gang
	 * @version Build 2013-7-8 下午03:28:32
	 */
	public static String getJavaType(String db_type, String db) {
		String t = typeCcollections.get(StringUtils.upperCase(db_type.concat("_").concat(db)));

		if (null == t) {
			return typeCcollections.get(StringUtils.upperCase(db_type));
		}

		return t;
	}

	public static String getImportClass(String java_type) {
		return typeCcollections.get(java_type.concat("_impl"));
	}

	public static void main(String[] args) {
		System.out.print(getJavaType("int"));
	}
}
