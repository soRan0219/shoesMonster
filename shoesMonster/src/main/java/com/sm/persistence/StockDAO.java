package com.sm.persistence;

import java.util.List;

import com.sm.domain.StockVO;

public interface StockDAO {

	
		// 글 총 갯수
		public int count3() throws Exception;
		
		// 발주 목록 조회
		public List<StockVO> StockList(int startRow,int pageSize) throws Exception;
		
}
