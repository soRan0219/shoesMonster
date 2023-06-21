package com.sm.controller;


import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.ClientsVO;
import com.sm.domain.EmployeesVO;

import com.sm.domain.OrderStatusVO;
import com.sm.domain.ManagementVO;

import com.sm.service.ClientsService;
import com.sm.service.EmployeesService;
import com.sm.service.OrderStatusService;


@Controller
@RequestMapping(value="/person/*")
public class PersonController {
	
	// 서비스 객체 주입
	@Autowired
	private ClientsService clService;
	@Autowired
	private EmployeesService empService;
	@Autowired
	private OrderStatusService osService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(PersonController.class);
	
	
	// http://localhost:8088/person/empinfo
	// 사원 목록 조회 (GET)
	@RequestMapping(value = "/empinfo", method = RequestMethod.GET)
	public void empInfoGET(Model model) throws Exception {
		logger.debug(" empinfoGET() 호출@@@@@ ");
		
		List<EmployeesVO> empList = empService.getEmpList();
		logger.debug("empList : " + empList);
		
		model.addAttribute("empList", empList);
	}
	
	// http://localhost:8088/person/management
	// 사원 권한 정보 조회 (GET)
	@RequestMapping(value = "/management", method = RequestMethod.GET)
	public void empManageGET(Model model) throws Exception {
		logger.debug(" empManageGET() 호출@@@@@ ");
		
		List<ManagementVO> management = empService.getManagement();
		List<EmployeesVO> empList = empService.getEmpList();
		logger.debug("management : " + management);
		logger.debug("empList : " + empList);
		
		model.addAttribute("management", management);
		model.addAttribute("empList", empList);
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
		List<OrderStatusVO> orderStatusList = osService.getOsList();
		logger.debug("orderStatusList : "+ orderStatusList );
		
		model.addAttribute("orderStatusList", orderStatusList);
	}
	// 수주 현황 목록 불러오기
	
	
	// http://localhost:8088/person/orderManage
	// 수주 관리 목록 조회
	@RequestMapping(value = "/orderManage", method = RequestMethod.GET)
	public void orderManageGET(Model model) throws Exception {
		logger.debug(" orderManageGET() 호출@@@@@ ");
		
		List<OrderStatusVO> orderStatusList = osService.getOsList();
		List<EmployeesVO> empList = empService.getEmpList();
		List<ClientsVO> clientsList = clService.getListAll();
		logger.debug("orderStatusList : " + orderStatusList);
		logger.debug("empList : " + empList);
		logger.debug("clientsList : " + clientsList);
		
		model.addAttribute("orderStatusList", orderStatusList);
		model.addAttribute("empList", empList);
		model.addAttribute("clientsList", clientsList);
	}
	
	
	
	
	
	
	
	
	
}
