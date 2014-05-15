package com.ebiz.baida.middle.service;

import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;

/** 
* @author Hui,Gang
* @version Build 2011-2-23 下午04:51:02 
*/ 
public interface GenerateActionService {

	void generateAction(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig);

}
