package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<StockVO> getStockList(int startRow, int pageSize) throws Exception {
		
		return sdao.StockList(startRow, pageSize);
	}

	@Override
	public int count3(WarehouseVO wvo) throws Exception {
	
		return sdao.count3(wvo);
	}

	@Override
	public List<StockVO> getStockList(int startRow, int pageSize, WarehouseVO wvo) throws Exception {
		
		return sdao.StockList(startRow, pageSize, wvo);
	}

	
	
}
