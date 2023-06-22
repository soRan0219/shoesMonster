package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.In_materialVO;

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
	public int count(In_materialVO ivo) throws Exception {
		
		
		return sqlSession.selectOne(NAMESPACE+".countSearch");
	}
	
	@Override
	public List<In_materialVO> In_matPage(int displayPost, int postNum , In_materialVO ivo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		
		
		return sqlSession.selectList(NAMESPACE+".in_matPageSearch",data);
	}



//	@Override
//	public List<In_materialVO> In_matSearch(
//			int displayPost, int postNum, String keyword) throws Exception {
//		
//		HashMap<String, Object> data =new HashMap<String, Object>();
//		
//		data.put("displayPost", displayPost);
//		data.put("postNum", postNum);
//		data.put("keyword", keyword);
//		
//		
//		return sqlSession.selectList(NAMESPACE+".In_material",data);
//	}

	
}
