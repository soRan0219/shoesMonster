package com.sm.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.ProductVO;

@Repository
public class PerformanceImpl implements PerformanceDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(PerformanceImpl.class);
	
	private static final String NAMESPACE = "com.sm.mapper.ProductMapper";
	
	// 前格包府 格废 阂矾坷扁
	@Override
	public List<ProductVO> readProdList() throws Exception{
		
		return sqlSession.selectList(NAMESPACE+".readProd");
	}

	@Override
	public void insertProdList(ProductVO product) {
		sqlSession.insert(NAMESPACE+".prodIn", product);
	}
	

	
	
}
