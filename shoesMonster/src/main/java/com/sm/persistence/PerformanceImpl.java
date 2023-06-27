package com.sm.persistence;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mysql.cj.util.DnsSrv.SrvRecord;
import com.mysql.cj.xdevapi.Result;
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
public class PerformanceImpl implements PerformanceDAO {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(PerformanceImpl.class);

	private static final String NAMESPACE = "com.sm.mapper.ProductMapper";

	// 품목관리 리스트 총 갯수
	@Override
	public int countProd() {
		logger.debug(" 품목관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countProd");
	}

	// 품목 리스트 불러오기
	@Override
	public List<ProductVO> readProdList(PagingVO pvo) throws Exception {
		logger.debug(" 품목관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE + ".readProd", pvo);
	}

	// 품목관리 검색 리스트 총 갯수
	@Override
	public int countProd(ProductVO vo) {
		return sqlSession.selectOne(NAMESPACE + ".countSearchProd", vo);
	}

	// 품목 검색리스트 불러오기
	@Override
	public List<ProductVO> readProdList(ProductVO vo, PagingVO pvo) throws Exception {
//		logger.debug(" 품목관리 검색리스트 DAO ");
//		RowBounds row = new RowBounds(pvo.getStart(), pvo.getCntPerPage());
//		return sqlSession.selectList(NAMESPACE+".readSearchProd",vo,row);
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("start", pvo.getStart());
		data.put("cntPerPage", pvo.getCntPerPage());
		data.put("prod_code", vo.getProd_code());
		data.put("prod_name", vo.getProd_name());
		data.put("prod_category", vo.getProd_category());
		data.put("prod_unit", vo.getProd_unit());

		return sqlSession.selectList(NAMESPACE + ".readSearchProd", data);
	}

	// 품목관리 정보 다중 저장
	@Override
	public void insertProdList(ProductVO product) {
		sqlSession.insert(NAMESPACE + ".prodIn", product);
	}

	// 품목관리 삭제
	@Override
	public void deleteProd(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteProd() 호출");

		Iterator<String> it = checked.iterator();
		int result = 0;

		while (it.hasNext()) {
			String prod_code = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteProd", prod_code);
		}

		logger.debug("##### DAO: delete 결과 ===> " + result);
	}

	// ==========================================================================

	@Override
	public int countRaw() {
		logger.debug(" 원자재관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countRaw");
	}

	@Override
	public List<RawMaterialVO> readRawList(PagingVO pvo) throws Exception {
		logger.debug(" 원자재관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE + ".readRaw", pvo);
	}

	@Override
	public int countRaw(RawMaterialVO vo) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("raw_code", vo.getRaw_code());
		data.put("raw_name", vo.getRaw_name());
		logger.debug(" vo.getClients().getClient_actname()" + vo.getClients().getClient_actname());
		if (vo.getClients().getClient_actname() != null) {
			data.put("client_actname", vo.getClients().getClient_actname());
		}

		return sqlSession.selectOne(NAMESPACE + ".countSearchRaw", data);
	}

	@Override
	public List<RawMaterialVO> readRawList(RawMaterialVO vo, PagingVO pvo) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("start", pvo.getStart());
		data.put("cntPerPage", pvo.getCntPerPage());
		data.put("raw_code", vo.getRaw_code());
		data.put("raw_name", vo.getRaw_name());
		data.put("client_actname", vo.getClients().getClient_actname());

		return sqlSession.selectList(NAMESPACE + ".readSearchRaw", data);
	}

	@Override
	public void insertRawList(RawMaterialVO raw) {
		sqlSession.insert(NAMESPACE + ".rawIn", raw);
	}

	@Override
	public void deleteRaw(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteRaw() 호출");

		Iterator<String> it = checked.iterator();
		int result = 0;

		while (it.hasNext()) {
			String raw_code = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteRaw", raw_code);
		}

		logger.debug("##### DAO: delete 결과 ===> " + result);

	}

	// ==========================================================================

	@Override
	public int countReq() {
		logger.debug(" 소요량관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countReq");
	}

	@Override
	public List<RequirementsVO> readReqList(PagingVO pvo) throws Exception {
		logger.debug(" 소요량관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE + ".readReq", pvo);
	}

	@Override
	public int countReq(RequirementsVO vo) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("req_code", vo.getReq_code());
		data.put("prod_name", vo.getProd().getProd_name());
		data.put("prod_code", vo.getProd_code());
		return sqlSession.selectOne(NAMESPACE + ".countSearchReq", data);
	}

	@Override
	public List<RequirementsVO> readReqList(RequirementsVO vo, PagingVO pvo) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("start", pvo.getStart());
		data.put("cntPerPage", pvo.getCntPerPage());
		data.put("req_code", vo.getReq_code());
		data.put("prod_name", vo.getProd().getProd_name());
		data.put("prod_code", vo.getProd_code());

