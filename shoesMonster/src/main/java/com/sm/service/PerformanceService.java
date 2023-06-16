package com.sm.service;

import java.util.List;

import com.sm.domain.ProductList;
import com.sm.domain.ProductVO;

public interface PerformanceService {
		
	// 前格包府 格废 阂矾坷扁
	public List<ProductVO> getProdList() throws Exception; 
	
	// 前格包府 单捞磐 促吝 历厘
	public void insertProd(List<ProductVO> products); 
		
	
	
}
		