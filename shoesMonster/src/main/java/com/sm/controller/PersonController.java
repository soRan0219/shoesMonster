package com.sm.controller;


import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sm.domain.ClientsVO;
import com.sm.domain.EmployeesVO;
import com.sm.domain.ManagementVO;
import com.sm.domain.OrderStatusVO;
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
	
	
	// ========== 거래처 - /Person/Clients (GET) =========
	// http://localhost:8088/person/Clients
	@RequestMapping(value="/Clients", method = RequestMethod.GET)
	public void ClientsGET(Model model, ClientsVO cvo) throws Exception {
		logger.debug("ClientsGET(Model model) 호출");
		
		// service - DB에 저장된 글 정보 가져오기
		List<ClientsVO> clientsList = clService.getListAll();
		logger.debug("clientsList : " + clientsList);
		
		model.addAttribute("clientsList", clientsList);
		
		// 검색
		logger.debug("cvo : " + cvo);
		
		if(cvo.getClient_code() != null || cvo.getClient_name() != null 
													|| cvo.getClient_type() != null ) {
			List<ClientsVO> searchClientsList = clService.getSearchClientsList(cvo);
			model.addAttribute("clientsList", searchClientsList);
			
			logger.debug("searchClientsList : " + searchClientsList);
			
			logger.debug("@@@ 거래처 검색 리스트 호출 @@@");
		}
		
		
	}
	// ========== 거래처 ===================================
	
	
	// ========= 수주 현황 =================================
	// http://localhost:8088/person/orderStatus
	@RequestMapping(value="/orderStatus", method = RequestMethod.GET)
	public void orderStatusGET(Model model, @RequestParam HashMap<String, Object> search) throws Exception {
		logger.debug("orderStatusGET(Model model) 호출");
		
		// service - DB에 저장된 글 정보 가져오기
		List<OrderStatusVO> orderStatusList = osService.getOsList();
		logger.debug("orderStatusList : "+ orderStatusList );
		
		model.addAttribute("orderStatusList", orderStatusList);
		
		logger.debug("@@@ search : " + search);
		
		logger.debug("@@@ client_code : " + search.get("client_code"));
		
		// 검색
		if(search.get("client_code") != null  || search.get("prod_code") != null 
				|| search.get("emp_id") != null || search.get("order_finish") != null 
				|| search.get("order_date_fromDate") != null || search.get("order_date_toDate") != null
				|| search.get("order_deliveryDate_fromDate") != null || search.get("order_deliveryDate_toDate") != null ) {
			List<OrderStatusVO> searchOrderStatusList = osService.getSearchOrderStatus(search);
			model.addAttribute("orderStatusList", searchOrderStatusList);
			
			logger.debug("searchOrderStatusList" + searchOrderStatusList);
			
			logger.debug("@@@ 수주현황 검색 리스트 호출 @@@");
		}
	}
	
	// 검색2
//	@ResponseBody
//	@RequestMapping(value = "/orderStatus", method = RequestMethod.POST)
//	public List<OrderStatusVO> searchOrderStatusPOST(@RequestBody HashMap<String, Object> search) throws Exception {
//		logger.debug("@@@ searchOrderStatusPOST(@RequestBody HashMap<String, Object> search) 호출 @@@");
//		
//		for(String key : search.keySet()) {
//			if(search.get(key)==null) {
//				search.replace(key, "");
//			}
//		}
//		logger.debug("@@@ CONTROLLER: 조회할 정보 - " + search);
//		
//		//서비스 - 작업지시 검색
//		List<OrderStatusVO> searchList = osService.getSearchOrderStatus2(search);
//		logger.debug("@@@ CONTROLLER: 검색결과list = " + searchList);
//		
//		return searchList;
//	}
	
	// ========= 수주 현황 =================================
	
	
	// http://localhost:8088/person/orderManage
	// 수주 관리 목록 조회
	@RequestMapping(value = "/orderManage", method = RequestMethod.GET)
	public void orderManageGET(Model model) throws Exception {
		logger.debug(" orderManageGET() 호출@@@@@ ");
		
		List<ClientsVO> orderManageList = osService.getOrderManageList();
		logger.debug("orderManageList : " + orderManageList);

		model.addAttribute("orderManageList", orderManageList);
	}
	
	
	
	
	
	
	
	
	
}
