package com.sm.persistence;

import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.WorkOrderVO;

@Repository
public class WorkOrderDAOImpl implements WorkOrderDAO {
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderDAOImpl.class);
	
	private static final String NAMESPACE = "com.sm.mapper.workorderMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<WorkOrderVO> readAllWorkOrder() throws Exception {
		logger.debug("##### DAO: readAllWorkOrder() 호출");
		
		return sqlSession.selectList(NAMESPACE + ".allWorkOrder");
	} //readAllWorkOrder()

	@Override
	public void insertWorkOrder(WorkOrderVO vo) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");
		int result = sqlSession.insert(NAMESPACE + ".insertWorkOrder", vo);
		logger.debug("##### DAO: insert 결과 ====> " + result);
	} //updateWorkOrder()

	@Override
	public void deleteWorkOrder(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteWorkOrder() 호출");
		
		Iterator<String> it = checked.iterator();
		int result = 0;
		
		while(it.hasNext()) {
			String work_code = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteWorkOrder", work_code);
		}
		
		logger.debug("##### DAO: delete 결과 ===> " + result);
	} //deleteWorkOrder()

	@Override
	public WorkOrderVO readWorkOrder(String work_code) throws Exception {
		logger.debug("##### DAO: readWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".readWorkOrder", work_code);
	} //readWorkOrder()

} //WorkOrderDAOImpl
