package com.sm.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.ProductVO;
import com.sm.persistence.PerformanceDAO;

@Repository
public class PerformanceServiceImpl implements PerformanceService {
	
	private static final Logger logger = LoggerFactory.getLogger(PerformanceServiceImpl.class);
	
	@Autowired
	private PerformanceDAO pdao;
	
	
	// 前格包府 格废 阂矾坷扁 
	@Override
	public List<ProductVO> getProdList() throws Exception {
		
		return pdao.readProdList();
	}

	@Override
	public void insertProd(List<ProductVO> products) {
		for(ProductVO product : products) {
			pdao.insertProdList(product);
		}
	}
	

}
