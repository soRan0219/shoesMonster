package com.sm.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.PageVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.StockVO;
import com.sm.domain.WarehouseVO;

@Repository
public class StockImpl implements StockDAO{

	
	@Autowired
    private SqlSession sqlSession;
    
	private static final Logger logger = LoggerFactory.getLogger(StockImpl.class);    
	
    private static final String NAMESPACE="com.sm.mapper.stockMapper";
    
    
	@Override
	public int count3() throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ11111111111111111");
		
		return sqlSession.selectOne(NAMESPACE+".count3");
	}

	@Override
	public List<StockVO> getStock(PageVO vo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ22222222222222222222222");
		
		return sqlSession.selectList(NAMESPACE+".stockPage", vo);
	}

	
	@Override
	public int count3(StockVO svo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ!!!!!!!!!");
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("raw_code", svo.getRaw_code());
		data.put("prod_code", svo.getProd_code());
		data.put("raw_name", svo.getRaw_mat().getRaw_name());
		data.put("prod_name", svo.getProduct().getProd_name());
		data.put("wh_code", svo.getWh_code());
		
		return sqlSession.selectOne(NAMESPACE+".searchCount3", data);
	}

	@Override
	public List<StockVO> getStock(PageVO vo, StockVO svo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ22222222222222222");
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("raw_code", svo.getRaw_code());
		data.put("prod_code", svo.getProd_code());
		data.put("raw_name", svo.getRaw_mat().getRaw_name());
		data.put("prod_name", svo.getProduct().getProd_name());
		data.put("wh_code", svo.getWh_code());
		data.put("startPage", vo.getStartPage());
		data.put("pageSize", vo.getPageSize());
		
		return sqlSession.selectList(NAMESPACE+".searchStock", data);
	}
	
	@Override
    public void updateCount(int stock_count ,String raw_code) throws Exception {
        
        Map<String, Object> data = new HashMap<>();
        data.put("stock_count", stock_count);
        data.put("raw_code", raw_code);
        
        sqlSession.update(NAMESPACE + ".updateCount", data);
    }

	@Override
	public Map<String, List<StockVO>> stockGraph1() throws Exception {
		
		logger.debug("##### DAO: stockGraph1() 호출");
		
		Map<String, List<StockVO>> graph1 = new HashMap<>();
		
		List<StockVO> stockGraph1 = sqlSession.selectList(NAMESPACE + ".stockGraph");
		logger.debug("##### DAO: 라인별 양불현황 ===> " + stockGraph1);
		
	
		
		graph1.put("perLine", stockGraph1);
		
		
		return graph1;
	}



	
	
}
