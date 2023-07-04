package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.ClientPageVO;
import com.sm.domain.EmployeesVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.ManagementVO;
import com.sm.domain.WorkOrderVO;

public interface EmployeesDAO {
	
	// 로그인
	public EmployeesVO loginEmp(EmployeesVO empvo);
	
	public EmployeesVO loginEmp(String id, String pw);
	
	// 사원 목록 조회 - R
	public List<EmployeesVO> readEmpList(ClientPageVO cpvo) throws Exception;
	
	// 사원 권한 정보 조회 - R
	public List<ManagementVO> readManagement() throws Exception;
	
	// 사원 검색
	public List<EmployeesVO> getSearchEmployeesList(HashMap<String, Object> search) throws Exception;

	// 사원 전체 수
	public int getTotalEmployees() throws Exception;
	
	// 사원 검색 수
	public int getSearchEmployees(HashMap<String, Object> search) throws Exception;
	
	// 사원 추가
	public void insertEmployees(EmployeesVO evo) throws Exception;
	
	// 사원 삭제
	public void deleteEmployees(List<String> checked) throws Exception;
	
	// 사원 상세 조회
	public EmployeesVO readEmployees(String emp_id) throws Exception;
	
	// 사원 수정
	public void updateEmployees(EmployeesVO uvo) throws Exception;
	
	// 사원 사진 
	public void updateEmployeesImg(String img,String emp_id) throws Exception;
}
