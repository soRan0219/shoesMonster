package com.sm.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sm.domain.OrderStatusVO;
import com.sm.domain.Out_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;

@Repository
public class Out_materialImpl implements Out_materialDAO {

	@Autowired
    private SqlSession sqlSession;
    
	private static final Logger logger = LoggerFactory.getLogger(Out_materialImpl.class);
	
    private static final String NAMESPACE="com.sm.mapper.stockMapper";
	
	@Override
	public int count4() throws Exception {
		
		return sqlSession.selectOne(NAMESPACE+".count4");
	}

	@Override
	public List<Out_materialVO> Out_matList(PageVO vo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		
		data.put("startPage", vo.getStartPage());
		data.put("pageSize", vo.getPageSize());
		
		
		return sqlSession.selectList(NAMESPACE+".out_matPage",data);
	}

	
	
//	@Override
//	public int count4(Out_materialVO rvo) throws Exception {
//		
//		HashMap<String , Object> data = new HashMap<String, Object>();
//        
//        data.put("client_actname",rvo.getClients().getClient_actname());
//        data.put("out_num", rvo.getOut_num());
//        data.put("prod_name", rvo.getProd().getProd_name());
//        
//         
//        return sqlSession.selectOne(NAMESPACE+".searchCount2",data);
//	}

//	@Override
//	public List<Out_materialVO> searchOut_mat(int startRow, int pageSize, Out_materialVO rvo) throws Exception {
//
//		HashMap<String , Object> data = new HashMap<String, Object>();
//		
//		data.put("startRow", startRow);
//        data.put("pageSize", pageSize);
//		
//		data.put("client_actname",rvo.getClients().getClient_actname());
//		data.put("out_num", rvo.getOut_num());
//		data.put("prod_name", rvo.getProd().getProd_name());
//
//	
//		return sqlSession.selectList(NAMESPACE+".searchOut",data);
//	}

	@Override
	public void omButton(String order_code, String emp_id) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("order_code", order_code);
		data.put("emp_id", emp_id);
		
		int result = sqlSession.insert(NAMESPACE + ".omButton", data);
        logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ result : " + result);
        
        if(result != 0) {
            logger.debug("출고 완료");
        }
		
	}

	@Override
	public int count4(Out_materialVO rvo) throws Exception {
		
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("out_num", rvo.getOut_num());
		data.put("prod_name", rvo.getProd().getProd_name());
		data.put("client_actname", rvo.getClients().getClient_actname());
		data.put("out_YN", rvo.getOrders().getOut_YN());
		
		return sqlSession.selectOne(NAMESPACE+".searchCount4", data);
	}

	@Override
	public List<Out_materialVO> getSearch_Out(PageVO vo, Out_materialVO rvo) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("out_num", rvo.getOut_num());
		data.put("prod_name", rvo.getProd().getProd_name());
		data.put("client_actname", rvo.getClients().getClient_actname());
		data.put("out_YN", rvo.getOrders().getOut_YN());
		data.put("startPage", vo.getStartPage());
		data.put("pageSize", vo.getPageSize());
		
		return sqlSession.selectList(NAMESPACE+".searchOut", data);
	}

	@Override
    public void deleteStock(int order_count, String prod_code) throws Exception {

		logger.debug("출고 재고 빠짐 @@@@@@@@@@@@@@@@@");
		
        Map<String, Object> data = new HashMap<>();
        data.put("prod_code", prod_code);
        data.put("order_count", order_count);
        sqlSession.update(NAMESPACE + ".deleteStock", data);

    }

	@Override
	public void updateYN(String order_code) throws Exception {
		
		sqlSession.update(NAMESPACE + ".update_out_YN", order_code);
		
	}

	
	
	
	
}
