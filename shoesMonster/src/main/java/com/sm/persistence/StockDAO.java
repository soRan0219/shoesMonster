package com.sm.persistence;

import java.util.List;

import com.sm.domain.StockVO;
import com.sm.domain.WarehouseVO;

public interface StockDAO {

	
		// 글 총 갯수
		public int count3() throws Exception;
		
		// 재고 목록 조회
		public List<StockVO> StockList(int startRow,int pageSize) throws Exception;
		
		// 검색 총 갯수
		public int count3(WarehouseVO wvo) throws Exception;
		
		// 재고 검색 목록 조회
		public List<StockVO> StockList(int startRow,int pageSize , WarehouseVO wvo) throws Exception;
}
