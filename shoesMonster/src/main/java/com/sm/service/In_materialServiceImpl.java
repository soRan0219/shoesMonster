package com.sm.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.In_materialVO;
import com.sm.domain.Raw_orderVO;
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
	

	@Override
	public int count() throws Exception {
		
		return idao.count();
	}
	@Override
	public List<In_materialVO> getIn_matPage(int displayPost, int postNum) throws Exception {
		
		return idao.In_matPage(displayPost, postNum);
	}


	@Override
	public void inInsert(String raw_order_num) throws Exception {
		idao.inInsert(raw_order_num);
	}

	

	@Override
    public void updateIn(String raw_order_num) throws Exception {

        idao.updateIn(raw_order_num);
    }

	
	// 입고 버튼용ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
	@Override
	public boolean selectCheck(String rawCode) throws Exception {
		return idao.selectCheck(rawCode);
	}


	@Override
	public void updateStock(String rawCode, int raw_order_count) throws Exception {
		idao.updateStock(rawCode, raw_order_count);
	}


	@Override
	public void insertStock(String rawCode, int raw_order_count, String wh_code) throws Exception {
		idao.insertStock(rawCode, raw_order_count, wh_code);
	}
	
	
	
//	@Override
//	public int count(In_materialVO ivo) throws Exception {
//		
//		return idao.count(ivo);
//	}
//
//
//
//	@Override
//	public List<In_materialVO> getIn_matPage(int displayPost, int postNum , 
//			In_materialVO ivo) throws Exception {
//		
//		return idao.In_matPage(displayPost, postNum, ivo);
//	}


	




	

	

	
	
	
}
