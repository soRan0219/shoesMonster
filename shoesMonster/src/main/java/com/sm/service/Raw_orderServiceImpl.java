package com.sm.service;


import java.util.List;

import com.sm.domain.ClientsVO;
import com.sm.domain.PageVO;
import com.sm.domain.Raw_orderVO;
import com.sm.persistence.Raw_orderDAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Raw_orderServiceImpl implements Raw_orderService{
    
    @Autowired
    private Raw_orderDAO rodao;
    
    
    @Override
    public int count1() throws Exception {
        return rodao.count1();
    }


    @Override
    public List<Raw_orderVO> getRaw_order(PageVO vo) throws Exception {
        return rodao.Raw_order(vo);
    }


	@Override
	public List<Raw_orderVO> getPopup() throws Exception {
		return rodao.Popup();
	}


	@Override
	public void roInsert(Raw_orderVO vo) throws Exception {
		rodao.roInsert(vo);
  }
  
  @Override
	public int count1(Raw_orderVO rvo) throws Exception {
		
		return rodao.count1(rvo);
	}


	@Override
	public List<Raw_orderVO> getDetail() throws Exception {
		return rodao.getDetail();
  }
  
  @Override
	public List<Raw_orderVO> getRaw_order(PageVO vo, Raw_orderVO rvo) throws Exception {
		
		return rodao.Raw_order(vo, rvo);
	}
 
	
	
	
    
    

}