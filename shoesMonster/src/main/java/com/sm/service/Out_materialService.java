package com.sm.service;

import java.util.List;

import com.sm.domain.OrderStatusVO;
import com.sm.domain.Out_materialVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;

public interface Out_materialService {

	// 출고 목록 개수
	public int count2() throws Exception;
				
	// 출고 목록 조회
	public List<Out_materialVO> getOut_matList(int startRow, int pageSize ) throws Exception;
	
	// 검색 총 갯수
	public int count2(OrderStatusVO ovo) throws Exception;
	
	// 출고 검색
	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize , OrderStatusVO ovo) throws Exception;

	// 출고 버튼
	public void omButton(OrderStatusVO vo , String order_code) throws Exception;


}
