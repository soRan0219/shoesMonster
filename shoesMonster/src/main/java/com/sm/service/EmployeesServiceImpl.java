package com.sm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.EmployeesVO;
import com.sm.persistence.EmployeesDAO;

@Service
public class EmployeesServiceImpl implements EmployeesService{

	@Autowired
	private EmployeesDAO empdao;

	@Override
	public EmployeesVO empLogin(EmployeesVO empvo) {
		EmployeesVO resultVO = empdao.loginEmp(empvo);
		return resultVO;
	}

	@Override
	public EmployeesVO getEmployees(String id) {
		return empdao.getEmloyees(id);
	}
	
	
	
}
