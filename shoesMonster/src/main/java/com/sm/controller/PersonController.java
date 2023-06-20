package com.sm.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.ClientsVO;
import com.sm.domain.EmployeesVO;
import com.sm.domain.orderStatusVO;
import com.sm.service.ClientsService;
import com.sm.service.EmployeesService;
import com.sm.service.orderStatusService;


@Controller
@RequestMapping(value="/person/*")
public class PersonController {
	
	// 서비스 객체 주입
	@Autowired
	private ClientsService clService;
	@Autowired
	private EmployeesService empService;
	@Autowired
	private orderStatusService osService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(PersonController.class);
	
	
	// http://localhost:8088/person/empinfo
	// 사원 조회
	@RequestMapping(value = "/empinfo", method = RequestMethod.GET)
	public void empinfoGET(Model model, HttpSession session) {
		logger.debug(" empinfoGET() 호출@@@@@ ");
		
		String id = (String)(session.getAttribute("id"));
		EmployeesVO resultVO = empService.getEmployees(id);
		
		logger.debug(" @@@@@ resultVO : " + resultVO);
		
		model.addAttribute(empService.getEmployees(id));
		
		logger.debug(" /person/empinfo.jsp 페이지로 이동 ");
	}
	
	
	// http://localhost:8088/person/Clients
	// 거래처 목록 불러오기 - /Person/Clients (GET)
	@RequestMapping(value="/Clients", method = RequestMethod.GET)
	public void ClientsGET(Model model) throws Exception {
		logger.debug("ClientsGET(Model model) 호출");
		
		// service - DB에 저장된 글 정보 가져오기
		List<ClientsVO> clientsList = clService.getListAll();
		logger.debug("clientsList : " + clientsList);
		
		model.addAttribute("clientsList", clientsList);
		
		
	}
	// 거래처 목록 불러오기
	
	// http://localhost:8088/person/orderStatus
	// 수주 현황 목록 불러오기
	@RequestMapping(value="/orderStatus", method = RequestMethod.GET)
	public void orderStatusGET(Model model) throws Exception {
		logger.debug("orderStatusGET(Model model) 호출");
		
		// service - DB에 저장된 글 정보 가져오기
		List<orderStatusVO> orderStatusList = osService.getOsList();
		logger.debug("orderStatusList : "+ orderStatusList );
		
		model.addAttribute("orderStatusList", orderStatusList);
	}
	
	// 수주 현황 목록 불러오기
	
	
}
