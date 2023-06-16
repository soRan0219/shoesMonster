package com.sm.persistence;

import java.util.List;

import com.sm.domain.WorkOrderVO;

public interface WorkOrderDAO {
	
	//작업지시 목록
	public List<WorkOrderVO> readAllWorkOrder() throws Exception;
	
} //WorkOrderDAO
