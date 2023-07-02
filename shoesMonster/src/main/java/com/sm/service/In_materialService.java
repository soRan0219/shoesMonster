package com.sm.service;

import java.util.List;

import com.sm.domain.In_materialVO;
import com.sm.domain.Raw_orderVO;

public interface In_materialService {

	public List<In_materialVO> getIn_mat() throws Exception;
	
		// 입고 총 갯수
		public int count() throws Exception;
		
		// 입고 목록 + 페이징
		public List<In_materialVO> getIn_matPage(int displayPost,int postNum) throws Exception;
		
		// 입고 검색 총 갯수
//		public int count(In_materialVO ivo) throws Exception;
//		
//		// 입고 검색 페이지
//		public List<In_materialVO> getIn_matPage(int displayPost,int postNum ,In_materialVO ivo) throws Exception;
		
		// 입고 등록
		public void inInsert(Raw_orderVO rvo, String raw_order_num) throws Exception;
		
		
		
		// 미입고 ,출국완료
        public void updateIn(String raw_order_num) throws Exception;
        
        // 재고에 입고할 항목있는지 조회(select)
//        public void selectCheck() throws Exception;
       
		
	}

