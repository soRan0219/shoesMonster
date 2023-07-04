package com.sm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.ClientPageVO;
import com.sm.domain.ClientsVO;
import com.sm.domain.OrderStatusVO;
import com.sm.persistence.OrderStatusDAO;

@Service
public class OrderStatusServiceImpl implements OrderStatusService {

	@Autowired
	private OrderStatusDAO osdao;
	
	// 수주 현황 목록 불러오기
	@Override
	public List<OrderStatusVO> getOsList(ClientPageVO cpvo) throws Exception {
		return osdao.readOrderStatusList(cpvo);
	}

	// 수주 현황 검색
	@Override
	public List<OrderStatusVO> getSearchOrderStatus(HashMap<String, Object> search) throws Exception {
		return osdao.getSearchOrderStatus(search);
	}

	// 수주 현황 전체 개수
	@Override
	public int getTotalOrderStatus() throws Exception {
		return osdao.getTotalOrderStatus();
	}

	// 수주 현황 검색 개수
	@Override
	public int getSearchCountOrderStatus(HashMap<String, Object> search) throws Exception {
		return osdao.getSearchCountOrderStatus(search);
	}

	// 수주 등록
	@Override
	public void registOrder(OrderStatusVO osvo) throws Exception {
		osdao.registOrder(osvo);
	}
	
	// 수주 삭제
	@Override
	public void deleteOrder(List<String> checked) throws Exception {
		osdao.deleteOrder(checked);
	}
	
	// 수주 수정
	@Override
	public void updateOrder(OrderStatusVO cvo) throws Exception {
		osdao.updateOrder(cvo);
	}
	
	@Override
	public List<ClientsVO> getOrderManageList() throws Exception {
		return osdao.readOrderManageList();
	}


	


	
	
	
}
