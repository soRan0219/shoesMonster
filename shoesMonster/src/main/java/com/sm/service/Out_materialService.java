package com.sm.service;

import java.util.List;

import com.sm.domain.Out_materialVO;

public interface Out_materialService {

	
			// 출고 목록 개수
			public int count2() throws Exception;
		
			// 출고 목록 조회
			public List<Out_materialVO> getOut_matList(int startRow, int pageSize) throws Exception;
}
