package com.sm.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sm.domain.EmployeesVO;
import com.sm.persistence.EmployeesDAO;

@Service
public class EmployeesServiceImpl implements EmployeesService{

	@Inject
	private EmployeesDAO empdao;

	@Override
	public EmployeesVO empLogin(EmployeesVO empvo) {
		EmployeesVO resultVO = empdao.loginEmp(empvo);
		return resultVO;
	}
	
	
	
}
