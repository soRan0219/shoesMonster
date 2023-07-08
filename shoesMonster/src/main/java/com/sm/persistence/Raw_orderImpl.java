package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.ClientsVO;
import com.sm.domain.In_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.Raw_orderVO;
import com.sm.domain.WarehouseVO;

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
    public List<Raw_orderVO> Raw_order(PageVO vo) throws Exception {

        return sqlSession.selectList(NAMESPACE + ".getRaw_Order", vo);
    }


	@Override
	public List<Raw_orderVO> Popup(PageVO vo) throws Exception {
		
		return sqlSession.selectList(NAMESPACE + ".roPopup", vo);
	}


	@Override
    public int countPop() throws Exception {
        
        return sqlSession.selectOne(NAMESPACE+".roPopupCount");
    }



	@Override
	public List<WarehouseVO> whPopup() throws Exception {
		return sqlSession.selectList(NAMESPACE + ".whPopup");
	}



	@Override
	public int count1(Raw_orderVO rvo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("raw_order_num", rvo.getRaw_order_num());
		data.put("raw_name", rvo.getRawMaterial().getRaw_name());
		data.put("in_num", rvo.getIn_mat().getIn_num());
		data.put("client_actname", rvo.getClients().getClient_actname());
		data.put("in_YN", rvo.getIn_YN());
		
		
		return sqlSession.selectOne(NAMESPACE+".searchCount1", data);
	}



	@Override
	public List<Raw_orderVO> Raw_order(PageVO vo, Raw_orderVO rvo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("raw_order_num", rvo.getRaw_order_num());
		data.put("raw_name", rvo.getRawMaterial().getRaw_name());
		data.put("client_actname", rvo.getClients().getClient_actname());
		data.put("in_num", rvo.getIn_mat().getIn_num());
		data.put("in_YN", rvo.getIn_YN());
		data.put("startPage", vo.getStartPage());
		data.put("pageSize", vo.getPageSize());
		
		return sqlSession.selectList(NAMESPACE+".getRaw_OrderSearch", data);
		
	}



	@Override
    public void roInsert(Raw_orderVO vo, String emp_id) throws Exception {
		
		vo.setEmp_id(emp_id);
		
        int result = sqlSession.insert(NAMESPACE + ".roRegist", vo);
        
        if(result != 0) {
            logger.debug("발주 등록완료");
        }
    }
	
	
	@Override
    public int countPop(Raw_orderVO rvo) throws Exception {
        
        HashMap<String, Object> data = new HashMap<String, Object>();

        data.put("client_actname", rvo.getClients().getClient_actname());
        data.put("raw_name", rvo.getRawMaterial().getRaw_name());
        
        return sqlSession.selectOne(NAMESPACE+".roPopupCountSearch", data);
    }



    @Override
    public List<Raw_orderVO> Popup(PageVO vo, Raw_orderVO rvo) throws Exception {
        
        HashMap<String, Object> data = new HashMap<String, Object>();

        data.put("startPage", vo.getStartPage());
        data.put("pageSize", vo.getPageSize());
        data.put("client_actname", rvo.getClients().getClient_actname());
        data.put("raw_name", rvo.getRawMaterial().getRaw_name());
        
        
        return sqlSession.selectList(NAMESPACE+".roPopupSearch", data);
    }


	



	@Override
    public List<Raw_orderVO> getDetail() throws Exception {
        return sqlSession.selectList(NAMESPACE + ".roDetail");
  }



	@Override
	public List<ClientsVO> detailPopup(String rawCode) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();

        data.put("rawCode", rawCode);
		
		return sqlSession.selectList(NAMESPACE + ".detailPopup", data);
		
	}



	@Override
	public void roCancel(String raw_order_num) throws Exception {
		
		int result = sqlSession.update(NAMESPACE + ".roCancel", raw_order_num);
		
		if(result != 0) {
            logger.debug("발주 취소 완료");
        }
	}

    
    




    
    
}