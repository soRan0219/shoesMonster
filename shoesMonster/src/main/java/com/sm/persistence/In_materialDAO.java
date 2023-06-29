package com.sm.persistence;

import java.util.List;

import com.sm.domain.In_materialVO;
import com.sm.domain.Raw_orderVO;

public interface In_materialDAO {

	// 글 목록 조회
	public List<In_materialVO>  readBoardIn_mat() throws Exception;
	
	// 글 총 갯수
		public int count() throws Exception;
		
		public List<In_materialVO> In_matPage(int displayPost,int postNum ) throws Exception;

		
		// 페이징처리 + 검색어
		
//		public int count(In_materialVO ivo) throws Exception;
//		
//		public List<In_materialVO> In_matPage(int displayPost,int postNum ,In_materialVO ivo) throws Exception;
//		
		// 입고등록
		public void inInsert(Raw_orderVO rvo) throws Exception;
}


