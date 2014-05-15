package com.ebiz.baida.middle.service.impl;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.ebiz.baida.middle.service.TemplateService;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * @author Hui,Gang
 * @version Build 2010-8-7 下午04:23:42
 */
@Component
public class TemplateServiceFreeMarkerImpl implements TemplateService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private FreeMarkerConfigurer freeMarkerConfigurer;

	@Autowired
	private Configuration freeMarkerConfiguration;

	public void setFreeMarkerConfigurer(FreeMarkerConfigurer freeMarkerConfigurer) {
		this.freeMarkerConfigurer = freeMarkerConfigurer;
	}

	public void setFreeMarkerConfiguration(Configuration freeMarkerConfiguration) {
		this.freeMarkerConfiguration = freeMarkerConfiguration;
	}

	public String getContent(String templateName, Map<String, Object> model) {
		try {
			Template t = freeMarkerConfigurer.getConfiguration().getTemplate(templateName);
			return FreeMarkerTemplateUtils.processTemplateIntoString(t, model);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.equals(ex.getMessage());
			try {
				Template t = freeMarkerConfiguration.getTemplate(templateName);
				return FreeMarkerTemplateUtils.processTemplateIntoString(t, model);
			} catch (Exception e) {
				e.printStackTrace();
				logger.equals(e.getMessage());
			}
		}

		return null;
	}
}
