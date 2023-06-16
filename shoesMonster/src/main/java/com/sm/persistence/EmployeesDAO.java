package com.sm.persistence;

import com.sm.domain.EmployeesVO;

public interface EmployeesDAO {
	
	// 로그인
	public EmployeesVO loginEmp(EmployeesVO empvo);
	
	public EmployeesVO loginEmp(String id, String pw);
}
