package com.sm.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.In_materialVO;

@Repository
public class In_materialImpl implements In_materialDAO {

	@Autowired
	private SqlSession sqlSession;	
//
	private static final Logger logger = LoggerFactory.getLogger(In_materialImpl.class);
//	
	private static final String NAMESPACE = "com.sm.mapper.stockMapper";

	@Override
	public List<In_materialVO> readBoardIn_mat() throws Exception {
		
		
		
		logger.debug(" readBoardIn_mat() 호출");
		
		return sqlSession.selectList(NAMESPACE + ".In_material");
//		return null;
	}
	
	

	
}
