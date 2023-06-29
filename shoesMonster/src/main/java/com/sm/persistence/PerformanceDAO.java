package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.PagingVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.ProductVO;
import com.sm.domain.RawMaterialVO;
import com.sm.domain.RequirementsVO;
import com.sm.domain.WarehouseVO;
import com.sm.domain.Wh_prodVO;

@Repository
public interface PerformanceDAO {

	// 품목관리 리스트 총갯수
	public int countProd();

	// 품목관리 목록 불러오기
	public List<ProductVO> readProdList(PagingVO pvo) throws Exception;

	// 품목관리 리스트 검색갯수
	public int countProd(ProductVO vo);

	// 품목관리 검색리스트 불러오기
	public List<ProductVO> readProdList(ProductVO vo, PagingVO pvo) throws Exception;

	// 품목관리 정보 다중 저장
	public void insertProdList(ProductVO product);

	// 품목관리 삭제
	public void deleteProd(List<String> checked) throws Exception;

	// 품목관리 수정 시 기존데이터 가져가기
	public ProductVO getProd(String prod_code) throws Exception;

	// 품목관리 수정
	public void updateProd(ProductVO uvo) throws Exception;

	// ==========================================================================

	// 원자재관리 리스트 총갯수
	public int countRaw();

	// 원자재관리 목록 불러오기
	public List<RawMaterialVO> readRawList(PagingVO pvo) throws Exception;

	// 원자재관리 리스트 검색갯수
	public int countRaw(RawMaterialVO vo);

	// 원자재관리 검색리스트 불러오기
	public List<RawMaterialVO> readRawList(RawMaterialVO vo, PagingVO pvo) throws Exception;

	// 원자재관리 정보 다중 저장
	public void insertRawList(RawMaterialVO req);

	// 원자재관리 삭제
	public void deleteRaw(List<String> checked) throws Exception;

	// 원자재관리 수정 시 기존데이터 가져가기
	public RawMaterialVO getRaw(String raw_code) throws Exception;

	// 원자재관리 수정
	public void updateRaw(RawMaterialVO uvo) throws Exception;

	// ==========================================================================

	// 소요량관리 리스트 총갯수
	public int countReq();

	// 소요량관리 목록 불러오기
	public List<RequirementsVO> readReqList(PagingVO pvo) throws Exception;

	// 소요량관리 리스트 검색갯수
	public int countReq(RequirementsVO vo);

	// 소요량관리 검색리스트 불러오기
	public List<RequirementsVO> readReqList(RequirementsVO vo, PagingVO pvo) throws Exception;

	// 소요량관리 정보 다중 저장
	public void insertReqList(RequirementsVO raw);

	// 소요량관리 삭제
	public void deleteReq(List<String> checked) throws Exception;

	// 소요량관리 수정 시 기존데이터 가져가기
	public RequirementsVO getReq(String req_code) throws Exception;

	// 소요량관리 수정
	public void updateReq(RequirementsVO uvo) throws Exception;

	// ==========================================================================

	// 라인 조회 - getLineList
	public List<LineVO> getLineList() throws Exception;

	// 라인 조회(페이징처리) - getLineListPage
	public List<LineVO> getLineListPage(LineWhPageVO vo) throws Exception;

	// 라인 검색(페이징처리)
	public List<LineVO> getSearchLinePage(LineWhPageVO vo, LineVO lvo) throws Exception;

	// 총 글 개수 계산
	public int getTotalCount() throws Exception;

	// 서치시 총 글 개수 계산
	public int getSearchTotalCount(LineVO lvo) throws Exception;

	// ================창고==========================

	// 창고 목록 조회 + 페이징처리
	public List<WarehouseVO> getWh_prodListPage(LineWhPageVO vo) throws Exception;

	// 창고 조회 총 게시판 글 개수 계산
	public int getWh_TotalCount() throws Exception;

	// 창고 검색 + 페이징처리
	public List<WarehouseVO> searchWarehousePage(LineWhPageVO vo, Wh_prodVO wvo) throws Exception;

	// 검색시 총 글 개수 계산
	public int searchWh_TotalCount(Wh_prodVO wvo) throws Exception;

	// ==========================================================================

	// 생산실적 목록
	public List<PerformanceVO> readPerfList(LineWhPageVO pvo) throws Exception;

	// 생산실적 검색
	public List<PerformanceVO> readPerfList(HashMap<String, Object> search) throws Exception;

	// 생산실적 전체 수
	public int getPerfCnt() throws Exception;

	// 생산실적 검색 수
	public int getPerfCnt(HashMap<String, Object> search) throws Exception;

	// 생산실적 등록
	public void createPerformance(PerformanceVO vo) throws Exception;

	// 생산실적 삭제
	public void deletePerformance(List<String> checked) throws Exception;

	// 생산실적 조회
	public PerformanceVO readPerformanceInfo(String performCode) throws Exception;

	// 생산실적 수정
	public void updatePerformance(PerformanceVO uvo) throws Exception;

}
