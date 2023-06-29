package com.sm.persistence;

import java.util.List;

import com.sm.domain.Out_materialVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;

public interface Out_materialDAO {

	// 글 총 갯수
	public int count2() throws Exception;
	
	// 발주 목록 조회
	public List<Out_materialVO> Out_matList(int startRow,int pageSize ) throws Exception;
	
	// 검색 총 갯수
	public int count2(ProductVO ovo) throws Exception;
	
	// 발주 검색
	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize, ProductVO ovo) throws Exception;
	
	// 출고 버튼
	public void omButton(ProductVO vo) throws Exception;
			
 }
