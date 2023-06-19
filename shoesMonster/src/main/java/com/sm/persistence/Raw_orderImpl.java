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
    public List<Raw_orderVO> readRaw_Order() throws Exception {
        logger.debug("발주 목록 조회 mapper 호출");
        
        return sqlSession.selectList(NAMESPACE + ".getRaw_Order");
    }


	
	
}