package com.sm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.PageVO;
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
    public void updateCount(int stock_count ,String raw_code) throws Exception {

        sdao.updateCount(stock_count ,raw_code);
    }

	@Override
	public Map<String, List<StockVO>> stockGraph1() throws Exception {
		
		return sdao.stockGraph1();
	}

	
	
}
