package com.ebiz.baida.middle.service;

import java.util.List;

import com.ebiz.baida.middle.domain.TableInfo;

/**
 * @author Hui,Gang
 * @version Build 2010-8-12 下午04:44:04
 */
public interface TableInfoService {

	Long createTableInfo(TableInfo t);

	int modifyTableInfo(TableInfo t);

	int removeTableInfo(TableInfo t);

	TableInfo getTableInfo(TableInfo t);

	List<TableInfo> getTableInfoList(TableInfo t);

	Long getTableInfoCount(TableInfo t);

	List<TableInfo> getTableInfoPaginatedList(TableInfo t);

}
