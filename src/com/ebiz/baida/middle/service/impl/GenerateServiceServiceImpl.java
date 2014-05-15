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
import utils.DBTypeToJavaTypeUtil;

import com.ebiz.baida.middle.domain.FtlPathConfig;
import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.GenerateServiceService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:36:37
 */

public class GenerateServiceServiceImpl extends BaseFacadeImpl implements GenerateServiceService {

	@Resource
	private FtlPathConfig ftlPathConfig;

	@Resource
	TemplateService templateService;

	public void generateService(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig) {
		String domain_name = BaseUtils.ChangeClassName(tableInfo.getTable_name());

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("project_name", generateCodeConfig.getProject_name());
		model.put("now", new Date());
		model.put("base_package", generateCodeConfig.getBasePackage());
		model.put("domain_name", domain_name);
		model.put("return_number_type", DBTypeToJavaTypeUtil.getJavaType("INT", generateCodeConfig.getDb_type()));

		String class_path = generateCodeConfig.getBasePath()
				+ StringUtils.substringBeforeLast(ftlPathConfig.getService_ftl_path(), "/").concat("/");
		String fileName = class_path.concat(domain_name).concat("Service.java");
		File file = new File(fileName);
		String data = templateService.getContent(ftlPathConfig.getService_ftl_path(), model);

		try {
			FileUtils.writeStringToFile(file, data);
		} catch (IOException e) {
			e.printStackTrace();
		}

		printMsg(tableInfo.getTable_name(), "Service");

	}

}
