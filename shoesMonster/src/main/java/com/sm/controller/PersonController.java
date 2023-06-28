package com.sm.controller;


import java.util.ArrayList;
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

import com.sm.domain.ClientPageMaker;
import com.sm.domain.ClientPageVO;
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
	public void ClientsGET(ClientPageVO cpvo, 
							@RequestParam HashMap<String, Object> search,
//							@RequestParam(value="input", required = false) Object input,
							Model model) throws Exception {
		logger.debug("@@@ ClientsGET(Model model) 호출 @@@");
		
		
		// 페이지 정보
		cpvo.setPageSize(2);

		// 페이징 하단부 정보
		ClientPageMaker pm = new ClientPageMaker();
		pm.setClientPageVO(cpvo);
		pm.setPageBlock(2);
		
		List<ClientsVO> searchClientsList = new ArrayList<>();
		
		// 검색 있을 때
		logger.debug("search : " + search);
		
		if((search.get("client_code") != null && !search.get("client_code").equals("")) 
			|| (search.get("client_name") != null && !search.get("client_name").equals(""))
			|| (search.get("client_type") != null && !search.get("client_type").equals(""))) {
			
			search.put("startPage", cpvo.getStartPage());
			search.put("PageSize", cpvo.getPageSize());
			
			// 검색
			searchClientsList = clService.getSearchClientsList(search);
			logger.debug("@@@ 검색결과 list 호출 @@@ = " + searchClientsList);
			
			logger.debug("@@@ 검색결과 수 = " + clService.getSearchClient(search));
			pm.setTotalCount(clService.getSearchClient(search));
			
			model.addAttribute("search", search);
			model.addAttribute("searchClientsList", searchClientsList);
			model.addAttribute("pm", pm);
			
//			if(input != null && !input.equals("")) {
//				model.addAttribute("input", input);
//				logger.debug("@@@ input 정보 전달 @@@");
//			}
		} // if(검색)
		
		// 검색 없을 때
		else {
			// 전체 글 개수
			logger.debug("@@@ 전체 글 개수 = " + clService.getTotalClient());
			
			pm.setTotalCount(clService.getTotalClient());
			
			searchClientsList = clService.getListAll(cpvo);
			
			model.addAttribute("searchClientsList", searchClientsList);
			model.addAttribute("pm", pm);
			
//			if(input != null && !input.equals("")) {
//				model.addAttribute("input", input);
//				logger.debug("@@@ input 정보 전달 @@@");
//			}
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
