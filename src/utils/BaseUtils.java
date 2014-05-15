package utils;

import org.apache.commons.lang.StringUtils;

/**
 * @author Hui,Gang
 * @version Build 2010-8-13 下午12:10:42
 */

public class BaseUtils {

	public static void main(String[] args) {
		String s = "manager";

		System.out.print(setFirstWordUpperCase(s));
	}

	public static String ChangeClassName(String className) {
		String[] classNames = StringUtils.split(className, "_");

		StringBuffer sb = new StringBuffer();
		for (String _className : classNames) {
			sb.append(setFirstWordUpperCase(_className));
		}

		return sb.toString();
	}

	public static String setFirstWordUpperCase(String str) {
		StringBuffer sb = new StringBuffer();
		sb.append(StringUtils.upperCase(StringUtils.substring(str, 0, 1)));
		sb.append(StringUtils.lowerCase(StringUtils.substring(str, 1)));
		return sb.toString();
	}
}
