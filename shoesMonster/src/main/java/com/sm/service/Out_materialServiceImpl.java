package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.Out_materialVO;
import com.sm.persistence.Out_materialDAO;

@Service
public class Out_materialServiceImpl implements Out_materialService{

	@Autowired
	private Out_materialDAO o_dao;
	
	
	
	@Override
	public int count2() throws Exception {
		
		return o_dao.count2();
	}
	

	@Override
	public int count2(Out_materialVO ovo) throws Exception {
	
			return o_dao.count2(ovo);
	}


	@Override
	public List<Out_materialVO> getOut_matList(int startRow, int pageSize) throws Exception {
		
		return o_dao.Out_matList(startRow, pageSize);
	}

	@Override
	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize, Out_materialVO ovo) throws Exception {
		return o_dao.searchOut_mat(startRow, pageSize,ovo);
	}

	
	
}
