package com.sm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.EmployeesVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.ManagementVO;
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
	public List<EmployeesVO> getEmpList(LineWhPageVO pvo) throws Exception {
		return empdao.readEmpList(pvo);
	}

	@Override
	public List<ManagementVO> getManagement() throws Exception {
		return empdao.readManagement();
	}

	@Override
	public List<EmployeesVO> searchEmployees(HashMap<String, Object> search) throws Exception {
		return empdao.selectEmployees(search);
	}

	@Override
	public int getTotalEmployees() throws Exception {
		return empdao.getTotalEmployees();
	}

	@Override
	public int getSearchEmployees(HashMap<String, Object> search) throws Exception {
		return empdao.getSearchEmployees(search);
	}

	
	
	
	

	
	
	
}
