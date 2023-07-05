package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.OrderStatusVO;
import com.sm.domain.Out_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;
import com.sm.persistence.Out_materialDAO;

@Service
public class Out_materialServiceImpl implements Out_materialService{

	@Autowired
	private Out_materialDAO o_dao;
	
	
	// 출고 목록 조회
	@Override
	public int count4() throws Exception {
		
		return o_dao.count4();
	}
	
	@Override
	public List<Out_materialVO> getOut_matList(PageVO vo) throws Exception {
		
		return o_dao.Out_matList(vo);
	}

	//출고 검색 목록 조회
	@Override
	public int count4(Out_materialVO rvo) throws Exception {
	
			return o_dao.count4(rvo);
	}

//	@Override
//	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize,OrderStatusVO ovo) throws Exception {
//		return o_dao.searchOut_mat(startRow, pageSize,ovo);
//	}
//	
	@Override
	public void omButton(String order_code) throws Exception {
		o_dao.omButton(order_code);
	}

//	@Override
//	public int count4(Out_materialVO rvo) throws Exception {
//		
//		return o_dao.count4(rvo);
//	}

	@Override
	public List<Out_materialVO> getSearch_Out(PageVO vo, Out_materialVO rvo) throws Exception {
		
		return o_dao.getSearch_Out(vo, rvo);
		
	}

	@Override
	public void deleteStock(int order_count, String prod_code) throws Exception {
		o_dao.deleteStock(order_count, prod_code);
		
	}

	

	
	
}
