package com.ebiz.baida.middle.service;

import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午03:22:24
 */
public interface GenerateServiceService {

	void generateService(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig);

}
