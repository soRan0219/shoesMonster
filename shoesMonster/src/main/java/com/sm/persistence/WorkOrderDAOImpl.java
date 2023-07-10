package com.sm.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.LineWhPageVO;
import com.sm.domain.RequirementsVO;
import com.sm.domain.StockVO;
import com.sm.domain.WorkOrderVO;

@Repository
public class WorkOrderDAOImpl implements WorkOrderDAO {
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderDAOImpl.class);
	
	private static final String NAMESPACE = "com.sm.mapper.workorderMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	//작업지시 전체 목록
	@Override
	public List<WorkOrderVO> readAllWorkOrder(LineWhPageVO pvo) throws Exception {
		logger.debug("##### DAO: readAllWorkOrder() 호출");
		
		return sqlSession.selectList(NAMESPACE + ".allWorkOrder", pvo);
	} //readAllWorkOrder()

	//작업지시 등록
	@Override
	public int insertWorkOrder(WorkOrderVO vo) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");
		
		int rawExist = 0;
		
		//DB 처리 위해 완제품 코드 저장
		String prod_code = vo.getProd_code();
		
		//원자재 소요량 목록
		List<RequirementsVO> reqList = sqlSession.selectList(NAMESPACE + ".consumption", prod_code);
		
		//해당 완제품에 필요한 원자재 재고 테이블에 있는지 조회
		List<StockVO> stockList = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prod_code);
		logger.debug("##### DAO: 완제품에 필요한 원자재 재고 유무 " + stockList.size());
		
		//있으면 원자재 재고수와 지시수량*원자재 소요량 비교 (반복문)
		if(stockList.size() > 0) {
			//지시수량
			int workQt = vo.getWork_qt();
			
			int minus = 0;
			boolean check = true;
			
			for(int i=0; i<stockList.size(); i++) {
				
				String raw_code = stockList.get(i).getRaw_code();
				logger.debug("##### DAO 원자재 코드 = " + raw_code);
				
				//원자재 재고 
				int rawStock = stockList.get(i).getStock_count();
				logger.debug("##### DAO 원자재 재고 = " + rawStock);
				//원자재 소요량
				int rawReq = Integer.parseInt(reqList.get(i).getReq_dan());
				//지시수량*원자재소요량
				minus = workQt*rawReq;
				logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
				
				if(rawStock-minus < 0) {
					// 원자재 재고 - 지시수량*원자재 소요량 < 0
					// -> 작업지시 등록 불가
					check = false;
					break;
				}
			} //for(stockList)
			
			if(check) {
				for(int i=0; i<stockList.size(); i++) {
					
					String raw_code = stockList.get(i).getRaw_code();
					logger.debug("##### DAO 원자재 코드 = " + raw_code);
					
					//원자재 재고 
					int rawStock = stockList.get(i).getStock_count();
					logger.debug("##### DAO 원자재 재고 = " + rawStock);
					//원자재 소요량
					int rawReq = Integer.parseInt(reqList.get(i).getReq_dan());
					//지시수량*원자재소요량
					minus = workQt*rawReq;
					logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
					
					if(rawStock-minus >= 0) {
						// 원자재 재고 - 지시수량*원자재 소요량 >= 0
						// -> 원자재 재고 - 지시수량*원자재 소요량
						stockList.get(i).setStock_count(minus);
						sqlSession.update(NAMESPACE + ".reduceRaw", stockList.get(i));
						logger.debug("##### DAO: 원자재 재고 차감 완료");
						
					} //원자재 재고 차감 
					
				} //for(stockList)
				
				//작업지시 등록
				int result = sqlSession.insert(NAMESPACE + ".insertWorkOrder", vo);
				logger.debug("##### DAO: insert 결과 ====> " + result);
				
				rawExist = 1;
//				return rawExist;
			} //if(원자재 모두 있을 때만)
			
			
		} else {
			//없으면 
			// -> 작업지시 등록 불가
			logger.debug("##### DAO: 원자재 재고 없음");
			
//			return rawExist;
		} //if(완제품에 필요한 원자재 재고 있없)
		
		return rawExist;
	} //insertWorkOrder()

	//작업지시 등록 - 1차공정 사용 가능 라인코드 가져오기
	@Override
	public String getLineCode() throws Exception {
		logger.debug("##### DAO: getLineCode() 호출");
		
		String lineCode = sqlSession.selectOne(NAMESPACE + ".selectLine");
		logger.debug("##### DAO: lineCode ===> " + lineCode);
		
		return lineCode;
	} //getLineCode()
	
	//작업지시 삭제
	@Override
	public void deleteWorkOrder(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteWorkOrder() 호출");
		
		Iterator<String> it = checked.iterator();
		int result = 0;
		
		while(it.hasNext()) {
			String work_code = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteWorkOrder", work_code);
		}
		
		logger.debug("##### DAO: delete 결과 ===> " + result);
	} //deleteWorkOrder()

	//특정 작업지시 조회
	@Override
	public WorkOrderVO readWorkOrder(String work_code) throws Exception {
		logger.debug("##### DAO: readWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".readWorkOrder", work_code);
	} //readWorkOrder()

	
	//작업지시 수정
	@Override
	public int updateWorkOrder(WorkOrderVO uvo) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");
		
		int rawExist = 0;
		
		// (uvo 지시수량 - 기존컬럼 지시수량) 만큼 재고수량에서 차감
		int originQt = readWorkOrder(uvo.getWork_code()).getWork_qt();
		String prod_code = uvo.getProd_code();
		
		//원자재 소요량 목록
		List<RequirementsVO> reqList = sqlSession.selectList(NAMESPACE + ".consumption", prod_code);
				
		//해당 완제품에 필요한 원자재 재고 테이블에 있는지 조회
		List<StockVO> stockList = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prod_code);
		
		//있으면 원자재 재고수와 (uvo 지시수량 - 기존컬럼 지시수량)*원자재 소요량 비교 (반복문)
		if(stockList.size() > 0) {
			//(uvo 지시수량 - 기존컬럼 지시수량)
			int workQt = uvo.getWork_qt() - originQt;
			
			int minus = 0;
			boolean check = true;
			
			for(int i=0; i<stockList.size(); i++) {
				
				String raw_code = stockList.get(i).getRaw_code();
				logger.debug("##### DAO 원자재 코드 = " + raw_code);
				
				//원자재 재고 
				int rawStock = stockList.get(i).getStock_count();
				logger.debug("##### DAO 원자재 재고 = " + rawStock);
				//원자재 소요량
				int rawReq = Integer.parseInt(reqList.get(i).getReq_dan());
				//(uvo 지시수량 - 기존컬럼 지시수량)*원자재소요량
				minus = workQt*rawReq;
				logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
				
				if(rawStock-minus < 0) {
					// 원자재 재고 - (uvo 지시수량 - 기존컬럼 지시수량)*원자재 소요량 < 0
					// -> 작업지시 수정 불가
					check = false;
					break;
				}
			} //for(stockList)
			
			if(check) {
				for(int i=0; i<stockList.size(); i++) {
					
					String raw_code = stockList.get(i).getRaw_code();
					logger.debug("##### DAO 원자재 코드 = " + raw_code);
					
					//원자재 재고 
					int rawStock = stockList.get(i).getStock_count();
					logger.debug("##### DAO 원자재 재고 = " + rawStock);
					//원자재 소요량
					int rawReq = Integer.parseInt(reqList.get(i).getReq_dan());
					//(uvo 지시수량 - 기존컬럼 지시수량)*원자재소요량
					minus = workQt*rawReq;
					logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
					
					if(rawStock-minus >= 0) {
						// 원자재 재고 - (uvo 지시수량 - 기존컬럼 지시수량)*원자재 소요량 >= 0
						// -> 원자재 재고 - (uvo 지시수량 - 기존컬럼 지시수량)*원자재 소요량
						stockList.get(i).setStock_count(minus);
						sqlSession.update(NAMESPACE + ".reduceRaw", stockList.get(i));
						logger.debug("##### DAO: 원자재 재고 차감 완료");
						
						rawExist = 1;
					} //재고차감
					
				} //for(stockList)
				
				//작업지시 수정
				int result = sqlSession.update(NAMESPACE + ".updateWorkOrder", uvo);
				logger.debug("##### DAO: update 결과 ===> " + result);
			} //if(원자재 모두 있을 때만)
					
					
		} else {
			//없으면 
			// -> 작업지시 수정 불가
			logger.debug("##### DAO: 원자재 재고 없음");
		} //if(완제품에 필요한 원자재 재고 있없)
		
		
		return rawExist;
	} //updateWorkOrder()

	
	//작업지시 검색
	@Override
	public List<WorkOrderVO> selectWorkOrder(HashMap<String, Object> search) throws Exception {
		logger.debug("##### DAO: selectWorkOrder() 호출");
		
		List<WorkOrderVO> searchList = sqlSession.selectList(NAMESPACE + ".searchWorkOrder", search);
		logger.debug("##### DAO: search 결과 ===> " + searchList);
		
		return searchList;
	} //selectWorkOrder()

	//작업지시 전체 수
	@Override
	public int getTotalWorkOrder() throws Exception {
		logger.debug("##### DAO: getTotalWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".workOrderAllCnt");
	} //getTotalWorkOrder()

	//작업지시 검색 수
	@Override
	public int getSearchWOrkOrder(HashMap<String, Object> search) throws Exception {
		logger.debug("#####DAO: getSearchWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".searchWorkOrderCnt", search);
	} //getSearchWorkOrder()

	//작업지시 현재 작업 공정 변경
	@Override
	public void updateStatus(WorkOrderVO vo) throws Exception {
		logger.debug("##### DAO: updateStatus() 호출");
		sqlSession.update(NAMESPACE + ".updateStatus", vo);
	} //updateStatus()


} //WorkOrderDAOImpl
