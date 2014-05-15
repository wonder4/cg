package com.ebiz.baida.middle.dao.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcDaoSupport;
import org.springframework.stereotype.Repository;

import com.ebiz.baida.middle.dao.RoleInfoDao;
import com.ebiz.baida.middle.domain.RoleInfo;

/**
 * @author Hui,Gang
 * @version Build 2010-8-7 下午03:16:25
 */
@Repository
public class RoleInfoDaoJdbcImpl extends SimpleJdbcDaoSupport implements RoleInfoDao {

	ParameterizedRowMapper<RoleInfo> rowMapperForList = new ParameterizedRowMapper<RoleInfo>() {
		public RoleInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
			RoleInfo roleInfo = new RoleInfo();
			roleInfo.setId(rs.getLong("id"));
			roleInfo.setRole_name(rs.getString("role_name"));
			roleInfo.setOrder_value(rs.getInt("order_value"));
			return roleInfo;
		}
	};

	public List<RoleInfo> selectEntityList(RoleInfo t) throws DataAccessException {
		StringBuffer sb = new StringBuffer();
		sb.append("select * from role_info where 1 = 1 order by id desc");
		return super.getSimpleJdbcTemplate().query(sb.toString(), rowMapperForList,
				new BeanPropertySqlParameterSource(t));
	}

	@Override
	public int deleteEntity(RoleInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Long insertEntity(RoleInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RoleInfo selectEntity(RoleInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long selectEntityCount(RoleInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<RoleInfo> selectEntityPaginatedList(RoleInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateEntity(RoleInfo t) throws DataAccessException {
		// TODO Auto-generated method stub
		return 0;
	}
}