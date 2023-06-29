package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.Out_materialVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;
import com.sm.persistence.Out_materialDAO;

@Service
public class Out_materialServiceImpl implements Out_materialService{

	@Autowired
	private Out_materialDAO o_dao;
	
	
	// 출고 목록 조회
	@Override
	public int count2() throws Exception {
		
		return o_dao.count2();
	}
	
	@Override
	public List<Out_materialVO> getOut_matList(int startRow, int pageSize) throws Exception {
		
		return o_dao.Out_matList(startRow, pageSize);
	}

	//출고 검색 목록 조회
	@Override
	public int count2(ProductVO ovo) throws Exception {
	
			return o_dao.count2(ovo);
	}

	@Override
	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize, ProductVO ovo) throws Exception {
		return o_dao.searchOut_mat(startRow, pageSize,ovo);
	}

	@Override
	public void omButton(ProductVO vo) throws Exception {
		o_dao.omButton(vo);
	}

	
	
}
