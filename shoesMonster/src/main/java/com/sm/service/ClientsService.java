package com.sm.service;

import java.util.List;

import com.sm.domain.ClientsVO;

public interface ClientsService {
	// 수행하는 동작 선언
	
	// 거래처 목록 조회
	public List<ClientsVO> getListAll() throws Exception;
}
