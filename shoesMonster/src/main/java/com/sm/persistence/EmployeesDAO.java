package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.EmployeesVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.ManagementVO;

public interface EmployeesDAO {
	
	// 로그인
	public EmployeesVO loginEmp(EmployeesVO empvo);
	
	public EmployeesVO loginEmp(String id, String pw);
	
	// 사원 목록 조회 - R
	public List<EmployeesVO> readEmpList(LineWhPageVO pvo) throws Exception;
	
	// 사원 권한 정보 조회 - R
	public List<ManagementVO> readManagement() throws Exception;

	// 사원 검색
	public List<EmployeesVO> selectEmployees(HashMap<String, Object> search) throws Exception;
	
	// 사원 전체 수
	public int getTotalEmployees() throws Exception;
	
	// 사원 검색 수
	public List<EmployeesVO> getSearchEmployees(HashMap<String, Object> search) throws Exception;
	
	// 사원 추가
	public void insertEmployees(EmployeesVO vo) throws Exception;
}
