package com.sm.persistence;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.ClientPageVO;
import com.sm.domain.EmployeesVO;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.ManagementVO;

@Repository
public class EmployeesDAOImpl implements EmployeesDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.sm.mapper.MainMapper";
	
	private static final String NAMESPACE2 = "com.sm.mapper.PersonMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeesDAOImpl.class);
	
	@Override
	public EmployeesVO loginEmp(EmployeesVO empvo) {
		logger.debug(" loginEmp() 호출@@@@@ ");
		return sqlSession.selectOne(NAMESPACE + ".smLogin", empvo);
	} //loginEmp()

	@Override
	public EmployeesVO loginEmp(String id, String pw) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userid", id);
		params.put("userpw", pw);
		return sqlSession.selectOne(NAMESPACE + ".smlogin", params);
	} //loginEmp()

	@Override
	public List<EmployeesVO> readEmpList(ClientPageVO cpvo) throws Exception {
		logger.debug(" readEmpList() 호출@@@@@ ");
		return sqlSession.selectList(NAMESPACE2 + ".empList", cpvo);
	} //readEmpList()

	@Override
	public List<ManagementVO> readManagement() throws Exception {
		logger.debug(" readManagement() 호출@@@@@ ");
		return sqlSession.selectList(NAMESPACE2 + ".management");
	} //readManagement()

	@Override
	public List<EmployeesVO> getSearchEmployeesList(HashMap<String, Object> search) throws Exception {
		logger.debug(" getSearchEmployees() 호출@@@@@ ");
		return sqlSession.selectList(NAMESPACE2 + ".searchEmployeesList", search);
	} //getSearchEmployees()

	@Override
	public int getTotalEmployees() throws Exception {
		logger.debug(" getTotalEmployees() 호출@@@@@ ");
		return sqlSession.selectOne(NAMESPACE2 + ".employeesAllCnt");
	} //getTotalEmployees()
	
	@Override
	public int getSearchEmployees(HashMap<String, Object> search) throws Exception {
		logger.debug(" getSearchEmployees() 호출@@@@@ ");
		return sqlSession.selectOne(NAMESPACE2 + ".searchEmployeesCnt", search);
	}

	@Override
	public void insertEmployees(EmployeesVO evo) throws Exception {
		logger.debug(" insertEmployees() 호출@@@@@ ");
		int result = sqlSession.insert(NAMESPACE2 + ".insertEmployees", evo);
		logger.debug(" result : " + result);
	} // insertEmployees()

	@Override
	public void deleteEmployees(List<String> checked) throws Exception {
		logger.debug(" deleteEmployees() 호출@@@@@ ");
		
		Iterator<String> it = checked.iterator();
		int result = 0;
		
		while(it.hasNext()) {
			String emp_id = it.next();
			result += sqlSession.delete(NAMESPACE2 + ".deleteEmployees", emp_id);
		}
		logger.debug(" result : " + result);
	} // deleteEmployees()

	@Override
	public EmployeesVO readEmployees(String emp_id) throws Exception {
		logger.debug(" readEmployees() 호출@@@@@ ");
		return sqlSession.selectOne(NAMESPACE2 + ".readEmployees", emp_id);
	} // readEmployees()

	@Override
	public void updateEmployees(EmployeesVO uvo) throws Exception {
		logger.debug(" updateEmployees() 호출@@@@@ ");
		int result = sqlSession.update(NAMESPACE2 + ".updateEmployees", uvo);
		logger.debug(" result " + result);
	} // updateEmployees

	@Override
	public void updateEmployeesImg(String img, String emp_id) throws Exception {
		logger.debug("updateEmployeesImg() 호출");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("img", img);
		params.put("emp_id", emp_id);
		
		sqlSession.update(NAMESPACE2+".updateEmployeesImg",params);
		
	}

	
	
	

	
	
	
	
	
	
}
