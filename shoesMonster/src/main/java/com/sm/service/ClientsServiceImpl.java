package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.domain.ClientsVO;
import com.sm.persistence.ClientsDAO;

@Service
public class ClientsServiceImpl implements ClientsService {
	
	@Autowired
	private ClientsDAO cldao;
	
	@Override
	public List<ClientsVO> getListAll() throws Exception {
		
		return cldao.readClientsListAll();
	}
	
	

}
