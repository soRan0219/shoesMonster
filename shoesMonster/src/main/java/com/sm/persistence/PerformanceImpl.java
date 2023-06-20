package com.sm.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;
import com.sm.domain.WarehouseVO;

@Repository
public class PerformanceImpl implements PerformanceDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(PerformanceImpl.class);
	
	private static final String NAMESPACE = "com.sm.mapper.ProductMapper";
	
	
	// 품목 리스트 불러오기
	@Override
	public List<ProductVO> readProdList() throws Exception {
		logger.debug(" 품목관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE+".readProd");
	}
	
	// 품목 검색리스트 불러오기
	@Override
	public List<ProductVO> readProdList(ProductVO vo) throws Exception {
		logger.debug(" 품목관리 검색리스트 DAO ");
		return sqlSession.selectList(NAMESPACE+".readSearchProd",vo);
	}

	// 품목관리 정보 다중 저장
	@Override
	public void insertProdList(ProductVO product) {
		sqlSession.insert(NAMESPACE+".prodIn", product);
	}
	
	//==========================================================================
	
	// 라인 조회
	@Override
	public List<LineVO> getLineList() throws Exception {
		logger.debug("@@getLineList() 호출@@");
		
		return sqlSession.selectList(NAMESPACE+".lineList");
	}
	
	// 라인 검색
	@Override
	public List<LineVO> getSearchLine(LineVO lvo) throws Exception {
		logger.debug("@@getSearchLine(LineVO lvo) 호출@@");
		
		return sqlSession.selectList(NAMESPACE+".searchLine", lvo);
	}
	
	// 창고 조회
	@Override
	public List<WarehouseVO> readWhList() throws Exception {
		logger.debug("@@readWhList() 호출@@");
		
		return sqlSession.selectList(NAMESPACE+".whlist");
	}

	
}
