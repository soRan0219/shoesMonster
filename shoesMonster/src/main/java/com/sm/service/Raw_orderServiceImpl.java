package com.sm.service;


import java.util.List;

import com.sm.domain.ClientsVO;
import com.sm.domain.In_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.Raw_orderVO;
import com.sm.domain.WarehouseVO;
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
	public List<Raw_orderVO> getPopup(PageVO vo) throws Exception {
		return rodao.Popup(vo);
	}
	
	@Override
    public int countPoP() throws Exception {
        return rodao.countPop();
    }


	@Override
	public void roInsert(Raw_orderVO vo, String emp_id) throws Exception {
		rodao.roInsert(vo, emp_id);
    }
	
	
	@Override
    public int countPop(Raw_orderVO rvo) throws Exception {
        return rodao.countPop(rvo);
    }


    @Override
    public List<Raw_orderVO> Popup(PageVO vo, Raw_orderVO rvo) throws Exception {
        return rodao.Popup(vo, rvo);
    }
  


	@Override
	public List<WarehouseVO> whPopup() throws Exception {
		return rodao.whPopup();
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

	@Override
	public List<ClientsVO> detailPopup(String rawCode) throws Exception {
		
		return rodao.detailPopup(rawCode);
	}


	@Override
	public void roCancel(String raw_order_num) throws Exception {
		
		rodao.roCancel(raw_order_num);
	}
 
	
	
	
    
    

}