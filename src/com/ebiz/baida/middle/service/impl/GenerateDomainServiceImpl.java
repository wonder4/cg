package com.ebiz.baida.middle.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import utils.BaseUtils;
import utils.DBTypeToJavaTypeUtil;

import com.ebiz.baida.middle.domain.ColumnInfo;
import com.ebiz.baida.middle.domain.FtlPathConfig;
import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.GenerateDomainService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:36:37
 */

public class GenerateDomainServiceImpl extends BaseFacadeImpl implements GenerateDomainService {

	@Resource
	private FtlPathConfig ftlPathConfig;

	@Resource
	TemplateService templateService;

	public void generateDomain(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig) {
		logger.info("- - -> Next Table... ...");
		logger.info("- - -> Current Table Name:{}", tableInfo.getTable_name());

		String class_name = BaseUtils.ChangeClassName(tableInfo.getTable_name());

		Set<String> importClassList = new HashSet<String>();

		for (ColumnInfo ci : tableInfo.getColumnInfoList()) {
			logger.info("{} - {}", ci.getColumn_name(), ci.getColumn_type());
			String java_type = "";
			if (StringUtils.isNotBlank(ci.getData_scale()) && !"0".equals(ci.getData_scale())) {
				java_type = DBTypeToJavaTypeUtil.getJavaType("FLOAT_" + ci.getColumn_type());
			} else {
				java_type = DBTypeToJavaTypeUtil.getJavaType(ci.getColumn_type(), generateCodeConfig.getDb_type());
			}

			ci.setJava_type(java_type);
			String importClass = DBTypeToJavaTypeUtil.getImportClass(java_type);
			if (StringUtils.isNotBlank(importClass)) {
				importClassList.add(importClass);
			}
		}

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("project_name", generateCodeConfig.getProject_name());
		model.put("now", new Date());
		model.put("base_package", generateCodeConfig.getBasePackage());
		model.put("class_name", class_name);
		model.put("columnInfoList", tableInfo.getColumnInfoList());
		model.put("importClassList", importClassList);

		String class_path = generateCodeConfig.getBasePath()
				+ StringUtils.substringBeforeLast(ftlPathConfig.getDomain_ftl_path(), "/").concat("/");
		String fileName = class_path.concat(class_name).concat(".java");
		File file = new File(fileName);
		String data = templateService.getContent(ftlPathConfig.getDomain_ftl_path(), model);

		try {
			FileUtils.writeStringToFile(file, data);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
