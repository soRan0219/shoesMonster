package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.LineWhPageVO;
import com.sm.domain.WorkOrderVO;

public interface WorkOrderDAO {
	
	//작업지시 목록
	public List<WorkOrderVO> readAllWorkOrder(LineWhPageVO pvo) throws Exception;
	
	//작업지시 등록
	public int insertWorkOrder(WorkOrderVO vo) throws Exception;
	
	//작업지시 삭제
	public void deleteWorkOrder(List<String> checked) throws Exception;
	
	//작업지시 조회
	public WorkOrderVO readWorkOrder(String work_code) throws Exception;
	
	//작업지시 수정
	public int updateWorkOrder(WorkOrderVO uvo) throws Exception;
	
	//작업지시 검색
	public List<WorkOrderVO> selectWorkOrder(HashMap<String, Object> search) throws Exception;
	
	//작업지시 전체 개수
	public int getTotalWorkOrder() throws Exception;
	
	//작업지시 검색 개수
	public int getSearchWOrkOrder(HashMap<String, Object> search) throws Exception;
	
	//작업지시 현재 작업 공정 변경
	public void updateStatus(WorkOrderVO vo) throws Exception;
	
} //WorkOrderDAO
