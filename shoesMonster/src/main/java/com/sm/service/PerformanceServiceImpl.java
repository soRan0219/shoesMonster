package com.sm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.sm.persistence.PerformanceDAO;

@Repository
public class PerformanceServiceImpl implements PerformanceService {

	private static final Logger logger = LoggerFactory.getLogger(PerformanceServiceImpl.class);

	@Autowired
	private PerformanceDAO pdao;

	// 품목관리 총 갯수
	@Override
	public int countProd() {
		return pdao.countProd();
	}

	// 품목관리 리스트 불러오기
	@Override
	public List<ProductVO> getProdList(PagingVO pvo) throws Exception {
		return pdao.readProdList(pvo);
	}

	// 품목관리 검색리스트 갯수 불러오기
	@Override
	public int countProd(ProductVO vo) {
		return pdao.countProd(vo);
	}

	// 품목관리 검색리스트 불러오기
	@Override
	public List<ProductVO> getProdList(ProductVO vo, PagingVO pvo) throws Exception {

		return pdao.readProdList(vo, pvo);
	}
	
	// 품목관리 추가버튼 클릭 시 품번코드 가져가기
	@Override
	public String getProdCode() {
		return pdao.readProdCode();
	}

	// 품목관리 정보 다중
	@Override
	public void insertProd(List<ProductVO> products) {
		for (ProductVO product : products) {
			pdao.insertProdList(product);
		}
	}

	// 품목관리 삭제
	@Override
	public void removeProd(List<String> checked) throws Exception {
		pdao.deleteProd(checked);
	}
	
	// 품목관리 수정 시 기존 데이터 가져가기
	@Override
	public ProductVO getProd(String prod_code) throws Exception{
		return pdao.getProd(prod_code);
	}
	
	// 품목관리 수정
	@Override
	public void modifyProd(ProductVO uvo) throws Exception {
		pdao.updateProd(uvo);
	}

	// ==========================================================================

	
	// 원자재관리 총 갯수
	@Override
	public int countRaw() {
		return pdao.countRaw();
	}
	
	// 원자재관리 전체 리스트 
	@Override
	public List<RawMaterialVO> getRawList(PagingVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return pdao.readRawList(pvo);
	}

	// 원자재관리 검색 갯수
	@Override
	public int countRaw(RawMaterialVO vo) {
		return pdao.countRaw(vo);
	}
	
	// 원자재관리 검색 리스트
	@Override
	public List<RawMaterialVO> getRawList(RawMaterialVO vo, PagingVO pvo) throws Exception {
		return pdao.readRawList(vo, pvo);
	}
	
	// 원자재관리 추가버튼 클릭 시 품번코드 가져가기
	@Override
	public String getRawCode() {
		return pdao.readRawCode();
	}
	
	// 원자재관리 데이터 추가
	@Override
	public void insertRaw(List<RawMaterialVO> raw) {
		for (RawMaterialVO raws : raw) {
			pdao.insertRawList(raws);
		}
	}

	// 원자재관리 데이터 삭제
	@Override
	public void removeRaw(List<String> checked) throws Exception {
		pdao.deleteRaw(checked);
	}
	
	// 원자재관리 수정 시 기존 데이터 가져가기
	@Override
	public RawMaterialVO getRaw(String raw_code) throws Exception {
		return pdao.getRaw(raw_code);
	}

	// 원자재관리 수정
	@Override
	public void modifyRaw(RawMaterialVO uvo) throws Exception {
		pdao.updateRaw(uvo);
	}

	// ==========================================================================
	
	// 소요량관리 게시물 총 갯수
	@Override
	public int countReq() {
		return pdao.countReq();
	}
	
	// 소요량관리 리스트 불러오기
	@Override
	public List<RequirementsVO> getReqList(PagingVO pvo) throws Exception {
		return pdao.readReqList(pvo);
	}
	
	// 소요량관리 게시물 검색 갯수
	@Override
	public int countReq(RequirementsVO vo) throws Exception {
		return pdao.countReq(vo);
	}
	
	// 소요량관리 검색리스트 불러오기
	@Override
	public List<RequirementsVO> getReqList(RequirementsVO vo, PagingVO pvo) throws Exception {
		return pdao.readReqList(vo, pvo);
	}
	
	// 소요량관리 정보 다중 저장
	@Override
	public void insertReq(List<RequirementsVO> req) throws Exception {
		for (RequirementsVO reqs : req) {
			pdao.insertReqList(reqs);
		}
	}
	
	// 소요량관리 삭제
	@Override
	public void removeReq(List<String> checked) throws Exception {
		pdao.deleteReq(checked);
	}
	
	// 소요량관리 수정 시 기존 데이터 가져가기
	@Override
	public RequirementsVO getReq(String Req_code) throws Exception {
		return pdao.getReq(Req_code);
	}

	// 소요량관리 수정
	@Override
	public void modifyReq(RequirementsVO uvo) throws Exception {
		pdao.updateReq(uvo);
	}
	// 라인=======================================================================
	
