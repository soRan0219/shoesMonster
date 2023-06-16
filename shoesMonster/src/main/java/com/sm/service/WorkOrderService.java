package com.sm.service;

import java.util.List;

import com.sm.domain.WorkOrderVO;

public interface WorkOrderService {
	
	//작업지시 목록 조회 
	public List<WorkOrderVO> getAllWorkOrder() throws Exception;
	
} //WorkOrderService
