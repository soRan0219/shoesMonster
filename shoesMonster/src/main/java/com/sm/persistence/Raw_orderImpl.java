package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.ClientsVO;
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
    public List<Raw_orderVO> Raw_order(int startRow, int pageSize) throws Exception {

    	HashMap<String, Integer> data = new HashMap<String, Integer>();
        
        data.put("startRow", startRow);
        data.put("pageSize", pageSize);
        
        return sqlSession.selectList(NAMESPACE + ".getRaw_Order", data);
    }



	@Override
	public List<Raw_orderVO> Popup() throws Exception {
		
		return sqlSession.selectList(NAMESPACE + ".roPopup");
	}



	@Override

	public void roInsert(Raw_orderVO vo) throws Exception {
		int result = sqlSession.insert(NAMESPACE + ".roRegist", vo);
		
		if(result != 0) {
			logger.debug("발주 등록완료");
		}
	}
		
	public int count1(Raw_orderVO rvo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("raw_order_num", rvo.getRaw_order_num());
		data.put("raw_name", rvo.getRawMaterial().getRaw_name());
		data.put("client_actname", rvo.getClients().getClient_actname());
		
		
		
		return sqlSession.selectOne(NAMESPACE+".searchCount1",data);

	}



	@Override
	public List<Raw_orderVO> getDetail() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".roDetail");
  }
    
  @Override
	public List<Raw_orderVO> Raw_order(int startRow, int pageSize, Raw_orderVO rvo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("startRow", startRow);
        data.put("pageSize", pageSize);
		data.put("raw_order_num", rvo.getRaw_order_num());
		data.put("raw_name", rvo.getRawMaterial().getRaw_name());
		data.put("client_actname", rvo.getClients().getClient_actname());
		
		return sqlSession.selectList(NAMESPACE+".getRaw_OrderSearch",data);
		
	}

    
    




    
    
}