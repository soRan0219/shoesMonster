package com.sm.service;

import java.util.List;

import com.sm.domain.EmployeesVO;
import com.sm.domain.ManagementVO;

public interface EmployeesService {
	
	// 로그인
	public EmployeesVO empLogin(EmployeesVO empvo);
	
	// 사원 목록 조회 - Read
	public List<EmployeesVO> getEmpList() throws Exception;
	
	// 사원 관리 정보 조회 - Read
	public List<ManagementVO> getManagement() throws Exception;
	
	
}
