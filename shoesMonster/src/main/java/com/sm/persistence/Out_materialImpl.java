package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.Out_materialVO;
import com.sm.domain.ProductVO;

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
		
		HashMap<String, Object> data = new HashMap<String, Object>();
        
        data.put("startRow", startRow);
        data.put("pageSize", pageSize);
		
		return sqlSession.selectList(NAMESPACE+".out_matPage",data);
	}

	
	
	
	@Override
	public int count2(Out_materialVO ovo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		 if (ovo.getClient() != null) {
		        data.put("client_actname", ovo.getClient().getClient_actname());
		    }
		    if (ovo.getOut_num() != null) {
		        data.put("out_num", ovo.getOut_num());
		    }
		    if (ovo.getProduct() != null && ovo.getProduct().getProd_name() != null) {
		        data.put("prod_name", ovo.getProduct().getProd_name());
		    }
		
		return sqlSession.selectOne(NAMESPACE+".searchCount2",data);
	}

	@Override
	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize, Out_materialVO ovo) throws Exception {

		HashMap<String , Object> data = new HashMap<String, Object>();
		
		data.put("startRow", startRow);
        data.put("pageSize", pageSize);
		
		data.put("client_actname",ovo.getClient().getClient_actname());
		data.put("out_num", ovo.getOut_num());
		data.put("prod_name", ovo.getProduct().getProd_name());

	
		return sqlSession.selectList(NAMESPACE+".searchOut",data);
	}

	
	
}
