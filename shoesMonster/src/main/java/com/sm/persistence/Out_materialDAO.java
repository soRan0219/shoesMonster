package com.sm.persistence;

import java.util.List;

import com.sm.domain.Out_materialVO;

public interface Out_materialDAO {

	
			// 글 총 갯수
			public int count2() throws Exception;
			
			// 발주 목록 조회
			public List<Out_materialVO> Out_matList(int startRow,int pageSize ) throws Exception;

			// 검색 총 갯수
			public int count2(Out_materialVO ovo) throws Exception;
			
			// 발주 검색
			public List<Out_materialVO> searchOut_mat(int startRow, int pageSize, Out_materialVO ovo) throws Exception;
			
			
 }
