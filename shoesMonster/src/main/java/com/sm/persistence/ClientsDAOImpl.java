package com.sm.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.ClientsVO;

@Repository
public class ClientsDAOImpl implements ClientsDAO {
	
	// 디비 연결 정보, mapper 접근 => SqlSession 객체
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = 
					LoggerFactory.getLogger(ClientsDAOImpl.class);
	
	private static final String NameSpace = "com.sm.mapper.PersonMapper";

	// 거래처 목록 불러오기
	@Override
	public List<ClientsVO> readClientsListAll() throws Exception {
		logger.debug("@@@ readClientsListAll() 호출 @@@");
		
		return sqlSession.selectList(NameSpace+".listAll");
	}

	@Override
	public List<ClientsVO> getSearchClientsList(ClientsVO cvo) throws Exception {
		logger.debug("@@@ getSearchClientsList(ClientsVO cvo) 호출 @@@");
		
		return sqlSession.selectList(NameSpace+".searchClientsList", cvo);
	}
	
	
	
}
