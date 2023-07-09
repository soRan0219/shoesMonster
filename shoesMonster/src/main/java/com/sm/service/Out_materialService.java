package com.sm.service;

import java.util.List;

import com.sm.domain.OrderStatusVO;
import com.sm.domain.Out_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;

public interface Out_materialService {

	// 출고 목록 개수
	public int count4() throws Exception;
				
	// 출고 목록 조회
	public List<Out_materialVO> getOut_matList(PageVO vo) throws Exception;
	
	// 검색 총 개수
//	public int count4(OrderStatusVO ovo) throws Exception;
	
	// 출고 버튼
	public void omButton(String order_code, String emp_id) throws Exception;
	
	// 출고 검색 목록 개수
	public int count4(Out_materialVO rvo) throws Exception;
	
	// 출고 검색 목록 조회
	public List<Out_materialVO> getSearch_Out(PageVO vo, Out_materialVO rvo) throws Exception;

	// 출고 재고빠짐
	public void deleteStock(int order_count, String prod_code) throws Exception;
	
	// out_YN "출고완료" 변경
	public void updateYN(String order_code) throws Exception;
	

}
