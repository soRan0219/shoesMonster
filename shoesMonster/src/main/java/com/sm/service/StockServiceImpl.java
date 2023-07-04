package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.PageVO;
import com.sm.domain.Raw_orderVO;
import com.sm.domain.StockVO;
import com.sm.domain.WarehouseVO;
import com.sm.persistence.StockDAO;

@Service
public class StockServiceImpl implements StockService{

	@Autowired
	private StockDAO sdao;
	
	
	@Override
	public int count3() throws Exception {
		
		return sdao.count3();
	}

	@Override
	public List<StockVO> getStock(PageVO vo) throws Exception {
		
		return sdao.getStock(vo);
	}


	@Override
	public int count3(StockVO svo) throws Exception {
		return sdao.count3(svo);
	}

	@Override
	public List<StockVO> getStock(PageVO vo, StockVO svo) throws Exception {
		return sdao.getStock(vo, svo);
	}
	
	@Override
    public void updateCount(String code, int newCount) throws Exception {

        sdao.updateCount(code, newCount);
    }

	@Override
	public List<StockVO> stockPopup(String code) throws Exception {
		return sdao.stockPopup(code);
	}

	
	
	
}
