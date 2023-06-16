package com.sm.persistence;

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

} //WorkOrderDAOImpl
