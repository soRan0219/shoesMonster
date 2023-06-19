package com.sm.service;

import com.sm.domain.EmployeesVO;

public interface EmployeesService {
	
	// 로그인
	public EmployeesVO empLogin(EmployeesVO empvo);
	
	// 회원정보 조회
	public EmployeesVO getEmployees(String id);
	
}
