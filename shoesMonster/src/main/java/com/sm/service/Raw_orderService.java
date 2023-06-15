package com.sm.service;

import java.util.List;

import com.sm.domain.Raw_orderVO;

public interface Raw_orderService {
	
	// 발주 목록 조회
	public List<Raw_orderVO> getRaw_Order_List() throws Exception;
	
	

}
