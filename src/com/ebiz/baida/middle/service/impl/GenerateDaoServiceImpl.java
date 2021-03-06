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

import com.ebiz.baida.middle.domain.FtlPathConfig;
import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.GenerateDaoService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:36:37
 */

public class GenerateDaoServiceImpl extends BaseFacadeImpl implements GenerateDaoService {

	@Resource
	private FtlPathConfig ftlPathConfig;

	@Resource
	TemplateService templateService;

	public void generateDao(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig) {
		String domain_name = BaseUtils.ChangeClassName(tableInfo.getTable_name());
		String class_name = BaseUtils.ChangeClassName(tableInfo.getTable_name()).concat("Dao");

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("project_name", generateCodeConfig.getProject_name());
		model.put("now", new Date());
		model.put("base_package", generateCodeConfig.getBasePackage());
		model.put("class_name", class_name);
		model.put("domain_name", domain_name);

		String class_path = generateCodeConfig.getBasePath()
				+ StringUtils.substringBeforeLast(ftlPathConfig.getDao_ftl_path(), "/").concat("/");
		String fileName = class_path.concat(class_name).concat(".java");
		File file = new File(fileName);
		String data = templateService.getContent(ftlPathConfig.getDao_ftl_path(), model);

		try {
			FileUtils.writeStringToFile(file, data);
		} catch (IOException e) {
			e.printStackTrace();
		}

		printMsg(tableInfo.getTable_name(), "Dao");

	}

}
