package com.sm.service;

import java.util.List;

import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;

public interface PerformanceService {
	public void insertProd(ProductVO vo) throws Exception;
	
	// 라인 
	public void insertLine(LineVO vo) throws Exception;
	public List<LineVO> getLineList() throws Exception;
	
}
