package com.sm.service;

import java.util.List;

import com.sm.domain.ClientsVO;

public interface ClientsService {
	// 수행하는 동작 선언
	
	// 거래처 목록 불러오기
	public List<ClientsVO> getListAll() throws Exception;
	
	// 거래처 검색
	public List<ClientsVO> getSearchClientsList(ClientsVO cvo) throws Exception;
}
