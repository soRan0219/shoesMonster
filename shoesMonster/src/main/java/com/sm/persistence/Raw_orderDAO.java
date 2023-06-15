package com.sm.persistence;

import java.util.List;

import com.sm.domain.Raw_orderVO;

public interface Raw_orderDAO {
	
	// 발주 목록 조회
	public List<Raw_orderVO> readRaw_Order() throws Exception;

}
