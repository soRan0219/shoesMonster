package com.sm.persistence;

import java.util.List;

import com.sm.domain.Raw_orderVO;

public interface Raw_orderDAO {

	
	// 발주 목록 조회
	public List<Raw_orderVO> Raw_order(int startRow,int pageSize) throws Exception;
	
	// 글 총 갯수
    public int count1() throws Exception;
    
    
	
}

