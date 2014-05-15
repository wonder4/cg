package com.ebiz.baida.middle.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import utils.BaseUtils;

import com.ebiz.baida.middle.domain.FtlPathConfig;
import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.GenerateFacadeImplService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:36:37
 */

public class GenerateFacadeImplServiceImpl extends BaseFacadeImpl implements GenerateFacadeImplService {

	@Resource
	private FtlPathConfig ftlPathConfig;

	@Resource
	TemplateService templateService;

	public void generateFacadeImpl(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig,
			List<TableInfo> tableInfoList) {
		if (null == tableInfoList || tableInfoList.size() == 0) {
			logger.info("===>【tableInfoList is emtpy !】<===");
			return;
		}

		String[] domains = new String[tableInfoList.size()];

		for (int i = 0; i < tableInfoList.size(); i++) {
			domains[i] = BaseUtils.ChangeClassName(tableInfoList.get(i).getTable_name());
		}

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("project_name", generateCodeConfig.getProject_name());
		model.put("now", new Date());
		model.put("base_package", generateCodeConfig.getBasePackage());
		model.put("domains", domains);

		String class_path = generateCodeConfig.getBasePath()
				+ StringUtils.substringBeforeLast(ftlPathConfig.getFacadeImpl_ftl_path(), "/").concat("/");
		String fileName = class_path.concat("FacadeImpl.java");
		File file = new File(fileName);
		String data = generateCodeConfig.getFacade().getTemplateService().getContent(
				ftlPathConfig.getFacadeImpl_ftl_path(), model);
		try {
			FileUtils.writeStringToFile(file, data);
		} catch (IOException e) {
			e.printStackTrace();
		}

		printMsg("FacadeImpl", "");
	}
}
