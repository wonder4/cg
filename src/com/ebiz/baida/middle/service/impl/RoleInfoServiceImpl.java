package com.ebiz.baida.middle.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ebiz.baida.middle.dao.RoleInfoDao;
import com.ebiz.baida.middle.domain.RoleInfo;
import com.ebiz.baida.middle.service.RoleInfoService;

/**
 * @author Jin,QingHua
 */
@Service
public class RoleInfoServiceImpl implements RoleInfoService {

	@Resource
	private RoleInfoDao roleInfoDao;

	public Long createRoleInfo(RoleInfo t) {
		return this.roleInfoDao.insertEntity(t);
	}

	public RoleInfo getRoleInfo(RoleInfo t) {
		return this.roleInfoDao.selectEntity(t);
	}

	public Long getRoleInfoCount(RoleInfo t) {
		return this.roleInfoDao.selectEntityCount(t);
	}

	public List<RoleInfo> getRoleInfoList(RoleInfo t) {
		return this.roleInfoDao.selectEntityList(t);
	}

	public int modifyRoleInfo(RoleInfo t) {
		return this.roleInfoDao.updateEntity(t);
	}

	public int removeRoleInfo(RoleInfo t) {
		return this.roleInfoDao.deleteEntity(t);
	}

	public List<RoleInfo> getRoleInfoPaginatedList(RoleInfo t) {
		return this.roleInfoDao.selectEntityPaginatedList(t);
	}

}