	// 라인 조회
	@Override
	public List<LineVO> getLineList() throws Exception {
		return pdao.getLineList();
	}

	// 라인 조회 (페이징처리)
	@Override
	public List<LineVO> getLineListPage(LineWhPageVO vo) throws Exception {
		return pdao.getLineListPage(vo);
	}

	// 라인 검색 (페이징 처리)
	@Override
	public List<LineVO> getSearchLinePage(LineWhPageVO vo, LineVO lvo) throws Exception {
		return pdao.getSearchLinePage(vo, lvo);
	}

	// 게시판 총 글 개수 계산
	@Override
	public int getTotalCount() throws Exception {

		return pdao.getTotalCount();
	}

	// 게시판 총 글 개수 계산 (서치)
	@Override
	public int getSearchTotalCount(LineVO lvo) throws Exception {

		return pdao.getSearchTotalCount(lvo);
	}
	
	// 라인 추가
	@Override
	public void registLine(LineVO lvo) throws Exception {
			
		pdao.registLine(lvo);
	}
	
	// 라인 삭제
	@Override
	public void deleteLine(List<String> checked) throws Exception {
		
		pdao.deleteLine(checked);
	}
 
	// 라인 수정
	@Override
	public void modifyLine(LineVO lvo) throws Exception {
		
		pdao.modifyLine(lvo);
	}
	
	// 라인 조회(String line_code)
	@Override
	public LineVO getLine(String line_code) throws Exception {
		
		return pdao.getLine(line_code);
	}
	
	// 라인 추가 시 코드값 가져가기
	@Override
	public String getLiCode() {
		
		return pdao.getLiCode();
	}
	
	// 창고=======================================================================

	// 창고 목록 조회 + 페이징처리
	@Override
	public List<WarehouseVO> getWh_prodListPage(LineWhPageVO vo) throws Exception {

		return pdao.getWh_prodListPage(vo);
	}

	// 창고 조회 총 글 개수 계산
	@Override
	public int getWh_TotalCount() throws Exception {

		return pdao.getWh_TotalCount();
	}
	
	// 창고 검색 + 페이징처리
	@Override
	public List<WarehouseVO> searchWarehousePage(LineWhPageVO vo, Wh_prodVO wvo) throws Exception {

		return pdao.searchWarehousePage(vo, wvo);
	}
	
	// 검색시 총 글 개수 계산
	@Override
	public int searchWh_TotalCount(Wh_prodVO wvo) throws Exception {
		
		return pdao.searchWh_TotalCount(wvo);
	}
	
	// 창고 추가
	@Override
	public void registWh(Wh_prodVO wvo) throws Exception {
		
		pdao.registWh(wvo);
	}
	
	// 창고 삭제
	@Override
	public void deleteWh(List<String> checked) throws Exception {
		
		pdao.deleteWh(checked);
	}

	// 창고 수정
	@Override
	public void modifyWh(Wh_prodVO wvo) throws Exception {
		
		pdao.modifyWh(wvo);
	}

	// 창고 조회(String wh_code)
	@Override
	public Wh_prodVO getWarehouse(String wh_code) throws Exception {
	
		return pdao.getWarehouse(wh_code);
	}
	
	// 창고 추가 선택 시 코드 가져오기
	@Override
	public String getWhCode() {

		return pdao.getWhCode();
	}

	// ==========================================================================

	//생산실적 목록
	@Override
	public List<PerformanceVO> getPerfList(LineWhPageVO pvo) throws Exception {
		return pdao.readPerfList(pvo);

	} //getAllPerf()

	//생산실적 등록
	@Override
	public void regPerformance(PerformanceVO vo) throws Exception {
		pdao.createPerformance(vo);
	} //regPerformance()

	//생산실적 삭제
	@Override
	public void removePerformance(List<String> checked) throws Exception {
		pdao.deletePerformance(checked);
	} //removePerformance()

	//생산실적 조회
	@Override
	public PerformanceVO getPerformanceInfo(String performCode) throws Exception {
		return pdao.readPerformanceInfo(performCode);
	} //getPerformanceInfo()

	//생산실적 수정
	@Override
	public void modifyPerformance(PerformanceVO uvo) throws Exception {
		pdao.updatePerformance(uvo);
	} //modifyPerformance()

	//생산실적 전체 수
	@Override
	public int getPerfCnt() throws Exception {
		return pdao.getPerfCnt();
	} //getAllPerfCnt()

	//생산실적 검색
	@Override
	public List<PerformanceVO> getPerfList(HashMap<String, Object> search) throws Exception {
		return pdao.readPerfList(search);
	} //getPerfList(search)

	//생산실적 검색 수
	@Override
	public int getPerfCnt(HashMap<String, Object> search) throws Exception {
		return pdao.getPerfCnt(search);
	} //getPerfCnt(search)

	//실적현황 - 양불수
	@Override
	public Map<String, List<PerformanceVO>> getPerformStatus() throws Exception {
		return pdao.getPerformStatus();
	} //getPerformStatus()

	





}
