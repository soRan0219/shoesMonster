package com.sm.service;

import java.util.List;

import com.sm.domain.StockVO;

public interface StockService {

		// 발주 목록 개수
		public int count3() throws Exception;
	
		// 발주 목록 조회
		public List<StockVO> getStockList(int startRow, int pageSize) throws Exception;
		
}
