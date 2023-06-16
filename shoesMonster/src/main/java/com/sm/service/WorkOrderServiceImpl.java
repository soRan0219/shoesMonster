package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.WorkOrderVO;
import com.sm.persistence.WorkOrderDAO;

@Service
public class WorkOrderServiceImpl implements WorkOrderService {

	@Autowired
	private WorkOrderDAO wdao;
	
	@Override
	public List<WorkOrderVO> getAllWorkOrder() throws Exception {
		// DAO에서 가져오기
		
		return wdao.readAllWorkOrder();
	} //getAllWorkOrder()

} //WorkOrderServiceImpl
