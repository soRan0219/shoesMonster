package com.sm.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.orderStatusVO;

@Repository
public class orderStatusDAOImpl implements orderStatusDAO {
	
	// 디비 연결 정보, mapper 접근 => SqlSession 객체
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger 
					= LoggerFactory.getLogger(orderStatusDAOImpl.class);
	
	private static final String NameSpace = "com.sm.mapper.PersonMapper";
	
	// 수주 현황 목록 불러오기 
	@Override
	public List<orderStatusVO> readOrderStatusList() throws Exception {
		logger.debug("readOrderStatusList() 호출");
		
		return sqlSession.selectList(NameSpace+".orderStatusList");
	}
	
}
