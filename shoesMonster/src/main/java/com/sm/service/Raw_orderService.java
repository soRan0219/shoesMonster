package com.sm.service;

import java.util.List;

import com.sm.domain.Raw_orderVO;

public interface Raw_orderService {
	
	// 발주 목록 조회
	public List<Raw_orderVO> getRaw_order(int startRow, int pageSize) throws Exception;
	
	// 발주 목록 개수
	public int count1() throws Exception;
	


}