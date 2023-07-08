package com.sm.service;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.LineWhPageVO;
import com.sm.domain.WorkOrderVO;

public interface WorkOrderService {
	
	//작업지시 목록 조회 
	public List<WorkOrderVO> getAllWorkOrder(LineWhPageVO pvo) throws Exception;
	
	//작업지시 등록
	public int regWorkOrder(WorkOrderVO vo) throws Exception;
	
	//작업지시 삭제
	public void removeWorkOrder(List<String> checked) throws Exception;
	
	//작업지시 조회
	public WorkOrderVO getWorkOrder(String work_code) throws Exception;
	
	//작업지시 수정
	public int modifyWorkOrder(WorkOrderVO uvo) throws Exception;
	
	//작업지시 검색
	public List<WorkOrderVO> searchWorkOrder(HashMap<String, Object> search) throws Exception;
	
	//작업지시 전체 개수
	public int getTotalWorkOrder() throws Exception;
	
	//작업지시 검색 개수
	public int getSearchWorkOrder(HashMap<String, Object> search) throws Exception;
	
	//작업지시 현재 작업공정 변경
	public void modifyStatus(WorkOrderVO vo) throws Exception;
	
} //WorkOrderService
