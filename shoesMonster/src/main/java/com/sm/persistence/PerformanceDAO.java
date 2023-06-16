package com.sm.persistence;

import java.util.List;

import com.sm.domain.ProductVO;

public interface PerformanceDAO {
	
	// 前格包府 格废 阂矾坷扁
	public List<ProductVO> readProdList() throws Exception;
		
	public void insertProdList(ProductVO product); 
		
	
}
