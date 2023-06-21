package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.Out_materialVO;

@Repository
public class Out_materialImpl implements Out_materialDAO {

	@Autowired
    private SqlSession sqlSession;
    
	private static final Logger logger = LoggerFactory.getLogger(Out_materialImpl.class);
	
    private static final String NAMESPACE="com.sm.mapper.stockMapper";
	
	@Override
	public int count2() throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+".count2");
	}

	@Override
	public List<Out_materialVO> Out_matList(int startRow, int pageSize) throws Exception {
		
		HashMap<String, Integer> data = new HashMap<String, Integer>();
        
        data.put("startRow", startRow);
        data.put("pageSize", pageSize);
		
		return sqlSession.selectList(NAMESPACE+".out_matPage",data);
	}

	
	
}
