package com.ebiz.baida.middle.service;

import java.util.List;

import com.ebiz.baida.middle.domain.GenerateCodeConfig;
import com.ebiz.baida.middle.domain.TableInfo;

/**
 * @author Hui,Gang
 * @version Build 2011-2-22 下午02:26:52
 */
public interface GenerateSqlMapConfigService {

	void generateSqlMapConfig(TableInfo tableInfo, GenerateCodeConfig generateCodeConfig, List<TableInfo> tableInfoList);

}
