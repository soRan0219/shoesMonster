package com.sm.persistence;

import java.util.List;

import com.sm.domain.ClientsVO;
import com.sm.domain.OrderStatusVO;

public interface OrderStatusDAO {
	// DB 동작 선언 / 호출
	
	// 수주 현황 목록 불러오기
	public List<OrderStatusVO> readOrderStatusList() throws Exception;
	
	// 수주 관리 조회
	public List<ClientsVO> readOrderManageList() throws Exception;
	
}
