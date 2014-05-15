package com.ebiz.baida.middle.service;

import com.ebiz.baida.middle.domain.PropertiesConfig;
import com.ebiz.baida.middle.domain.TableInfo;

/**
 * @author Hui,Gang
 * @version 2013-8-2 上午10:23:00
 */
public interface GenerateJspViewService {

	void generateJspView(TableInfo tableInfo, PropertiesConfig propertiesConfig);

}
