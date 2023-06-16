package com.sm.persistence;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.EmployeesVO;

@Repository
public class EmployeesDAOImpl implements EmployeesDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.sm.mapper.productMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeesDAOImpl.class);
	
	@Override
	public EmployeesVO loginEmp(EmployeesVO empvo) {
		logger.debug(" loginEmp() 호출@@@@@ ");
		return sqlSession.selectOne(NAMESPACE + ".smLogin", empvo);
	}
	
	
	
}
