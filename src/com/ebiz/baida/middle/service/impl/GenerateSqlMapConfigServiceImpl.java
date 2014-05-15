package com.ebiz.baida.middle.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;

import com.ebiz.baida.middle.domain.FtlPathConfig;
import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.GenerateSqlMapConfigService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:36:37
 */

public class GenerateSqlMapConfigServiceImpl extends BaseFacadeImpl implements GenerateSqlMapConfigService {

	@Resource
	private FtlPathConfig ftlPathConfig;

	@Resource
	TemplateService templateService;

	public void generateSqlMapConfig(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig,
			List<TableInfo> tableInfoList) {
		if (null == tableInfoList || tableInfoList.size() == 0) {
			logger.info("===>【tableInfoList is emtpy !】<===");
			return;
		}

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("project_name", generateCodeConfig.getProject_name());
		model.put("now", new Date());
		model.put("base_package", generateCodeConfig.getBasePackage());
		model.put("tableInfoList", tableInfoList);
		model.put("db_type", generateCodeConfig.getDb_type());

		String fileName = generateCodeConfig.getBasePath().concat("sqlmap-config.xml");
		File file = new File(fileName);
		String data = templateService.getContent(ftlPathConfig.getSqlmapConfig_ftl_path(), model);
		try {
			FileUtils.writeStringToFile(file, data);
		} catch (IOException e) {
			e.printStackTrace();
		}

		printMsg("sqlmap-config.xml", "");
	}
}
