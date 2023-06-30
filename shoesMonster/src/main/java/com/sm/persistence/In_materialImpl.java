package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.In_materialVO;
import com.sm.domain.Raw_orderVO;

@Repository
public class In_materialImpl implements In_materialDAO {

	@Autowired
	private SqlSession sqlSession;	
//
	private static final Logger logger = LoggerFactory.getLogger(In_materialImpl.class);
//	
	private static final String NAMESPACE = "com.sm.mapper.stockMapper";

	@Override
	public List<In_materialVO> readBoardIn_mat() throws Exception {
		
		
		
		logger.debug(" readBoardIn_mat() 호출");
		
		return sqlSession.selectList(NAMESPACE + ".In_material");
//		return null;
	}
		
	@Override
	public int count() throws Exception {
		
		
		return sqlSession.selectOne(NAMESPACE+".count");
	}
	



	@Override
	public List<In_materialVO> In_matPage(int displayPost, int postNum) throws Exception {
		
		HashMap<String, Integer> data = new HashMap<String, Integer>();
		
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		
		return sqlSession.selectList(NAMESPACE+".in_matPage",data);
	}

	@Override
	public void inInsert(Raw_orderVO rvo, String raw_order_num) throws Exception {
		
		int result = sqlSession.insert(NAMESPACE + ".inRegist", rvo);
    
		if(result != 0) {
			logger.debug("입고 등록완료");
        }
		
	}

	
	@Override
    public void updateIn(String raw_order_num) throws Exception {

        sqlSession.update(NAMESPACE+".updateIn",raw_order_num);
    }
	
	
//	@Override
//	public int count(In_materialVO ivo) throws Exception {
//		
//		HashMap<String, Object> data = new HashMap<String, Object>();
//		
//		data.put("in_num", ivo.getIn_num());
//		data.put("raw_name" , ivo.getRaw_mat().getRaw_name());
//		data.put("client_actname", ivo.getClients().getClient_actname());
//		
//		return sqlSession.selectOne(NAMESPACE+".countSearch",data);
//	}
	
//	@Override
//	public List<In_materialVO> In_matPage(int displayPost, int postNum , In_materialVO ivo) throws Exception {
//		
//		HashMap<String, Object> data = new HashMap<String, Object>();
//		
//		data.put("displayPost", displayPost);
//		data.put("postNum", postNum);
//		data.put("in_num", ivo.getIn_num());
//		data.put("raw_name" , ivo.getRaw_mat().getRaw_name());
//		data.put("client_actname", ivo.getClients().getClient_actname());
//		
//		
//		return sqlSession.selectList(NAMESPACE+".in_matPageSearch",data);
//	}

	

	


	
}
