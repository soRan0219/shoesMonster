package com.sm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.ClientPageVO;
import com.sm.domain.ClientsVO;
import com.sm.persistence.ClientsDAO;

@Service
public class ClientsServiceImpl implements ClientsService {
	
	@Autowired
	private ClientsDAO cldao;
	
	// 거래처 목록 불러오기
	@Override
	public List<ClientsVO> getListAll(ClientPageVO cpvo) throws Exception {
		return cldao.readClientsListAll(cpvo);
	}

	// 거래처 검색
	@Override
	public List<ClientsVO> getSearchClientsList(HashMap<String, Object> search) throws Exception {
		return cldao.getSearchClientsList(search);
	}
	
	// 거래처 전체 개수
	@Override
	public int getTotalClient() throws Exception {
		return cldao.getTotalClient();
	}
	
	// 거래처 검색 개수 
	@Override
	public int getSearchClient(HashMap<String, Object> search) throws Exception {
		return cldao.getSearchClient(search);
	}

	
	// 거래처 추가
	@Override
	public void regClient(ClientsVO cvo) throws Exception {
		cldao.insertClient(cvo);
	}
	
	

}
