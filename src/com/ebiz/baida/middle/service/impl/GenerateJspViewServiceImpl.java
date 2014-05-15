package com.ebiz.baida.middle.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import utils.BaseUtils;

import com.ebiz.baida.middle.domain.FtlPathConfig;
import com.ebiz.baida.middle.domain.PropertiesConfig;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.GenerateJspViewService;
import com.ebiz.baida.middle.service.TemplateService;

/**
 * @author Hui,Gang
 * @version Build 2011-2-24 上午10:54:41
 */
public class GenerateJspViewServiceImpl extends BaseFacadeImpl implements GenerateJspViewService {

	@Resource
	private FtlPathConfig ftlPathConfig;

	@Resource
	TemplateService templateService;

	public void generateJspView(TableInfo tableInfo, PropertiesConfig propertiesConfig) {
		String class_name = BaseUtils.ChangeClassName(tableInfo.getTable_name());

		Map<String, Object> model = new HashMap<String, Object>();
		model.put("class_name", class_name);
		model.put("columnInfoList", tableInfo.getColumnInfoList());
		model.put("first_column", StringUtils.lowerCase(tableInfo.getColumnInfoList().get(0).getColumn_name()));

		String class_path = propertiesConfig.getAutogc_config_output_base_directory() + "/"
				+ propertiesConfig.getAutogc_config_output_project_name()
				+ StringUtils.substringBeforeLast(ftlPathConfig.getJsp_form_ftl_path(), "/").concat("/");
		String fileName = class_path.concat(class_name).concat("/view.jsp");
		File file = new File(fileName);
		String data = templateService.getContent(ftlPathConfig.getJsp_view_ftl_path(), model);

		try {
			FileUtils.writeStringToFile(file, data);
		} catch (IOException e) {
			e.printStackTrace();
		}

		printMsg(tableInfo.getTable_name(), "form - jsp");

	}

}
