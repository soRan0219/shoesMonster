package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.OrderStatusVO;
import com.sm.persistence.OrderStatusDAO;

@Service
public class OrderStatusServiceImpl implements OrderStatusService {

	@Autowired
	private OrderStatusDAO osdao;
	
	// 수주 현황 목록 불러오기
	@Override
	public List<OrderStatusVO> getOsList() throws Exception {
		return osdao.readOrderStatusList();
	}

	@Override
	public List<OrderStatusVO> getOrderManageList() throws Exception {
		return osdao.readOrderManageList();
	}
	
	
	
}
