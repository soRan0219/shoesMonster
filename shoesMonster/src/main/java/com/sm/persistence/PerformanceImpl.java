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

import com.sm.domain.LineVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.PagingVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.ProductVO;
import com.sm.domain.RawMaterialVO;
import com.sm.domain.RequirementsVO;
import com.sm.domain.StockVO;
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
		data.put("client_code", vo.getClient_code());

		return sqlSession.selectList(NAMESPACE + ".readSearchProd", data);
	}
	
	
	// 품목관리 추가버튼 클릭 시 품번코드 가져가기
	@Override
	public String readProdCode() {
		return sqlSession.selectOne(NAMESPACE+".readProdCode");
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
	
	// 품목관리 수정 시 기존데이터 가져가기
	@Override
	public ProductVO getProd(String prod_code) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".readProdOne", prod_code);
	}
	
	// 품목관리 수정
	@Override
	public void updateProd(ProductVO uvo) throws Exception {
		sqlSession.update(NAMESPACE+".updateProd", uvo);
	}
	
	// ==========================================================================
	
	// 원자재관리 리스트 총 갯수
	@Override
	public int countRaw() {
		logger.debug(" 원자재관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countRaw");
	}
	
	// 원자재 관리 전체 리스트
	@Override
	public List<RawMaterialVO> readRawList(PagingVO pvo) throws Exception {
		logger.debug(" 원자재관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE + ".readRaw", pvo);
	}
	
	// 원자재관리 검색 갯수
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
	
	// 원자재관리 검색리스트
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
	
	// 원자재관리 추가버튼 클릭 시 품번코드 가져가기
	@Override
	public String readRawCode() {
		return sqlSession.selectOne(NAMESPACE+".readRawCode");
	}
	
	// 원자재관리 데이터 추가
	@Override
	public void insertRawList(RawMaterialVO raw) {
		sqlSession.insert(NAMESPACE + ".rawIn", raw);
	}
	
	// 원자재관리 데이터 삭제
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
	
	// 원자재관리 수정 시 기존데이터 가져가기
	@Override
	public RawMaterialVO getRaw(String raw_code) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".readRawOne", raw_code);
	}

	// 원자재관리 수정
	@Override
	public void updateRaw(RawMaterialVO uvo) throws Exception {
		sqlSession.update(NAMESPACE + ".updateRaw", uvo);
	}

	// ==========================================================================
	
	// 소요량관리 전체 갯수
	@Override
	public int countReq() {
		logger.debug(" 소요량관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countReq");
	}
	
	// 소요량관리 전체리스트
	@Override
	public List<RequirementsVO> readReqList(PagingVO pvo) throws Exception {
		logger.debug(" 소요량관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE + ".readReq", pvo);
	}
	
	// 소요량 검색 갯수
	@Override
	public int countReq(RequirementsVO vo) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("req_code", vo.getReq_code());
		data.put("prod_name", vo.getProd().getProd_name());
		data.put("prod_code", vo.getProd_code());
		return sqlSession.selectOne(NAMESPACE + ".countSearchReq", data);
	}
	
	// 소요량 검색 리스트
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
	
	// 소요량 데이터 추가
	@Override
	public void insertReqList(RequirementsVO req) {
		sqlSession.insert(NAMESPACE + ".reqIn", req);

	}
	
	// 소요량 데이터 삭제
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
	
	// 소요량관리 수정 시 기존데이터 가져가기
	@Override
	public RequirementsVO getReq(String req_code) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".readReqOne", req_code);
	}

	// 소요량관리 수정
	@Override
	public void updateReq(RequirementsVO uvo) throws Exception {
		sqlSession.update(NAMESPACE + ".updateReq", uvo);
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
	
	// 라인 추가
	@Override
	public void registLine(LineVO lvo) throws Exception {
		logger.debug("@@ D : registLine(LineVO lvo) 호출 @@");
		
		sqlSession.insert(NAMESPACE+".registLine", lvo);
	}
	
	// 라인 삭제
	@Override
	public void deleteLine(List<String> checked) throws Exception {
		logger.debug("@@ D : deleteLine(List<String> checked) 호출 @@");
		
		Iterator<String> it = checked.iterator();
		int result = 0;
		
		while(it.hasNext()) {
			String line_code = it.next();
			result += sqlSession.delete(NAMESPACE+".deleteLine", line_code);
		}
		logger.debug("@@ D : delete ==> "+ result);
	}
	
	// 라인 수정  
	@Override
	public void modifyLine(LineVO lvo) throws Exception {
		logger.debug("@@ D : modifyLine(LineVO lvo) 호출 @@");
		
		int result = sqlSession.update(NAMESPACE+".updateLine", lvo);
		logger.debug("@@ D : update ==> "+ result);
	}
	
	// 라인 조회(String line_code)
	@Override
	public LineVO getLine(String line_code) throws Exception {
		logger.debug("@@ D : getLine(String line_code) 호출 @@");
			
		return sqlSession.selectOne(NAMESPACE+".readLineList", line_code);
	}
	
	// 라인 추가 시 code값 가져가기
	@Override
	public String getLiCode() {
		
		String code = "L000";
		
		if(sqlSession.selectOne(NAMESPACE+".getLiCode") == null) {
			return code;
		}else {
			return sqlSession.selectOne(NAMESPACE+".getLiCode");
		}
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
//		params.put("prod_code", wvo.getProd_code());
//		params.put("raw_code", wvo.getRaw_code());
		params.put("emp_id", wvo.getEmp_id());
//		params.put("emp_name", wvo.getEmp().getEmp_name());

		params.put("wh_addr", wvo.getWh_addr());
		
		if(wvo.getWh_use() != 0) {

			params.put("wh_use", wvo.getWh_use());
		}

		params.put("startPage", vo.getStartPage());
		params.put("pageSize", vo.getPageSize());

		return sqlSession.selectList(NAMESPACE + ".searchWareHouse", params);
	}

	// 검색시 총 글 개수 계산
	@Override
	public int searchWh_TotalCount(Wh_prodVO wvo) throws Exception {
		logger.debug("@@ searchWh_TotalCount(Wh_prodVO wvo) 호출 @@");

		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("wh_code", wvo.getWh_code());

//		if(wvo.getProd_code() != null) {
//			params.put("prod_code", wvo.getProd_code());
//		}else if(wvo.getRaw_code() != null) {
//			params.put("raw_code", wvo.getRaw_code());
//		}
		
		params.put("wh_addr", wvo.getWh_addr());
		
		if(wvo.getWh_use() != 0) {
			params.put("wh_use", wvo.getWh_use());
		}
		
		params.put("emp_id", wvo.getEmp_id());
//		params.put("emp_name", wvo.getEmp().getEmp_name());
		
		return sqlSession.selectOne(NAMESPACE+".searchWhTotalCnt", params);

	}
	
	// 창고 추가
	@Override
	public void registWh(Wh_prodVO wvo) throws Exception {
		logger.debug("@@ D : registWh(Wh_prodVO wvo) 호출 @@");
		
		sqlSession.insert(NAMESPACE+".registWh", wvo);
	}
	
	// 창고 삭제
	@Override
	public void deleteWh(List<String> checked) throws Exception {
		logger.debug("@@ D : deleteWh(List<String> checked) 호출 @@");
		
		Iterator<String> it = checked.iterator();
		int result = 0;
		
		while(it.hasNext()) {
			String wh_code = it.next();
			result += sqlSession.delete(NAMESPACE+".deleteWh", wh_code);
		}
		logger.debug("@@ D : delete ==> "+result);
	}

	// 창고 수정
	@Override
	public void modifyWh(Wh_prodVO wvo) throws Exception {
		logger.debug("@@ D : modifyWh(Wh_prodVO wvo) 호출 @@");
		
		sqlSession.update(NAMESPACE+".updateWh", wvo);
	}

	// 창고 조회(String wh_code)
	@Override
	public Wh_prodVO getWarehouse(String wh_code) throws Exception {
		logger.debug("@@ D : getWarehouse(String wh_code) 호출 @@");
		
		return sqlSession.selectOne(NAMESPACE+".readWhList", wh_code);
	}
	
	// 창고 추가 시 code값 가져가기
	@Override
	public String getWhCode() {
		
		String code = "WH000";
		
		if(sqlSession.selectOne(NAMESPACE+".getWhCode") == null) {
			return code;
		}else {
			return sqlSession.selectOne(NAMESPACE+".getWhCode");
		}
	}

	// ==========================================================================

	//생산실적 목록 - 전체
	@Override
	public List<PerformanceVO> readPerfList(LineWhPageVO pvo) throws Exception {
		logger.debug("##### DAO: readAllPerf() 호출");

		return sqlSession.selectList(NAMESPACE + ".performList", pvo);
	} // readAllPerf()
	
	//생산실적 등록
	@Override
	public void createPerformance(PerformanceVO vo) throws Exception {
		logger.debug("##### DAO: createPerformance() 호출");
		
		sqlSession.insert(NAMESPACE + ".insertPerform", vo);
		
		//DB작업 위해서 작업지시코드 변수에 저장
		String work_code = vo.getWork_code();
		
		//생산실적 중 양품수와 작업지시수량 비교
		String result = sqlSession.selectOne(NAMESPACE + ".compare", work_code);
		logger.debug("##### DAO: 양품수와 작업지시수량 비교 결과 있없 ===> " + result);
		
		//비교결과 해당 작업지시수량보다 생산한 양품수가 같거나 많으면 생산현황 마감으로 변경
		// => 마감으로 변경됐을 경우 해당 작업지시 양품수 합해서 재고에 더하기
		if(result != null) {
			sqlSession.update(NAMESPACE + ".updateStatus", work_code);
			
			int perform_fair = sqlSession.selectOne(NAMESPACE + ".sumFair", work_code);
			logger.debug("##### DAO: 양품수 합 ===> " + perform_fair);
			
			StockVO stock = sqlSession.selectOne(NAMESPACE + ".searchStock", work_code);
			logger.debug("##### DAO: 일치품목 ===> " + stock.getProd_code());
//			String prod_code = stock.getProd_code();
			
			stock.setStock_count(perform_fair);
			
			sqlSession.update(NAMESPACE + ".updateStock", stock);
			
			logger.debug("##### DAO: 재고등록완~~~~~~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!");
		} //if(마감쳤을때)
		
		
	} // createPerformance()

	//생산실적 삭제
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

	//생산실적 조회
	@Override
	public PerformanceVO readPerformanceInfo(String performCode) throws Exception {
		logger.debug("##### DAO: readPerformanceInfo() 호출");
		return sqlSession.selectOne(NAMESPACE + ".performInfo", performCode);
	} //readPerformanceInfo()

	//생산실적 수정
	@Override
	public void updatePerformance(PerformanceVO uvo) throws Exception {
		logger.debug("##### DAO: updatePerformance() 호출");
		int result = sqlSession.update(NAMESPACE + ".updatePerform", uvo);
		
		logger.debug("##### DAO: update 결과 ===> " + result);
	} //updatePerformance()

	//생산실적 전체 수
	@Override
	public int getPerfCnt() throws Exception {
		logger.debug("##### DAO: getTotalPerf() 호출");
		
		return sqlSession.selectOne(NAMESPACE + ".getTotalPerf");
	} //getTotalPerf()

	//생산실적 목록 - 검색
	@Override
	public List<PerformanceVO> readPerfList(HashMap<String, Object> search) throws Exception {
		logger.debug("##### DAO: readPerfList(search) 호출");
		return sqlSession.selectList(NAMESPACE + ".performSearchList", search);
	} //readPerfList(search)

	//생산실적 검색 수
	@Override
	public int getPerfCnt(HashMap<String, Object> search) throws Exception {
		logger.debug("##### DAO: getPerfCnt(search) 호출");
		return sqlSession.selectOne(NAMESPACE + ".getSearchPerf", search);
	} //getPerfCnt(search)

	//생산실적 양불 현황
	@Override
	public Map<String, List<PerformanceVO>> getPerformStatus() throws Exception {
		logger.debug("##### DAO: getPerformStatus() 호출");
		
		Map<String, List<PerformanceVO>> statusMap = new HashMap<>();
		
		List<PerformanceVO> statusLineList = sqlSession.selectList(NAMESPACE + ".statusLine");
		logger.debug("##### DAO: 라인별 양불현황 ===> " + statusLineList);
		
		List<PerformanceVO> statusProdList = sqlSession.selectList(NAMESPACE + ".statusProd");
		logger.debug("##### DAO: 품목별 양불현황 ===> " + statusProdList);
		
		List<PerformanceVO> statusDateList = sqlSession.selectList(NAMESPACE + ".statusDate");
		logger.debug("##### DAO: 일자별 양불현황 ===> " + statusDateList);
		
		statusMap.put("perLine", statusLineList);
		statusMap.put("perProd", statusProdList);
		statusMap.put("perDate", statusDateList);
		
		return statusMap;
	} //getPerformStatus()






}
