package com.sm.persistence;

import java.util.List;
import java.util.Map;

import com.sm.domain.PageVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.StockVO;
import com.sm.domain.WarehouseVO;

public interface StockDAO {

	
		// 글 총 갯수
		public int count3() throws Exception;
		
		// 재고 목록 조회
		public List<StockVO> getStock(PageVO vo) throws Exception;
		
		// 검색 총 갯수
//		public int count3(WarehouseVO wvo) throws Exception;
		
		// 재고 검색 목록 조회
//		public List<StockVO> StockList(int startRow,int pageSize , WarehouseVO wvo) throws Exception;
		
		// 검색 목록 개수
		public int count3(StockVO svo) throws Exception;
		
		// 재고 검색 목록 조회
		public List<StockVO> getStock(PageVO vo, StockVO svo) throws Exception;
		
		// 재고 실수량 
        public void updateCount(int stock_count , String raw_code) throws Exception;
		
        // 재고 그래프
        public Map<String, List<StockVO>> stockGraph1() throws Exception;
}
