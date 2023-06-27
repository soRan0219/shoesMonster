package com.sm.service;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.LineVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.PagingVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.ProductVO;
import com.sm.domain.RawMaterialVO;
import com.sm.domain.RequirementsVO;
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
	public List<ProductVO> getProdList(ProductVO vo, PagingVO pvo) throws Exception;

	// 품목관리 정보 다중 저장
	public void insertProd(List<ProductVO> products);

	// 품목관리 삭제
	public void removeProd(List<String> checked) throws Exception;

	// ==========================================================================

	// 원자재관리 게시물 총 갯수
	public int countRaw();

	// 원자재관리 리스트 불러오기
	public List<RawMaterialVO> getRawList(PagingVO pvo) throws Exception;

	// 원자재관리 게시물 검색 갯수
	public int countRaw(RawMaterialVO vo) throws Exception;

	// 원자재관리 검색리스트 불러오기
	public List<RawMaterialVO> getRawList(RawMaterialVO vo, PagingVO pvo) throws Exception;

	// 원자재관리 정보 다중 저장
	public void insertRaw(List<RawMaterialVO> raw) throws Exception;

	// 원자재관리 삭제
	public void removeRaw(List<String> checked) throws Exception;

	// ==========================================================================

	// 소요량관리 게시물 총 갯수
	public int countReq();

	// 소요량관리 리스트 불러오기
	public List<RequirementsVO> getReqList(PagingVO pvo) throws Exception;

	// 소요량관리 게시물 검색 갯수
	public int countReq(RequirementsVO vo) throws Exception;

	// 소요량관리 검색리스트 불러오기
	public List<RequirementsVO> getReqList(RequirementsVO vo, PagingVO pvo) throws Exception;

	// 소요량관리 정보 다중 저장
	public void insertReq(List<RequirementsVO> req) throws Exception;

	// 소요량관리 삭제
	public void removeReq(List<String> checked) throws Exception;

	// ==========================================================================

	// 라인 조회
	public List<LineVO> getLineList() throws Exception;

	// 라인 조회(페이징처리)
	public List<LineVO> getLineListPage(LineWhPageVO vo) throws Exception;

	// 라인 검색(페이징처리)
	public List<LineVO> getSearchLinePage(LineWhPageVO vo, LineVO lvo) throws Exception;

	// 총 글 개수 계산
	public int getTotalCount() throws Exception;

	// 서치시 총 글 개수 계산
	public int getSearchTotalCount(LineVO lvo) throws Exception;

	// ===============창고======================================

	// 창고 목록 조회 + 페이징처리
	public List<WarehouseVO> getWh_prodListPage(LineWhPageVO vo) throws Exception;

	// 창고 조회 총 글 개수 계산
	public int getWh_TotalCount() throws Exception;

	// 창고 검색 + 페이징처리
	public List<WarehouseVO> searchWarehousePage(LineWhPageVO vo, Wh_prodVO wvo) throws Exception;

	// 검색시 총 글 개수 계산
	public int searchWh_TotalCount(Wh_prodVO wvo) throws Exception;

	// ==========================================================================

	// 생산실적 목록
	public List<PerformanceVO> getAllPerf() throws Exception;

	// 생산실적 등록
	public void regPerformance(PerformanceVO vo) throws Exception;

	// 생산실적 삭제
	public void removePerformance(List<String> checked) throws Exception;

}
