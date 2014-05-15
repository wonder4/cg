package com.ebiz.baida.middle.service;

import java.util.List;

import com.ebiz.baida.middle.domain.RoleInfo;

/**
 * @author Jin,QingHua
 */
public interface RoleInfoService {

	Long createRoleInfo(RoleInfo t);

	int modifyRoleInfo(RoleInfo t);

	int removeRoleInfo(RoleInfo t);

	RoleInfo getRoleInfo(RoleInfo t);

	List<RoleInfo> getRoleInfoList(RoleInfo t);

	Long getRoleInfoCount(RoleInfo t);

	List<RoleInfo> getRoleInfoPaginatedList(RoleInfo t);

}
