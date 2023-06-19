package com.sm.persistence;

import java.util.List;

import com.sm.domain.ClientsVO;

public interface ClientsDAO {
	// DB 동작 선언 / 호출
	
	// 거래처 목록 불러오기
	public List<ClientsVO> readClientsListAll() throws Exception;
}
