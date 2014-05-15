package com.ebiz.baida.middle.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ebiz.baida.middle.dao.TableInfoDao;
import com.ebiz.baida.middle.domain.TableInfo;
import com.ebiz.baida.middle.service.TableInfoService;

/**
 * @author Hui,Gang
 * @version Build 2010-8-12 下午04:44:40
 */
@Service
public class TableInfoServiceImpl implements TableInfoService {

	@Resource
	private TableInfoDao tableInfoDao;

	public Long createTableInfo(TableInfo t) {
		return this.tableInfoDao.insertEntity(t);
	}

	public TableInfo getTableInfo(TableInfo t) {
		return this.tableInfoDao.selectEntity(t);
	}

	public Long getTableInfoCount(TableInfo t) {
		return this.tableInfoDao.selectEntityCount(t);
	}

	public List<TableInfo> getTableInfoList(TableInfo t) {
		return this.tableInfoDao.selectEntityList(t);
	}

	public int modifyTableInfo(TableInfo t) {
		return this.tableInfoDao.updateEntity(t);
	}

	public int removeTableInfo(TableInfo t) {
		return this.tableInfoDao.deleteEntity(t);
	}

	public List<TableInfo> getTableInfoPaginatedList(TableInfo t) {
		return this.tableInfoDao.selectEntityPaginatedList(t);
	}

}
