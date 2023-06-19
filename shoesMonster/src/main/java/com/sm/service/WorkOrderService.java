package com.sm.service;

import java.util.List;

import com.sm.domain.WorkOrderVO;

public interface WorkOrderService {
	
	//작업지시 목록 조회 
	public List<WorkOrderVO> getAllWorkOrder() throws Exception;
	
	//작업지시 등록
	public void regWorkOrder(WorkOrderVO vo) throws Exception;
	
	//작업지시 삭제
	public void removeWorkOrder(List<String> checked) throws Exception;
	
	//작업지시 조회
	public WorkOrderVO getWorkOrder(String work_code) throws Exception;
	
} //WorkOrderService
