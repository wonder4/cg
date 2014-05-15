package test;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import module.db.BaseDbOper;
import module.db.impl.MySqlDbOper;
import module.db.impl.OracleDbOper;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.PropertiesConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.Facade;

public class TestNewGenerateCode {

	protected static final Logger logger = LoggerFactory.getLogger(TestNewGenerateCode.class);

	public static void main(String[] args) throws Exception {
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(new String[] { "spring-context.xml" });

		Facade facade = (Facade) ctx.getBean("facade");
		PropertiesConfig propertiesConfig = (PropertiesConfig) ctx.getBean("propertiesConfig");

		String project_name = propertiesConfig.getAutogc_config_output_project_name();

		StringBuffer basePathSb = new StringBuffer();

		// 生成文件的路径
		basePathSb.append(propertiesConfig.getAutogc_config_output_base_directory()).append("/").append(project_name);
		String root_path = basePathSb.toString();

		// 代码的目录结构
		basePathSb.append(propertiesConfig.getProject_base_directory()).append(
				propertiesConfig.getProject_base_package()).append(project_name);

		String base_path = basePathSb.toString();
		String base_package = StringUtils.join(StringUtils.split(propertiesConfig.getProject_base_package(), "/"), ".");

		List<TableInfo> tableInfoList = null;

		BaseDbOper bdo = null;
		String db_type = "";
		if (StringUtils.indexOfIgnoreCase(propertiesConfig.getJdbc_driverClassName(), "oracle") != -1) {
			db_type = "oracle";
			bdo = new OracleDbOper();
		} else if (StringUtils.indexOfIgnoreCase(propertiesConfig.getJdbc_driverClassName(), "mysql") != -1) {
			db_type = "mysql";
			bdo = new MySqlDbOper();
		}

		String all_tables = propertiesConfig.getAutogc_config_output_alltables();
		String table_names = propertiesConfig.getAutogc_config_output_table_names();
		String execute_sql = propertiesConfig.getAutogc_config_output_table_querysql();

		TableInfo tableInfo = new TableInfo();
		tableInfo.setDb_type(db_type);

		if ("true".equals(all_tables)) {// 生成当前用户下的所有表
			bdo.setAllTablesQuerySql();
		} else if (StringUtils.isNotBlank(table_names)) {
			bdo.setCustomizeTablesQuerySql(table_names);
		} else if (StringUtils.isNotBlank(execute_sql)) {
			bdo.setCustomizeQuerySql(execute_sql);
		} else {
			bdo.setAllTablesQuerySql();
		}

		tableInfo.setTable_schema(propertiesConfig.getTable_schema());
		tableInfo.setBaseDbOper(bdo);

		tableInfoList = facade.getTableInfoService().getTableInfoList(tableInfo);

		if (null == tableInfoList) {
			return;
		}

		GenerateCodeConfig generateCodeConfig = new GenerateCodeConfig();
		generateCodeConfig.setFacade(facade);
		generateCodeConfig.setBasePackage(base_package);
		generateCodeConfig.setBasePath(base_path);
		generateCodeConfig.setProject_name(project_name);
		generateCodeConfig.setDb_type(db_type);

		for (TableInfo ti : tableInfoList) {
			facade.getGenerateDomainService().generateDomain(ti, generateCodeConfig);
			facade.getGenerateDaoService().generateDao(ti, generateCodeConfig);
			facade.getGenerateDaoSqlMapImplService().generateDaoSqlMapImpl(ti, generateCodeConfig);
			facade.getGenerateSqlMapService().generateSqlMap(ti, generateCodeConfig);
			facade.getGenerateServiceService().generateService(ti, generateCodeConfig);
			facade.getGenerateServiceImplService().generateServiceImpl(ti, generateCodeConfig);

			facade.getGenerateActionService().generateAction(ti, generateCodeConfig);

			// 生成JSP页面
			if ("true".equals(propertiesConfig.getProject_generator_jsp_files())) {
				facade.getGenerateJspFormService().generateJspForm(ti, propertiesConfig);
				facade.getGenerateJspListService().generateJspList(ti, propertiesConfig);
				facade.getGenerateJspViewService().generateJspView(ti, propertiesConfig);
			}
		}

		// facade
		facade.getGenerateFacadeService().generateFacade(tableInfo, generateCodeConfig, tableInfoList);

		// facadeImpl
		facade.getGenerateFacadeImplService().generateFacadeImpl(tableInfo, generateCodeConfig, tableInfoList);

		// sqlmap-config.xml
		generateCodeConfig.setBasePackage(StringUtils.join(StringUtils.split(
				propertiesConfig.getProject_base_package(), "/"), "/"));
		generateCodeConfig.setBasePath(root_path + propertiesConfig.getProject_base_directory());
		facade.getGenerateSqlMapConfigService().generateSqlMapConfig(tableInfo, generateCodeConfig, tableInfoList);

		logger.info("原始生成目录==>{}", root_path);

		// 生成的目录增加时间戳
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("_yyyyMMddHHmmss");
		FileUtils.moveDirectory(new File(root_path), new File(root_path + sdf.format(now)));

		// 打开生成目录
		java.awt.Desktop.getDesktop().open(new File(propertiesConfig.getAutogc_config_output_base_directory()));
	}
}
