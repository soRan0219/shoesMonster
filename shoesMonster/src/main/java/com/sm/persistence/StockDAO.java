package com.sm.persistence;

import java.util.List;
import java.util.Map;

import com.sm.domain.PageVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.StockVO;
import com.sm.domain.WarehouseVO;

public interface StockDAO {

	// 글 총 갯수
    public int countR3() throws Exception;
    
    // 글 총 갯수
    public int countP3() throws Exception;

    // 재고 목록 조회
    public List<StockVO> getStockP(PageVO vo) throws Exception;
    
    // 재고 목록 조회
    public List<StockVO> getStockR(PageVO vo) throws Exception;

    // 검색 목록 개수
    public int countP3(StockVO svo) throws Exception;

    // 재고 검색 목록 조회
    public List<StockVO> getStockP(PageVO vo, StockVO svo) throws Exception;

    // 검색 목록 개수
    public int countR3(StockVO svo) throws Exception;

    // 재고 검색 목록 조회
    public List<StockVO> getStockR(PageVO vo, StockVO svo) throws Exception;
	
	// 재고 실수량 
    public void updateCount(String code, int newCount) throws Exception;
    
    // 재고 수정(팝업)
    public List<StockVO> stockPopup(String code) throws Exception;
	
    // 재고 그래프
    public Map<String, List<StockVO>> stockGraph1() throws Exception;
    
}
