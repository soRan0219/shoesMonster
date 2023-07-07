package com.sm.persistence;

import java.util.List;

import com.sm.domain.OrderStatusVO;
import com.sm.domain.Out_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;

public interface Out_materialDAO {

	// 글 총 갯수
	public int count4() throws Exception;
	
	// 발주 목록 조회
	public List<Out_materialVO> Out_matList(PageVO vo) throws Exception;
	
//	// 검색 총 갯수
//	public int count4(Out_materialVO rvo) throws Exception;
//	
//	// 발주 검색
//	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize, Out_materialVO rvo) throws Exception;
	
	// 출고 버튼
	public void omButton(String order_code, String emp_id) throws Exception;
	
	// 출고 검색 목록 개수
	public int count4(Out_materialVO rvo) throws Exception;
	
	// 출고 검색 목록 조회
	public List<Out_materialVO> getSearch_Out(PageVO vo, Out_materialVO rvo) throws Exception;
	
	// 출고 재고빠짐
	public void deleteStock(int order_count, String prod_code) throws Exception;
	
			
 }
