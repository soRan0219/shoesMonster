package com.sm.service;

import java.util.List;

import com.sm.domain.Out_materialVO;
import com.sm.domain.ProductVO;

public interface Out_materialService {

	
			// 출고 목록 개수
			public int count2() throws Exception;
			
			// 검색 총 갯수
			public int count2(Out_materialVO ovo) throws Exception;
			
			// 출고 목록 조회
			public List<Out_materialVO> getOut_matList(int startRow, int pageSize ) throws Exception;
			
			// 출고 검색
			public List<Out_materialVO> searchOut_mat(int startRow, int pageSize , Out_materialVO ovo) throws Exception;
}
