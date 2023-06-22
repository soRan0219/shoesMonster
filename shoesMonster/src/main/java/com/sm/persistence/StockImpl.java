package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.StockVO;

@Repository
public class StockImpl implements StockDAO{

	
	@Autowired
    private SqlSession sqlSession;
    
	private static final Logger logger = LoggerFactory.getLogger(StockImpl.class);    
	
    private static final String NAMESPACE="com.sm.mapper.stockMapper";
    
    
	@Override
	public int count3() throws Exception {
		return sqlSession.selectOne(NAMESPACE+".count3");
	}

	@Override
	public List<StockVO> StockList(int startRow, int pageSize) throws Exception {
		
		HashMap<String, Integer> data = new HashMap<String, Integer>();
        
        data.put("startRow", startRow);
        data.put("pageSize", pageSize);
        
		return sqlSession.selectList(NAMESPACE+".stockPage",data);
	}

	
	
}
