package com.sm.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.In_materialVO;
import com.sm.persistence.In_materialDAO;



@Service
public class In_materialServiceImpl implements In_materialService{
	

	private static final Logger logger = LoggerFactory.getLogger(In_materialServiceImpl.class);
	
	
	@Autowired
	private In_materialDAO idao;

	@Override
	public List<In_materialVO> getIn_mat() throws Exception {
		logger.debug("정창원 ServiceImpl 호출");
		
		return idao.readBoardIn_mat();
	}
	
	
	

	
	
	
}
