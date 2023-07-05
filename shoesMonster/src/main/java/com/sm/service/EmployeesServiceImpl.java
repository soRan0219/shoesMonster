package com.sm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.ClientPageVO;
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
	public List<EmployeesVO> getEmpList(ClientPageVO cpvo) throws Exception {
		return empdao.readEmpList(cpvo);
	}

	@Override
	public List<ManagementVO> getManagement() throws Exception {
		return empdao.readManagement();
	}

	@Override
	public List<EmployeesVO> getSearchEmployeesList(HashMap<String, Object> search) throws Exception {
		return empdao.getSearchEmployeesList(search);
	}

	@Override
	public int getTotalEmployees() throws Exception {
		return empdao.getTotalEmployees();
	}
		
	@Override
	public int getSearchEmployees(HashMap<String, Object> search) throws Exception {
		return empdao.getSearchEmployees(search);
	}

	@Override
	public void regEmployees(EmployeesVO evo) throws Exception {
		empdao.insertEmployees(evo);
	}

	@Override
	public void removeEmployees(List<String> checked) throws Exception {
		empdao.deleteEmployees(checked);
	}

	@Override
	public EmployeesVO getEmployees(String emp_id) throws Exception {
		return empdao.readEmployees(emp_id);
	}

	@Override
	public void modifyEmployees(Map map) throws Exception {
		empdao.updateEmployees(map);
	}

	@Override
	public void updateEmployeesImg(String file, String emp_id) throws Exception {
		empdao.updateEmployeesImg(file,emp_id);
		
	}

	
	
	
	

	
	
	
}
