package com.sm.persistence;

import java.util.List;

import com.sm.domain.WorkOrderVO;

public interface WorkOrderDAO {
	
	//작업지시 목록
	public List<WorkOrderVO> readAllWorkOrder() throws Exception;
	
	//작업지시 등록
	public void insertWorkOrder(WorkOrderVO vo) throws Exception;
	
	//작업지시 삭제
	public void deleteWorkOrder(List<String> checked) throws Exception;
	
	//작업지시 조회
	public WorkOrderVO readWorkOrder(String work_code) throws Exception;
	
	//작업지시 수정
	public void updateWorkOrder(WorkOrderVO uvo) throws Exception;
	
} //WorkOrderDAO
