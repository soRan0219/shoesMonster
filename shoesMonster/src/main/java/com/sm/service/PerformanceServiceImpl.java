package com.sm.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.PagingVO;
import com.sm.domain.ProductVO;
import com.sm.domain.WarehouseVO;
import com.sm.domain.Wh_prodVO;
import com.sm.persistence.PerformanceDAO;

@Repository
public class PerformanceServiceImpl implements PerformanceService {


	private static final Logger logger = LoggerFactory.getLogger(PerformanceServiceImpl.class);

	@Autowired
	private PerformanceDAO pdao;
	
	// 품목관리 총 갯수
	@Override
	public int countProd() {
		return pdao.countProd();
	}

	// 품목관리 리스트 불러오기
	@Override
	public List<ProductVO> getProdList(PagingVO pvo) throws Exception {
		return pdao.readProdList(pvo);
	}
	
	//품목관리 검색리스트 갯수 불러오기
	@Override
	public int countProd(ProductVO vo) {
		return pdao.countProd(vo);
	}

	// 품목관리 검색리스트 불러오기
	@Override
	public List<ProductVO> getProdList(ProductVO vo,PagingVO pvo) throws Exception {

		return pdao.readProdList(vo,pvo);
	}

	

	// 품목관리 정보 다중
	@Override
	public void insertProd(List<ProductVO> products) {
		for (ProductVO product : products) {
			pdao.insertProdList(product);
		}
	}
	
	// 품목관리 삭제
	@Override
	public void removeProd(List<String> checked) throws Exception {
		pdao.deleteProd(checked);
	}

	
	//==========================================================================
	
	// 라인 조회
	@Override
	public List<LineVO> getLineList() throws Exception {
		return pdao.getLineList();
	}
	
	// 라인 조회 (페이징처리)
	@Override
	public List<LineVO> getLineListPage(LineWhPageVO vo) throws Exception {
		return pdao.getLineListPage(vo);
	}
	
	// 라인 검색
	@Override
	public List<LineVO> getSearchLine(LineVO lvo) throws Exception {
		return pdao.getSearchLine(lvo);
	}
	
	
	// 창고 조회
	@Override
	public List<WarehouseVO> getWhList() throws Exception {
		return pdao.readWhList();
	}
	
	// 창고 조회 처리 
	@Override
	public List<Wh_prodVO> getWh_prodList() throws Exception {
		return pdao.readWh_prodList();
	}
	
	// 창고 검색
	@Override
	public List<WarehouseVO> searchWarehouse(HashMap<String, Object> search) throws Exception {
		return pdao.searchWarehouse(search);
	}


}
