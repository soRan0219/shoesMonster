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
	public int regWorkOrder(WorkOrderVO vo) throws Exception {
		// DAO - 작업지시 등록
		return wdao.insertWorkOrder(vo);
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
	public int modifyWorkOrder(WorkOrderVO uvo) throws Exception {
		// DAO - 작업지시 수정
		return wdao.updateWorkOrder(uvo);
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

	@Override
	public void modifyStatus(WorkOrderVO vo) throws Exception {
		// DAO - 작업지시 현재 작업 공정 변경
		wdao.updateStatus(vo);
	} //modifyStatus()

	@Override
	public String getLineCode() throws Exception {
		// DAO - 작업지시 등록 시 1차공정 라인 가져오기
		return wdao.getLineCode();
	}

} //WorkOrderServiceImpl
