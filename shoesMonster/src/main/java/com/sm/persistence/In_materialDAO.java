package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.In_materialVO;

public interface In_materialDAO {

	// 글 목록 조회
	public List<In_materialVO>  readBoardIn_mat() throws Exception;
	
	// 글 총 갯수
		public int count() throws Exception;
		
		public List<In_materialVO> In_matPage(int displayPost,int postNum ) throws Exception;

		
		// 페이징처리 + 검색어
		
		public int count(HashMap<String, Object> search) throws Exception;
		
		public List<In_materialVO> In_matPage(int displayPost,int postNum ,HashMap<String, Object> search) throws Exception;
		
		// 페이징처리 
		
//		// 검색 기능
//		public List<In_materialVO> In_matSearch(
//				int displayPost , int postNum , String keyword) throws Exception;
	

}


