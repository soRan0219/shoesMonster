package com.sm.service;

import java.util.List;
import java.util.Map;

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
    public int countP3() throws Exception {

        return sdao.countP3();
    }
	
    @Override
    public int countR3() throws Exception {

        return sdao.countR3();
    }

    @Override
    public List<StockVO> getStockP(PageVO vo) throws Exception {

        return sdao.getStockP(vo);
    }
    
    @Override
    public List<StockVO> getStockR(PageVO vo) throws Exception {

        return sdao.getStockR(vo);
    }

    @Override
    public int countP3(StockVO svo) throws Exception {
        return sdao.countP3(svo);
    }
    
    @Override
    public int countR3(StockVO svo) throws Exception {
        return sdao.countR3(svo);
    }

    @Override
    public List<StockVO> getStockP(PageVO vo, StockVO svo) throws Exception {
        return sdao.getStockP(vo, svo);
    }
    
    @Override
    public List<StockVO> getStockR(PageVO vo, StockVO svo) throws Exception {
        return sdao.getStockR(vo, svo);
    }
	
	
	@Override
    public void updateCount(String code, int newCount) throws Exception {

        sdao.updateCount(code, newCount);
    }

	@Override
	public List<StockVO> stockPopup(String code) throws Exception {
		return sdao.stockPopup(code);
	}

  @Override
	public Map<String, List<StockVO>> stockGraph1() throws Exception {
		
		return sdao.stockGraph1();
	}

	
}
