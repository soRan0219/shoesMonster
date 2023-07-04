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
	public void insertWorkOrder(WorkOrderVO vo) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");
		
		
		//DB 처리 위해 완제품 코드 저장
		String prod_code = vo.getProd_code();
		
		//해당 완제품에 필요한 원자재 재고 테이블에 있는지 조회
		List<StockVO> stockList = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prod_code);
		logger.debug("##### DAO: 완제품에 필요한 원자재 재고 현황 " + stockList);
		
		//있으면 원자재 재고수와 지시수량*원자재 소요량 비교 (반복문)
		if(stockList.size() > 0) {
			for(StockVO stock : stockList) {
				
				//원자재 재고 
				stock.getStock_count();
				//지시수량
				vo.getWork_qt();
				//지시수량*원자재소요량
				
				
				// 원자재 재고 - 지시수량*원자재 소요량 >= 0
				// -> 원자재 재고 - 지시수량*원자재 소요량
				
				
				int result = sqlSession.insert(NAMESPACE + ".insertWorkOrder", vo);
				logger.debug("##### DAO: insert 결과 ====> " + result);
				
				// 원자재 재고 - 지시수량*원자재 소요량 < 0
				// -> 작업지시 등록 불가
				
			} //for(stockList)
			
			
		} else {
			//없으면 
			// -> 작업지시 등록 불가
			
			
		} //if(완제품에 필요한 원자재 재고 있없)
		
	} //updateWorkOrder()

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
	public void updateWorkOrder(WorkOrderVO uvo) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");
		int result = sqlSession.update(NAMESPACE + ".updateWorkOrder", uvo);
		logger.debug("##### DAO: update 결과 ===> " + result);
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

} //WorkOrderDAOImpl