		return sqlSession.selectList(NAMESPACE + ".readSearchReq", data);
	}

	@Override
	public void insertReqList(RequirementsVO req) {
		sqlSession.insert(NAMESPACE + ".reqIn", req);

	}

	@Override
	public void deleteReq(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteRaw() 호출");

		Iterator<String> it = checked.iterator();
		int result = 0;

		while (it.hasNext()) {
			String req_code = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteReq", req_code);
		}

		logger.debug("##### DAO: delete 결과 ===> " + result);

	}

	// ==========================================================================

	// 라인 조회
	@Override
	public List<LineVO> getLineList() throws Exception {
		logger.debug("@@getLineList() 호출@@");

		return sqlSession.selectList(NAMESPACE + ".lineList");
	}

	// 라인조회 (페이징처리)
	@Override
	public List<LineVO> getLineListPage(LineWhPageVO vo) throws Exception {
		logger.debug("@@getLineListPage(LineWhPageVO vo) 호출@@");

		return sqlSession.selectList(NAMESPACE + ".lineListPage", vo);
	}

	// 라인 검색 (페이징처리)
	@Override
	public List<LineVO> getSearchLinePage(LineWhPageVO vo, LineVO lvo) throws Exception {
		logger.debug("@@ getSearchLinePage(LineWhPageVO vo, LineVO lvo) 호출 @@");

		Map<String, Object> params = new HashMap<>();

		params.put("line_code", lvo.getLine_code());
		params.put("line_name", lvo.getLine_name());

		if (lvo.getLine_use() != 0) {
			params.put("line_use", lvo.getLine_use());
		}

		params.put("line_place", lvo.getLine_place());
		params.put("startPage", vo.getStartPage());
		params.put("pageSize", vo.getPageSize());

		return sqlSession.selectList(NAMESPACE + ".searchLinePage", params);
	}

	// 게시판 총 글개수 계산
	@Override
	public int getTotalCount() throws Exception {
		logger.debug("@@ getTotalCount() 호출 @@");

		return sqlSession.selectOne(NAMESPACE + ".totalCnt");
	}

	// 게시판 총 글개수 계산 (서치)
	@Override
	public int getSearchTotalCount(LineVO lvo) throws Exception {
		logger.debug("@@ getSearchTotalCount(LineVO lvo) 호출 @@");
		int result = sqlSession.selectOne(NAMESPACE + ".searchTotalCnt", lvo);
		logger.debug("result :" + result);
		return result;
	}

	// ===========창고==============================================

	// 창고 목록 조회 + 페이징처리
	@Override
	public List<WarehouseVO> getWh_prodListPage(LineWhPageVO vo) throws Exception {
		logger.debug("@@ getWh_prodListPage() 호출 @@");

		return sqlSession.selectList(NAMESPACE + ".whlistPage", vo);
	}

	// 창고 조회 총 글 개수 계산
	@Override
	public int getWh_TotalCount() throws Exception {
		logger.debug("@@ getWh_TotalCount() 호출 @@");

		return sqlSession.selectOne(NAMESPACE + ".whTotalCnt");
	}

	// 창고 검색 + 페이징처리
	@Override
	public List<WarehouseVO> searchWarehousePage(LineWhPageVO vo, Wh_prodVO wvo) throws Exception {
		logger.debug("@@ searchWarehousePage(LineWhPageVO vo, Wh_prodVO wvo) 호출 @@");

		Map<String, Object> params = new HashMap<>();

		params.put("wh_code", wvo.getWh_code());
		params.put("prod_code", wvo.getProd_code());
		params.put("raw_code", wvo.getRaw_code());

		params.put("wh_addr", wvo.getWh_addr());
		
		if(wvo.getWh_use() != 0) {

			params.put("wh_use", wvo.getWh_use());
		}

		params.put("startPage", vo.getStartPage());
		params.put("pageSize", vo.getPageSize());

		return sqlSession.selectList(NAMESPACE + ".searchWareHouse", params);
	}

	// 검색시 총 글 개수 계산
//	@Override
//	public int searchWh_TotalCount(Wh_prodVO wvo) throws Exception {
//		logger.debug("@@ searchWh_TotalCount(Wh_prodVO wvo) 호출 @@");
		
//		return sqlSession.selectOne(NAMESPACE+".searchWhTotalCnt", wvo);
//	}
	@Override
	public int searchWh_TotalCount(Wh_prodVO wvo) throws Exception {
		logger.debug("@@ searchWh_TotalCount(Wh_prodVO wvo) 호출 @@");

		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("wh_code", wvo.getWh_code());

		if(wvo.getProd_code() != null) {
			params.put("prod_code", wvo.getProd_code());
		}else if(wvo.getRaw_code() != null) {
			params.put("raw_code", wvo.getRaw_code());
		}
		
		params.put("wh_addr", wvo.getWh_addr());
		
		if(wvo.getWh_use() != 0) {
			params.put("wh_use", wvo.getWh_use());
		}
		
		return sqlSession.selectOne(NAMESPACE+".searchWhTotalCnt", params);

	}

	// ==========================================================================

	@Override
	public List<PerformanceVO> readAllPerf() throws Exception {
		logger.debug("##### DAO: readAllPerf() 호출");

		return sqlSession.selectList(NAMESPACE + ".performList");
	} // readAllPerf()

	@Override
	public void createPerformance(PerformanceVO vo) throws Exception {
		logger.debug("##### DAO: createPerformance() 호출");
		sqlSession.insert(NAMESPACE + ".insertPerform", vo);
	} // createPerformance()

	@Override
	public void deletePerformance(List<String> checked) throws Exception {
		logger.debug("##### DAO: deletePerformance() 호출");

		Iterator<String> it = checked.iterator();
		int result = 0;

		while (it.hasNext()) {
			String perform_code = it.next();
			result += sqlSession.delete(NAMESPACE + ".deletePerformance", perform_code);
		}
		logger.debug("##### DAO: delete 결과 ===> " + result);

	} //deletePerformance()

	@Override
	public PerformanceVO readPerformanceInfo(String performCode) throws Exception {
		logger.debug("##### DAO: readPerformanceInfo() 호출");
		return sqlSession.selectOne(NAMESPACE + ".performInfo", performCode);
	} //readPerformanceInfo()

	@Override
	public void updatePerformance(PerformanceVO uvo) throws Exception {
		logger.debug("##### DAO: updatePerformance() 호출");
		int result = sqlSession.update(NAMESPACE + ".updatePerform", uvo);
		
		logger.debug("##### DAO: update 결과 ===> " + result);
	} //updatePerformance()

	



}
