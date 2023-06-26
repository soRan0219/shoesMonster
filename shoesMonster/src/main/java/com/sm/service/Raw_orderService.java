package com.sm.service;

import java.util.List;

import com.sm.domain.Raw_orderVO;

public interface Raw_orderService {
	
	// 발주 목록 조회
	public List<Raw_orderVO> getRaw_order(int startRow, int pageSize) throws Exception;
	
	// 발주 목록 개수
	public int count1() throws Exception;
	
	// 발주 등록(팝업)
	public List<Raw_orderVO> getPopup() throws Exception;
	
	// 발주 재고 개수(팝업)

	
	
	// 발주 검색 목록 갯수
	public int count1(Raw_orderVO rvo) throws Exception;
	
	// 발주 검색 목록 조회
	public List<Raw_orderVO> getRaw_order(int startRow, int pageSize, Raw_orderVO rvo) throws Exception;

}