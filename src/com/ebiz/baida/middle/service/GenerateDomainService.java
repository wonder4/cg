package com.ebiz.baida.middle.service;

import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:26:52
 */
public interface GenerateDomainService {

	void generateDomain(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig);

}
