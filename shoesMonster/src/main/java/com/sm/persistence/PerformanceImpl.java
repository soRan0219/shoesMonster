package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.PagingVO;
import com.sm.domain.ProductVO;

@Repository
public class PerformanceImpl implements PerformanceDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(PerformanceImpl.class);
	
	private static final String NAMESPACE = "com.sm.mapper.ProductMapper";
	
	
	// 품목관리 리스트 총 갯수
	@Override
	public int countProd() {
		logger.debug(" 품목관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE+".countProd");
	}
	
	// 품목 리스트 불러오기
	@Override
	public List<ProductVO> readProdList(PagingVO pvo) throws Exception {
		logger.debug(" 품목관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE+".readProd",pvo);
	}
	
	// 품목관리 검색 리스트 총 갯수
	@Override
	public int countProd(ProductVO vo) {
		return sqlSession.selectOne(NAMESPACE+".countSearchProd", vo);
	}

	// 품목 검색리스트 불러오기
	@Override
	public List<ProductVO> readProdList(ProductVO vo,PagingVO pvo) throws Exception {
//		logger.debug(" 품목관리 검색리스트 DAO ");
//		RowBounds row = new RowBounds(pvo.getStart(), pvo.getCntPerPage());
//		return sqlSession.selectList(NAMESPACE+".readSearchProd",vo,row);
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("start",pvo.getStart());
		data.put("cntPerPage",pvo.getCntPerPage());
		data.put("prod_code", vo.getProd_code());
		data.put("prod_name", vo.getProd_name());
		data.put("prod_category", vo.getProd_category());
		data.put("prod_unit", vo.getProd_unit());
		
		return sqlSession.selectList(NAMESPACE+".readSearchProd",data);
	}

	// 품목관리 정보 다중 저장
	@Override
	public void insertProdList(ProductVO product) {
		sqlSession.insert(NAMESPACE+".prodIn", product);
	}
	
	// 라인
	@Override
	public void insertLine(LineVO vo) throws Exception {
		logger.debug("@@inser@@");
		
		int result = sqlSession.insert(NAMESPACE+".insertLine", vo);
		
		if(result != 0)
			logger.debug("라인 글쓰기 완료");
		
	}
	@Override
	public List<LineVO> getLineList() throws Exception {
		logger.debug("@@getLineList() 호출@@");
		
		return sqlSession.selectList(NAMESPACE+".lineList");
	}

	
}
