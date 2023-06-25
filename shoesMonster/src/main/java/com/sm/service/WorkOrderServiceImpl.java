package com.sm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.LineWhPageVO;
import com.sm.domain.WorkOrderVO;
import com.sm.persistence.WorkOrderDAO;

@Service
public class WorkOrderServiceImpl implements WorkOrderService {
	
	@Autowired
	private WorkOrderDAO wdao;
	
	@Override
	public List<WorkOrderVO> getAllWorkOrder(LineWhPageVO pvo) throws Exception {
		// DAO에서 가져오기
		
		return wdao.readAllWorkOrder(pvo);
	} //getAllWorkOrder()

	@Override
	public void regWorkOrder(WorkOrderVO vo) throws Exception {
		// DAO - 작업지시 등록
		wdao.insertWorkOrder(vo);
	} //regWorkOrder()

	@Override
	public void removeWorkOrder(List<String> checked) throws Exception {
		// DAO - 작업지시 삭제
		wdao.deleteWorkOrder(checked);
	} //removeWorkOrder()

	@Override
	public WorkOrderVO getWorkOrder(String work_code) throws Exception {
		// DAO - 작업지시 조회
		return wdao.readWorkOrder(work_code);
	} //getWorkOrder()

	@Override
	public void modifyWorkOrder(WorkOrderVO uvo) throws Exception {
		// DAO - 작업지시 수정
		wdao.updateWorkOrder(uvo);
	} //modifyWorkOrder()

	@Override
	public List<WorkOrderVO> searchWorkOrder(HashMap<String, Object> search) throws Exception {
		// DAO - 작업지시 검색
		return wdao.selectWorkOrder(search);
	} //searchWorkOrder()

	@Override
	public int getTotalWorkOrder() throws Exception {
		// DAO - 작업지시 전체 개수
		return wdao.getTotalWorkOrder();
	} //getTotalWorkOrder()

	@Override
	public int getSearchWorkOrder(HashMap<String, Object> search) throws Exception {
		// DAO - 작업지시 검색 개수
		return wdao.getSearchWOrkOrder(search);
	} //getSearchWorkOrder()

} //WorkOrderServiceImpl
