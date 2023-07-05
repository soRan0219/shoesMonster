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
import com.sm.domain.Raw_orderVO;
import com.sm.domain.StockVO;
import com.sm.domain.WarehouseVO;

@Repository
public class StockImpl implements StockDAO{

	
	@Autowired
    private SqlSession sqlSession;
    
	private static final Logger logger = LoggerFactory.getLogger(StockImpl.class);    
	
    private static final String NAMESPACE="com.sm.mapper.stockMapper";
    
    
    @Override
	public int countP3() throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ11111111111111111");
		
		return sqlSession.selectOne(NAMESPACE+".countP3");
	}
    
	@Override
	public int countR3() throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ11111111111111111");
		
		return sqlSession.selectOne(NAMESPACE+".countR3");
	}

	@Override
	public List<StockVO> getStockP(PageVO vo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ22222222222222222222222");
		
		return sqlSession.selectList(NAMESPACE+".stockPageP", vo);
	}
	
	@Override
	public List<StockVO> getStockR(PageVO vo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ22222222222222222222222");
		
		return sqlSession.selectList(NAMESPACE+".stockPageR", vo);
	}

	@Override
	public int countP3(StockVO svo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ!!!!!!!!!");
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("prod_code", svo.getProd_code());
		data.put("prod_name", svo.getProduct().getProd_name());
		data.put("wh_code", svo.getWh_code());
		
		return sqlSession.selectOne(NAMESPACE+".searchCountP3", data);
	}
	
	@Override
	public int countR3(StockVO svo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ!!!!!!!!!");
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("raw_code", svo.getRaw_code());
		data.put("raw_name", svo.getRaw_mat().getRaw_name());
		data.put("wh_code", svo.getWh_code());
		
		return sqlSession.selectOne(NAMESPACE+".searchCountR3", data);
	}

	@Override
	public List<StockVO> getStockP(PageVO vo, StockVO svo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ22222222222222222");
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("prod_code", svo.getProd_code());
		data.put("prod_name", svo.getProduct().getProd_name());
		data.put("wh_code", svo.getWh_code());
		data.put("startPage", vo.getStartPage());
		data.put("pageSize", vo.getPageSize());
		
		return sqlSession.selectList(NAMESPACE+".searchStockP", data);
	}
	
	@Override
	public List<StockVO> getStockR(PageVO vo, StockVO svo) throws Exception {
		
		logger.debug("@@@@@@@@@@@@@@@@ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ22222222222222222");
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("raw_code", svo.getRaw_code());
		data.put("raw_name", svo.getRaw_mat().getRaw_name());
		data.put("wh_code", svo.getWh_code());
		data.put("startPage", vo.getStartPage());
		data.put("pageSize", vo.getPageSize());
		
		return sqlSession.selectList(NAMESPACE+".searchStockR", data);
	}
	
	@Override
    public void updateCount(String code, int newCount) throws Exception {
        
		logger.debug("////////////////////DAOImpl code : " + code +"///////////////////////////");
		logger.debug("////////////////////DAOImpl nCount : " + newCount +"///////////////////////////");
        
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("code", code);
		data.put("newCount", newCount);
		
		int result = sqlSession.update(NAMESPACE + ".updateCount", data);
		
		if(result == 1) {
			logger.debug("코드 : " + code + ", 재고 " + newCount + "개로 수정완료");
		}
		
    }

	@Override
	public List<StockVO> stockPopup(String code) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("code", code);
		
		return sqlSession.selectList(NAMESPACE + ".stockPopup", data);
	}

  
  @Override
	public Map<String, List<StockVO>> stockGraph1() throws Exception {
		
		logger.debug("##### DAO: stockGraph1() 호출");
		
		Map<String, List<StockVO>> graph1 = new HashMap<>();
		
		List<StockVO> stockGraph1 = sqlSession.selectList(NAMESPACE + ".stockGraph1");
		logger.debug("##### DAO: 라인별 양불현황 ===> " + stockGraph1);

		List<StockVO> stockGraph2 = sqlSession.selectList(NAMESPACE + ".stockGraph2");
		logger.debug("##### DAO: 라인별 양불현황 ===> " + stockGraph2);
		
	
		
		graph1.put("wh_dv", stockGraph1);
		graph1.put("wh_code", stockGraph2);
		
		
		return graph1;
	}

	

	
	
}
