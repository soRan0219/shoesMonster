package com.sm.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.ClientsVO;
import com.sm.service.ClientsService;

@Controller
@RequestMapping(value="/Person/*")
public class PersonController {
	
	// 서비스 객체 주입
	@Autowired
	private ClientsService service;
	
	private static final Logger logger = LoggerFactory.getLogger(PersonController.class);
	
	// 거래처 목록 조회 - /Person/Clients (GET)
	// http://localhost:8088/Person/Clients
	@RequestMapping(value="/Clients", method = RequestMethod.GET)
	public void ClientsGET() throws Exception {
		logger.debug("ClientsGET() 호출");
		
		// service - DB에 저장된 글 정보 가져오기
		List<ClientsVO> clientsList = service.getListAll();
		logger.debug("clientsList : " + clientsList);
	}
	
	
	// 거래처 목록 조회
}
