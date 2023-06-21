package com.sm.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;
import com.sm.domain.WarehouseVO;
import com.sm.domain.Wh_prodVO;
import com.sm.persistence.PerformanceDAO;

@Repository
public class PerformanceServiceImpl implements PerformanceService {
	
	private static final Logger logger = LoggerFactory.getLogger(PerformanceServiceImpl.class);
	
	
	@Autowired
	private PerformanceDAO pdao;
	
	
	// 품목관리 리트스 불러오기
	@Override
	public List<ProductVO> getProdList() throws Exception {		
		return pdao.readProdList();
	}
	
	// 품목관리 검색리스트 불러오기
	@Override
	public List<ProductVO> getProdList(ProductVO vo) throws Exception {
		
		return pdao.readProdList(vo);
	}
  
  // 품목관리 정보 다중 
	@Override
	public void insertProd(List<ProductVO> products) {
		for(ProductVO product : products) {
			pdao.insertProdList(product);
		}
	}
	
	//==========================================================================
	// 라인 조회
	@Override
	public List<LineVO> getLineList() throws Exception {
		
		return pdao.getLineList();
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
