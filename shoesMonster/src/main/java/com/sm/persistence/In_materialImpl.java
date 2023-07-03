package com.sm.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public void inInsert(String raw_order_num) throws Exception {
		
		logger.debug("////////////// raw_order_num1 : " + raw_order_num + "//////////////");
		
		int result = sqlSession.insert(NAMESPACE + ".inRegist", raw_order_num);
		
		logger.debug("////////////// raw_order_num2 : " + raw_order_num + "//////////////");
    
		if(result != 0) {
			logger.debug("입고 등록완료");
        }
		
	}
	

	
	@Override
    public void updateIn(String raw_order_num) throws Exception {

        sqlSession.update(NAMESPACE+".updateIn", raw_order_num);
    }

	@Override
	public boolean selectCheck(String rawCode) throws Exception {
		
		boolean result = sqlSession.selectOne(NAMESPACE+".selectCheck", rawCode);
		
		return result;
	}

	@Override
	public void updateStock(String rawCode, int raw_order_count) throws Exception {
		
		Map<String, Object> data = new HashMap<>();
		data.put("rawCode", rawCode);
		data.put("raw_order_count", raw_order_count);
	    sqlSession.update(NAMESPACE + ".updateStock", data);
		
	}

	@Override
	public void insertStock(String rawCode, int raw_order_count, String wh_code) throws Exception {
		
		Map<String, Object> data = new HashMap<>();
		data.put("rawCode", rawCode);
		data.put("raw_order_count", raw_order_count);
		data.put("wh_code", wh_code);
	    sqlSession.insert(NAMESPACE + ".insertStock", data);
		
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
