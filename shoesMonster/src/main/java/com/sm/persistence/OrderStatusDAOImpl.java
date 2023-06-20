package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.OrderStatusVO;

@Repository
public class OrderStatusDAOImpl implements OrderStatusDAO {
	
	// 디비 연결 정보, mapper 접근 => SqlSession 객체
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger 
					= LoggerFactory.getLogger(OrderStatusDAOImpl.class);
	
	private static final String NameSpace = "com.sm.mapper.PersonMapper";
	
	// 수주 현황 목록 불러오기 
	@Override
	public List<OrderStatusVO> readOrderStatusList() throws Exception {
		logger.debug("readOrderStatusList() 호출");
		return sqlSession.selectList(NameSpace +".orderStatusList");
	}

	
	// 수주 관리 조회
	@Override
	public List<OrderStatusVO> readOrderManageList() throws Exception {
		logger.debug(" readOrderManageList() 호출@@@@@ ");
		return sqlSession.selectList(NameSpace + ".orderManageList");
	}
	
	
	
}
