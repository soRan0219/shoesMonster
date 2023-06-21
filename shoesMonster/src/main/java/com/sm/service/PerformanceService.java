package com.sm.service;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;
import com.sm.domain.WarehouseVO;
import com.sm.domain.Wh_prodVO;

public interface PerformanceService {
		
	// 품목관리 리스트 불러오기
	public List<ProductVO> getProdList() throws Exception; 
	
	// 품목관리 검색리스트 불러오기
	public List<ProductVO> getProdList(ProductVO vo) throws Exception;
	
	// 품목관리 정보 다중 저장
	public void insertProd(List<ProductVO> products); 

	//==========================================================================
	
	// 라인 조회 
	public List<LineVO> getLineList() throws Exception;
	
	// 라인 검색
	public List<LineVO> getSearchLine(LineVO lvo) throws Exception;
	
	
	// 창고 조회
	public List<WarehouseVO> getWhList() throws Exception;
	
	// 창고 조회 처리 
	public List<Wh_prodVO> getWh_prodList() throws Exception;
	
	// 창고 검색
	public List<WarehouseVO> searchWarehouse(HashMap<String, Object> search) throws Exception;
	
	
}
		