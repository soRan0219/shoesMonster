package com.sm.service;

import java.util.HashMap;
import java.util.List;

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

	// ==========================================================================

	@Override
	public int countRaw() {
		return pdao.countRaw();
	}

	@Override
	public List<RawMaterialVO> getRawList(PagingVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return pdao.readRawList(pvo);
	}

	@Override
	public int countRaw(RawMaterialVO vo) {
		return pdao.countRaw(vo);
	}

	@Override
	public List<RawMaterialVO> getRawList(RawMaterialVO vo, PagingVO pvo) throws Exception {
		return pdao.readRawList(vo, pvo);
	}

	@Override
	public void insertRaw(List<RawMaterialVO> raw) {
		for (RawMaterialVO raws : raw) {
			pdao.insertRawList(raws);
		}
	}

	@Override
	public void removeRaw(List<String> checked) throws Exception {
		pdao.deleteRaw(checked);
	}

	// ==========================================================================

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

	// 라인 검색
	@Override
	public List<LineVO> getSearchLine(LineVO lvo) throws Exception {
		return pdao.getSearchLine(lvo);
	}

//	// 라인 검색 (페이징 처리)
//	@Override
//	public List<LineVO> getSearchLinePage(LineWhPageVO vo) throws Exception {
//		return pdao.getSearchLinePage(vo);
//	}

	// 라인 검색 (페이징 처리) ++ 도전
	@Override
	public List<LineVO> getSearchLinePage(LineWhPageVO vo, LineVO lvo) throws Exception {
		return pdao.getSearchLinePage(vo, lvo);
	}

//	// 라인 검색 (페이징 처리) ++ 도전 두번째
//	@Override
//	public List<LineVO> getSearchLinePage(LineVO lvo) throws Exception {
//		return pdao.getSearchLinePage(lvo);
//	}

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

	// 창고 조회
	@Override
	public List<WarehouseVO> getWhList() throws Exception {
		return pdao.readWhList();
	}

	// 창고 조회 처리
	@Override
	public List<Wh_prodVO> getWh_prodList() throws Exception {
		return pdao.readWh_prodList();
	}

	// 창고 검색
	@Override
	public List<WarehouseVO> searchWarehouse(HashMap<String, Object> search) throws Exception {
		return pdao.searchWarehouse(search);
	}

	// 창고 조회 처리(페이징처리)
	@Override
//	public List<Wh_prodVO> getWh_prodListPage(LineWhPageVO vo) throws Exception {
	public List<WarehouseVO> getWh_prodListPage(LineWhPageVO vo) throws Exception {

		return pdao.getWh_prodListPage(vo);
	}

	// 창고 조회 총 글 개수 계산
	@Override
	public int getWh_TotalCount() throws Exception {

		return pdao.getWh_TotalCount();
	}

	// ==========================================================================

	@Override
	public List<PerformanceVO> getAllPerf() throws Exception {
		return pdao.readAllPerf();

	} //getAllPerf()

	@Override
	public void regPerformance(PerformanceVO vo) throws Exception {
		pdao.createPerformance(vo);
	} //regPerformance()

	@Override
	public void removePerformance(List<String> checked) throws Exception {
		
	} //removePerformance()




}
