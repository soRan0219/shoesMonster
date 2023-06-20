package com.sm.service;

import java.util.List;

import com.sm.domain.oderStatusVO;
import com.sm.domain.orderStatusVO;

public interface orderStatusService {
	// 수행하는 동작 선언
	
	// 수주 현황 목록 불러오기
	public List<orderStatusVO> getOsList() throws Exception; 
}
