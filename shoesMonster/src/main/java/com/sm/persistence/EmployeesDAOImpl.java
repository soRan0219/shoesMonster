package com.sm.persistence;

import java.util.HashMap;
import java.util.Map;

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
	
	private static final String NAMESPACE = "com.sm.mapper.MainMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeesDAOImpl.class);
	
	@Override
	public EmployeesVO loginEmp(EmployeesVO empvo) {
		logger.debug(" loginEmp() 호출@@@@@ ");
		
		return sqlSession.selectOne(NAMESPACE + ".smLogin", empvo);
	}

	@Override
	public EmployeesVO loginEmp(String id, String pw) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("userid", id);
		params.put("userpw", pw);
		
		return sqlSession.selectOne(NAMESPACE + ".smlogin", params);
		
	}

	
	
	
	
	
	
}
