package com.sm.service;

import java.util.List;

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
	public List<EmployeesVO> getEmpList() throws Exception {
		return empdao.readEmpList();
	}

	@Override
	public EmployeesVO getEmpRead(Integer empbno) throws Exception {
		return empdao.readEmp(empbno);
	}
	
	
	
	

	
	
	
}
