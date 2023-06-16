package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.In_materialVO;
import com.sm.persistence.In_materialDAO;



@Service
public class In_materialServiceImpl implements In_materialService{

	@Autowired
	private In_materialDAO idao;
	
	
	@Override
	public List<In_materialVO> getIn_mat() throws Exception {
		return idao.readBoardIn_mat();
	}

	
	
	
}
