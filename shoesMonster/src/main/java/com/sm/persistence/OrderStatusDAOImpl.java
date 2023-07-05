package com.sm.persistence;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.ClientPageVO;
import com.sm.domain.ClientsVO;
import com.sm.domain.OrderStatusVO;

@Repository
public class OrderStatusDAOImpl implements OrderStatusDAO {
	
	// 디비 연결 정보, mapper 접근 => SqlSession 객체
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger 
					= LoggerFactory.getLogger(OrderStatusDAOImpl.class);
	
	private static final String NameSpace = "com.sm.mapper.PersonMapper";
	
	// 수주 현황 목록 불러오기 
	@Override
	public List<OrderStatusVO> readOrderStatusList(ClientPageVO cpvo) throws Exception {
		logger.debug("@@@ DAO : readOrderStatusList() 호출 @@@");
		return sqlSession.selectList(NameSpace +".orderStatusList",cpvo);
	}
	
	// 수주 현황 검색
	@Override
	public List<OrderStatusVO> getSearchOrderStatus(HashMap<String, Object> search) throws Exception {
		logger.debug("@@@ DAO : getSearchOrderStatus(HashMap<String, Object> search) 호출 @@@");
		return sqlSession.selectList(NameSpace + ".searchOrderStatusList", search);
	}
	
	// 수주 현황 전체 개수
	@Override
	public int getTotalOrderStatus() throws Exception {
		logger.debug("@@@ DAO : getTotalOrderStatus() 호출 @@@");
		return sqlSession.selectOne(NameSpace+".orderStatusALLcnt");
	}

	// 수주 현황 검색 개수
	@Override
	public int getSearchCountOrderStatus(HashMap<String, Object> search) throws Exception {
		logger.debug("@@@ DAO : getSearchCountOrderStatus() 호출 @@@");
		return sqlSession.selectOne(NameSpace+".searchOrderStatusCnt", search);
	}

	// 수주 등록
	@Override
	public void registOrder(OrderStatusVO osvo) throws Exception {
		logger.debug("@@@ DAO : registOrder(OrderStatusVO osvo) 호출");
		
		sqlSession.insert(NameSpace+".registOrder", osvo);
	}
	
	// 수주 삭제
	@Override
	public void deleteOrder(List<String> checked) throws Exception {
		logger.debug("@@@ DAO : deleteOrder() 호출 @@@");
		
		Iterator<String> it = checked.iterator();
		int result = 0;
		
		while(it.hasNext()) {
			String order_code = it.next();
			result += sqlSession.delete(NameSpace+".deleteOrder", order_code);
		}
		
		logger.debug("@@@ DAO delete 결과 : "+result);
		
	}
	
	// 수주 수정
	@Override
	public void updateOrder(OrderStatusVO cvo) throws Exception {
		logger.debug("@@@ DAO : updateOrder() 호출 @@@");
		int result = sqlSession.update(NameSpace+".updateOrder", cvo);
		logger.debug("@@@ DAO update 결과 : "+result);
	}
	
	// 수주 관리 조회
	@Override
	public List<ClientsVO> readOrderManageList() throws Exception {
		logger.debug(" readOrderManageList() 호출@@@@@ ");
		return sqlSession.selectList(NameSpace + ".orderManageList");
	}





	
	
}
