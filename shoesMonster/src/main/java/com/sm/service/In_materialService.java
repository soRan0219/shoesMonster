package com.sm.service;

import java.util.List;

import com.sm.domain.In_materialVO;

public interface In_materialService {

	public List<In_materialVO> getIn_mat() throws Exception;
	
	// 입고 총 갯수
		public int count() throws Exception;
		
		// 입고 페이지
		public List<In_materialVO> getIn_matPage(int displayPost,int postNum
				, String searchType, String keyword) throws Exception;
		
//		// 입고 검색
//		public List<In_materialVO> In_matSearch(
//				int displayPost , int postNum , String keyword) throws Exception;
		
	}

