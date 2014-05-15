package com.ebiz.baida.middle.service;

import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:26:52
 */
public interface GenerateServiceImplService {

	void generateServiceImpl(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig);

}
