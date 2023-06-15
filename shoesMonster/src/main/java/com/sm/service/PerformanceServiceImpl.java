package com.sm.service;

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
	
	@Override
	public void insertProd(ProductVO vo) throws Exception {
		logger.debug("서비스 영역");
		
		pdao.insetProd(vo);
	}

}
