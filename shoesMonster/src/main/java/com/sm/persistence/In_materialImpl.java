package com.sm.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sm.domain.In_materialVO;

public class In_materialImpl implements In_materialDAO {

	private SqlSession sqlSession;	

	private static final Logger logger = LoggerFactory.getLogger(In_materialImpl.class);
	
	private static final String NAMESPACE = "com.sm.mapper.stockMapper";

	@Override
	public List<In_materialVO> readBoardListAll() throws Exception {

		logger.debug(" readBoardListAll");
		
		return sqlSession.selectList(NAMESPACE + ".listAll");
	}
	
	

	
}
