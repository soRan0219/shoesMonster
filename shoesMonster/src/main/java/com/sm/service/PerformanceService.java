package com.sm.service;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.LineVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.PagingVO;
import com.sm.domain.ProductVO;
import com.sm.domain.WarehouseVO;
import com.sm.domain.Wh_prodVO;

public interface PerformanceService {
	
	// 품목관리 게시물 총 갯수
	public int countProd();
	
	// 품목관리 리스트 불러오기
	public List<ProductVO> getProdList(PagingVO pvo) throws Exception; 
	
	// 품목관리 게시물 검색 갯수
	public int countProd(ProductVO vo);
	
	// 품목관리 검색리스트 불러오기
	public List<ProductVO> getProdList(ProductVO vo,PagingVO pvo) throws Exception;
	
	// 품목관리 정보 다중 저장
	public void insertProd(List<ProductVO> products); 
	
	// 품목관리 삭제
	public void removeProd(List<String> checked) throws Exception;

	//==========================================================================
	
	// 라인 조회 
	public List<LineVO> getLineList() throws Exception;
	
	// 라인 조회(페이징처리)
	public List<LineVO> getLineListPage(LineWhPageVO vo) throws Exception;
	
	// 라인 검색
	public List<LineVO> getSearchLine(LineVO lvo) throws Exception;
	
//	 // 라인 검색(페이징처리)
//	public List<LineVO> getSearchLinePage(LineWhPageVO vo) throws Exception;

	// 라인 검색(페이징처리) ++ 도전
	public List<LineVO> getSearchLinePage(LineWhPageVO vo, LineVO lvo) throws Exception;

//	// 라인 검색(페이징처리) ++ 도전 두번째
//	public List<LineVO> getSearchLinePage(LineVO lvo) throws Exception;
	
	// 총 글 개수 계산
	public int getTotalCount() throws Exception;
	
	// 서치시 총 글 개수 계산
	public int getSearchTotalCount(LineVO lvo) throws Exception;
	
	
	// 창고 조회
	public List<WarehouseVO> getWhList() throws Exception;
	
	// 창고 조회 처리 
	public List<Wh_prodVO> getWh_prodList() throws Exception;
	
	// 창고 검색
	public List<WarehouseVO> searchWarehouse(HashMap<String, Object> search) throws Exception;
	
	
}
		