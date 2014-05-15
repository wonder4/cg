package com.ebiz.baida.middle.service;

import java.util.Map;

/**
 * @author Jin,QingHua
 */
public interface TemplateService {

	String getContent(String templateName, Map<String, Object> model);

}
