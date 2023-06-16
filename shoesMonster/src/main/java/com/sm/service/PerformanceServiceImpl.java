package com.sm.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;
import com.sm.persistence.PerformanceDAO;

@Repository
public class PerformanceServiceImpl implements PerformanceService {
	
	private static final Logger logger = LoggerFactory.getLogger(PerformanceServiceImpl.class);
	
	@Autowired
	private PerformanceDAO pdao;
	
	@Override
	public void insertProd(ProductVO vo) throws Exception {
		logger.debug("���� ����");
		
		pdao.insetProd(vo);
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
