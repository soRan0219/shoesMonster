package com.sm.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.PagingVO;
import com.sm.domain.ProductVO;
import com.sm.persistence.PerformanceDAO;

@Repository
public class PerformanceServiceImpl implements PerformanceService {

	private static final Logger logger = LoggerFactory.getLogger(PerformanceServiceImpl.class);

	@Autowired
	private PerformanceDAO pdao;
	
	// 품목관리 총 갯수
	@Override
	public int countProd() {
		return 0;
	}

	// 품목관리 리스트 불러오기
	@Override
	public List<ProductVO> getProdList(PagingVO pvo) throws Exception {
		return pdao.readProdList(pvo);
	}

	// 품목관리 검색리스트 불러오기
	@Override
	public List<ProductVO> getProdList(ProductVO vo) throws Exception {

		return pdao.readProdList(vo);
	}

	// 품목관리 정보 다중
	@Override
	public void insertProd(List<ProductVO> products) {
		for (ProductVO product : products) {
			pdao.insertProdList(product);
		}
	}

	// 라인
	@Override
	public void insertLine(LineVO vo) throws Exception {

		pdao.insertLine(vo);
	}

	@Override
	public List<LineVO> getLineList() throws Exception {

		return pdao.getLineList();
	}

}
