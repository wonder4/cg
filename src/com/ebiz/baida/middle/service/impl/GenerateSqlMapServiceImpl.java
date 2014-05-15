package com.ebiz.baida.middle.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import utils.BaseUtils;
import utils.DBTypeToIbatisTypeUtil;

import com.ebiz.baida.middle.domain.ColumnInfo;
import com.ebiz.baida.middle.domain.FtlPathConfig;
import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.GenerateSqlMapService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:36:37
 */

public class GenerateSqlMapServiceImpl extends BaseFacadeImpl implements GenerateSqlMapService {

	@Resource
	private FtlPathConfig ftlPathConfig;

	@Resource
	TemplateService templateService;

	public void generateSqlMap(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig) {
		String ftl_path = ftlPathConfig.getMaps_ftl_path() + StringUtils.lowerCase(generateCodeConfig.getDb_type())
				+ "_SqlMap.ftl";

		for (ColumnInfo ci : tableInfo.getColumnInfoList()) {
			ci.setIbatis_db_type((DBTypeToIbatisTypeUtil.getIbatisDBType(generateCodeConfig.getDb_type(), ci
					.getColumn_type())));
		}

		String domain_name = BaseUtils.ChangeClassName(tableInfo.getTable_name());
		String dao_name = BaseUtils.ChangeClassName(tableInfo.getTable_name()).concat("Dao");
		String class_name = BaseUtils.ChangeClassName(tableInfo.getTable_name()).concat("DaoSqlMapImpl");

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("project_name", generateCodeConfig.getProject_name());
		model.put("now", new Date());
		model.put("base_package", generateCodeConfig.getBasePackage());
		model.put("table_name", tableInfo.getTable_name());
		model.put("class_name", class_name);
		model.put("domain_name", domain_name);
		model.put("dao_name", dao_name);
		model.put("columnNameAndTypeList", tableInfo.getColumnInfoList());
		model.put("first_column", StringUtils.lowerCase(tableInfo.getColumnInfoList().get(0).getColumn_name()));

		String class_path = generateCodeConfig.getBasePath()
				+ StringUtils.substringBeforeLast(ftl_path, "/").concat("/");
		String fileName = class_path.concat(StringUtils.upperCase(tableInfo.getTable_name())).concat("_SqlMap.xml");
		File file = new File(fileName);
		String data = templateService.getContent(ftl_path, model);

		try {
			FileUtils.writeStringToFile(file, data);
		} catch (IOException e) {
			e.printStackTrace();
		}

		printMsg(tableInfo.getTable_name(), "SqlMap");
	}

}
