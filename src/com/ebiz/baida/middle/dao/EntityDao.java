package com.ebiz.baida.middle.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

/**
 * SpringJdbc and iBATIS DAO base interface
 * 
 * @author Jin,QingHua
 * @param <T>
 * @version 2.0
 */
public interface EntityDao<T> {

	int deleteEntity(T t) throws DataAccessException;

	Long insertEntity(T t) throws DataAccessException;

	T selectEntity(T t) throws DataAccessException;

	Long selectEntityCount(T t) throws DataAccessException;

	List<T> selectEntityList(T t) throws DataAccessException;

	List<T> selectEntityPaginatedList(T t) throws DataAccessException;

	int updateEntity(T t) throws DataAccessException;
}
