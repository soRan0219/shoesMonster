package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.Raw_orderVO;

@Repository
public class Raw_orderImpl implements Raw_orderDAO{
    
    @Autowired
    private SqlSession sqlSession;
    
    private static final Logger logger = LoggerFactory.getLogger(Raw_orderImpl.class);
    
    private static final String NAMESPACE="com.sm.mapper.stockMapper";
    
    
    @Override
    public int count1() throws Exception {
        return sqlSession.selectOne(NAMESPACE+".count1");
    }


    @Override
    public List<Raw_orderVO> Raw_orderPage(int displayPost, int postNum) throws Exception {

    public List<Raw_orderVO> Raw_order(int startRow, int pageSize) throws Exception {

    	HashMap<String, Integer> data = new HashMap<String, Integer>();
        
        data.put("startRow", startRow);
        data.put("pageSize", pageSize);
        
        return sqlSession.selectList(NAMESPACE+".getRaw_Order",data);
    }





    
    
}