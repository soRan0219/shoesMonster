package com.sm.service;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.ClientsVO;
import com.sm.domain.OrderStatusVO;

public interface OrderStatusService {
	// 수행하는 동작 선언
	
	// 수주 현황 목록 불러오기
	public List<OrderStatusVO> getOsList() throws Exception;

	// 수주 현황 검색
	public List<OrderStatusVO> getSearchOrderStatus(HashMap<String, Object> search) throws Exception;
//	public List<OrderStatusVO> getSearchOrderStatus2(HashMap<String, Object> search) throws Exception;
	
	// 수주 관리 조회
	public List<ClientsVO> getOrderManageList() throws Exception;
	
	
	
}
