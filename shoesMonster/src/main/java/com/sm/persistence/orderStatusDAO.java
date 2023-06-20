package com.sm.persistence;

import java.util.List;

import com.sm.domain.orderStatusVO;

public interface orderStatusDAO {
	// DB 동작 선언 / 호출
	
	// 수주 현황 목록 불러오기
	public List<orderStatusVO> readOrderStatusList() throws Exception;

}
