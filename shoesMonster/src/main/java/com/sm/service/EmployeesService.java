package com.sm.service;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.EmployeesVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.ManagementVO;

public interface EmployeesService {
	
	// 로그인
	public EmployeesVO empLogin(EmployeesVO empvo);
	
	// 사원 목록 조회 - Read
	public List<EmployeesVO> getEmpList(LineWhPageVO pvo) throws Exception;
	
	// 사원 관리 정보 조회 - Read
	public List<ManagementVO> getManagement() throws Exception;
	
	// 사원 검색
	public List<EmployeesVO> searchEmployees(HashMap<String, Object> search) throws Exception;
	
}
