package com.sm.service;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.ClientPageVO;
import com.sm.domain.ClientsVO;
import com.sm.domain.OrderStatusVO;

public interface OrderStatusService {
	// 수행하는 동작 선언
	
	// 수주 현황 목록 불러오기
	public List<OrderStatusVO> getOsList(ClientPageVO cpvo) throws Exception;

	// 수주 현황 검색
	public List<OrderStatusVO> getSearchOrderStatus(HashMap<String, Object> search) throws Exception;
	
	// 수주 현황 전체 개수
	public int getTotalOrderStatus() throws Exception;
	
	// 수주 현황 검색 개수
	public int getSearchCountOrderStatus(HashMap<String, Object> search) throws Exception;
	
	// 수주 등록
	public void registOrder(OrderStatusVO osvo) throws Exception;
	
	// 수주 삭제
	public void deleteOrder(List<String> checked) throws Exception;
	
	// 수주 수정
	public void updateOrder(OrderStatusVO cvo) throws Exception;
	
	// 수주 관리 조회
	public List<ClientsVO> getOrderManageList() throws Exception;
	
	
	
}
