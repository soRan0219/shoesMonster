package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.oderStatusVO;
import com.sm.domain.orderStatusVO;
import com.sm.persistence.orderStatusDAO;

@Service
public class orderStatusServiceImpl implements orderStatusService {

	@Autowired
	private orderStatusDAO osdao;
	
	// 수주 현황 목록 불러오기
	@Override
	public List<orderStatusVO> getOsList() throws Exception {
		
		return osdao.readOrderStatusList();
	}
	
}
