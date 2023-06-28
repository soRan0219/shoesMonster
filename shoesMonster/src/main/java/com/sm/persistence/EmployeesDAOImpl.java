package com.sm.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public List<EmployeesVO> readEmpList(LineWhPageVO pvo) throws Exception {
		logger.debug(" readEmpList() 호출@@@@@ ");
		return sqlSession.selectList(NAMESPACE2 + ".empList", pvo);
	} //readEmpList()

	@Override
	public List<ManagementVO> readManagement() throws Exception {
		logger.debug(" readManagement() 호출@@@@@ ");
		return sqlSession.selectList(NAMESPACE2 + ".management");
	} //readManagement()

	@Override
	public List<EmployeesVO> selectEmployees(HashMap<String, Object> search) throws Exception {
		logger.debug(" selectEmployees(HashMap) 호출@@@@@ ");
		List<EmployeesVO> searchList = sqlSession.selectList(NAMESPACE2 + ".searchEmployees", search);
		logger.debug(" search 결과 : " + searchList);
		return searchList;
	} //selectEmployees()

	@Override
	public int getTotalEmployees() throws Exception {
		logger.debug(" getTotalEmployees() 호출@@@@@ ");
		return sqlSession.selectOne(NAMESPACE2 + ".employeesAllCnt");
	} //getTotalEmployees()

	@Override
	public int getSearchEmployees(HashMap<String, Object> search) throws Exception {
		logger.debug(" getSearchEmployees() 호출@@@@@ ");
		return sqlSession.selectOne(NAMESPACE2 + ".employeesSearchCnt", search);
	} //getSearchEmployees()

	
	
	

	
	
	
	
	
	
}
