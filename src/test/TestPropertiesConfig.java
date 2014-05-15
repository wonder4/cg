package test;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ebiz.baida.middle.domain.PropertiesConfig;

/**
 * @author Hui,Gang
 * @version Build 2011-2-15 下午02:12:44
 */

public class TestPropertiesConfig {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(new String[] { "spring-context.xml" });
		PropertiesConfig p = (PropertiesConfig) ctx.getBean("propertiesConfig");

		System.out.println(p.getJdbc_driverClassName());
		System.out.println(p.getTable_schema());
		// System.out.println(p.getAutogc_config_dbtype());
		System.out.println(p.getAutogc_config_output_project_name());
		System.out.println(p.getAutogc_config_output_alltables());
		System.out.println(p.getAutogc_config_output_table_names());
		System.out.println(p.getAutogc_config_output_table_querysql());
		System.out.println(p.getProject_base_directory());
		System.out.println(p.getProject_base_package());
		System.out.println(p.getProject_base_directory());
	}
}
