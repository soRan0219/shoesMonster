package com.sm.persistence;

import java.util.HashMap;
import java.util.List;

import com.sm.domain.ClientPageVO;
import com.sm.domain.ClientsVO;

public interface ClientsDAO {
	// DB 동작 선언 / 호출
	
	// 거래처 목록 불러오기
	public List<ClientsVO> readClientsListAll(ClientPageVO cpvo) throws Exception;
	
	// 거래처 검색
	public List<ClientsVO> getSearchClientsList(HashMap<String, Object> search) throws Exception;
	
	// 거래처 전체 개수
	public int getTotalClient() throws Exception;
	
	// 거래처 검색 개수
	public int getSearchClient(HashMap<String, Object> search) throws Exception;
	
	// 거래처 추가
	public void insertClient(ClientsVO cvo) throws Exception;
	
	// 거래처 삭제
	public void deleteClient(List<String> checked) throws Exception;
	
	// 거래처 수정
	public void updateClient(ClientsVO cvo) throws Exception;
}
