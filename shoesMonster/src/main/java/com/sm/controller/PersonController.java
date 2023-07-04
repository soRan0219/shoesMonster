package com.sm.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	// http://localhost:8080/person/empinfo
	// 사원 목록 조회 (GET)
	@RequestMapping(value = "/empinfo", method = RequestMethod.GET)
	public void empInfoGET(Model model, ClientPageVO cpvo, 
			@RequestParam HashMap<String, Object> search,
			@RequestParam(value = "input", required = false) Object input) throws Exception {

		logger.debug(" empinfoGET() 호출@@@@@ ");
		
		//페이지 정보
		if(search.get("pageSize")!=null) {
			int pageSize = Integer.parseInt(search.get("pageSize").toString());
			cpvo.setPageSize(pageSize);
		} else {
			cpvo.setPageSize(2);
		}
		
		//페이징 하단부 정보
		ClientPageMaker pm = new ClientPageMaker();
		pm.setClientPageVO(cpvo);
		pm.setPageBlock(5);
		
		List<EmployeesVO> empList = new ArrayList<>();
		
		// 검색 있을 때
		if((search.get("search_emp_id")!=null && !search.get("search_emp_id").equals("")) || (search.get("search_emp_name")!=null && !search.get("search_emp_name").equals("")) || (search.get("search_emp_department")!=null && !search.get("search_emp_department").equals(""))) {
			
			logger.debug("검색 : service 호출 @@@@@");
			
			search.put("startPage", cpvo.getStartPage());
			search.put("pageSize", cpvo.getPageSize());
			
			// 서비스 - 작업지시 검색
			empList = empService.getSearchEmployeesList(search);
			logger.debug(" empList 검색 결과 : " + empList);
			
			logger.debug(" search 검색 결과 수 : " + empService.getSearchEmployees(search));
			pm.setTotalCount(empService.getTotalEmployees());
			
			model.addAttribute("search", search);
			model.addAttribute("empList", empList);
			model.addAttribute("pm", pm);
			
			// 혜림 추가(등록시 팝업)
			if (input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@");
			}
			
		}// if(검색)
		
		// 검색 없을 때
		else {
			logger.debug(" 전체 작업지시 수 : " + empService.getTotalEmployees());
			pm.setTotalCount(empService.getTotalEmployees());
			
			empList = empService.getEmpList(cpvo);
			
			model.addAttribute("empList", empList);
			model.addAttribute("pm", pm);
		}// else(모두)
	}// empInfoGET()
	
	// 사원 추가
	@RequestMapping(value = "/addEmp", method = RequestMethod.POST)
	public String addEmployees(EmployeesVO vo) throws Exception {
		logger.debug(" addEmployees() 호출@@@@@ ");
		logger.debug(" vo : " + vo);
		
		empService.regEmployees(vo);
		
		return "redirect:/person/empinfo";
	}// addEmployees()
	
	// 사원 삭제
	@RequestMapping(value = "/deleteEmp", method = RequestMethod.POST)
	public String deleteEmployees(@RequestParam(value="checked[]") List<String> checked) throws Exception {
		logger.debug(" deleteEmployees() 호출@@@@@ ");
		logger.debug(" checked : " + checked);
		
		//서비스 - 작업지시 삭제 
		empService.removeEmployees(checked);
		
		return "redirect:/person/empinfo";
	} //deleteEmployees()
	
	//사원 수정 
	@RequestMapping(value = "/modifyEmp", method = RequestMethod.POST)
	public String modifyEmployees(EmployeesVO uvo) throws Exception {
		logger.debug("modifyEmployees() 호출@@@@@");
		logger.debug(" uvo : " + uvo);
		
		//서비스 - 작업지시 수정
		empService.modifyEmployees(uvo);
		
		return "redirect:/person/empinfo";
	} //modifyEmployees()
	
	// 사원 상세 조회 POST
	@ResponseBody
	@RequestMapping(value = "/detailEmp", method = RequestMethod.POST)
	public EmployeesVO getEmployees(@RequestBody EmployeesVO evo) throws Exception {
		logger.debug(" getEmployees() 호출@@@@@");
		logger.debug(" emp_id " + evo.getEmp_id());
		
		//서비스 - 작업지시 정보 가져오기
		EmployeesVO preVO = empService.getEmployees(evo.getEmp_id());
		logger.debug(" preVO = " + preVO);
		
		return preVO;
	} //getEmployees()
	
	
	// http://localhost:8088/person/management
	// 사원 권한 정보 조회 (GET)
	@RequestMapping(value = "/management", method = RequestMethod.GET)
	public void empManageGET(Model model, ClientPageVO cpvo,
			@RequestParam HashMap<String, Object> search) throws Exception {
		logger.debug(" empManageGET() 호출@@@@@ ");
		
		//페이지 정보
		cpvo.setPageSize(20);
		
		//페이징 하단부 정보
		ClientPageMaker pm = new ClientPageMaker();
		pm.setClientPageVO(cpvo);
		pm.setPageBlock(5);
		
		List<ManagementVO> manageList = empService.getManagement();
		List<EmployeesVO> empList = new ArrayList<>();
		
		// 검색 있을 때
		if((search.get("search_emp_id")!=null && !search.get("search_emp_id").equals("")) || (search.get("search_emp_name")!=null && !search.get("search_emp_name").equals("")) || (search.get("search_emp_department")!=null && !search.get("search_emp_department").equals(""))) {
			
			logger.debug("검색 : service 호출 @@@@@");
			
			search.put("startPage", cpvo.getStartPage());
			search.put("pageSize", cpvo.getPageSize());
			
			// 서비스 - 작업지시 검색
			empList = empService.getSearchEmployeesList(search);
			logger.debug(" empList 검색 결과 : " + empList);
			
			logger.debug(" search 검색 결과 수 : " + empService.getSearchEmployees(search));
			pm.setTotalCount(empService.getTotalEmployees());
			
			model.addAttribute("search", search);
			model.addAttribute("management", manageList);
			model.addAttribute("empList", empList);
			model.addAttribute("pm", pm);
			
		}// if(검색)
		
		// 검색 없을 때
		else {
			logger.debug(" 전체 작업지시 수 : " + empService.getTotalEmployees());
			pm.setTotalCount(empService.getTotalEmployees());
			
			empList = empService.getEmpList(cpvo);
			
			model.addAttribute("manageList", manageList);
			model.addAttribute("empList", empList);
			model.addAttribute("pm", pm);
		}// else(모두)
		
	} // empManageGET()
	
	
	// http://localhost:8088/empform
	@RequestMapping(value = "/empform", method = RequestMethod.GET)
	public void fileForm() throws Exception{
		logger.debug(" fileForm 호출 @@@ ");
	}
	
	
	
	// ===================================== 거래처 - /Person/Clients (GET) ========================================
	
	// http://localhost:8088/person/Clients
	@RequestMapping(value="/Clients", method = RequestMethod.GET)
	public void ClientsGET(ClientPageVO cpvo, 
							@RequestParam HashMap<String, Object> search,
							@RequestParam(value="input", required = false) Object input,
							Model model) throws Exception {
		logger.debug("@@@ cnotroller : ClientsGET(Model model) 호출 @@@");
		
		logger.debug("search ################"+search);
		
		// 페이지 정보
		cpvo.setPageSize(2);

		// 페이징 하단부 정보
		ClientPageMaker pm = new ClientPageMaker();
		pm.setClientPageVO(cpvo);
		pm.setPageBlock(2);
		
		List<ClientsVO> searchClientsList = new ArrayList<>();
		
		// 검색 있을 때
		logger.debug("search : " + search);
		
		if((search.get("search_client_code") != null && !search.get("search_client_code").equals("")) 
			|| (search.get("search_client_name") != null && !search.get("search_client_name").equals(""))
			|| (search.get("search_client_type") != null && !search.get("search_client_type").equals(""))) {
			
			search.put("startPage", cpvo.getStartPage());
			search.put("pageSize", cpvo.getPageSize());
			
			// 검색
			searchClientsList = clService.getSearchClientsList(search);
			logger.debug("@@@ cnotroller 검색결과 list 호출 = " + searchClientsList);
			
			logger.debug("@@@ cnotroller 검색결과 수 = " + clService.getSearchClient(search));
			pm.setTotalCount(clService.getSearchClient(search));
			
			model.addAttribute("search", search);
			model.addAttribute("searchClientsList", searchClientsList);
			model.addAttribute("pm", pm);
			

			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@ input 정보 전달 @@@");
			}
		} // if(검색)

		// 검색 없을 때
		else {
			// 전체 글 개수
			logger.debug("@@@ cnotroller : 전체 글 개수 = " + clService.getTotalClient());
			
			pm.setTotalCount(clService.getTotalClient());
			
			searchClientsList = clService.getListAll(cpvo);
			
			model.addAttribute("searchClientsList", searchClientsList);
			model.addAttribute("pm", pm);
			

			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@ input 정보 전달 @@@");
			}
		}
	} // ClientsGET()
	
	// 거래처 추가
	@RequestMapping(value="/addClient", method = RequestMethod.POST)
	public String addClient(ClientsVO cvo) throws Exception {
		logger.debug("@@@ cnotroller : addClient(ClientsVO cvo) 호출 @@@");
		logger.debug("@@@ cnotroller cvo : " + cvo);
		
		clService.regClient(cvo);
		
		return "redirect:/person/Clients";
	} 
	
	// 거래처 삭제
	@RequestMapping(value="/delete", method = RequestMethod.POST)
	public String deleteClient(@RequestParam(value="checked[]") List<String> checked) throws Exception {
		logger.debug("@@@ cnotroller : deleteClient() 호출 @@@");
		
		clService.deleteClient(checked);
		
		return "redirect:/person/Clients";
	}
	
	// 거래처 수정
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public String updateClient(ClientsVO cvo) throws Exception {
		logger.debug("@@@ cnotroller : updateClient() 호출 @@@");
		logger.debug("@@@ cnotroller cvo : " + cvo);
		
		clService.updateClient(cvo);
		
		return "redirect:/person/Clients";
	}
	
	// ================================================= 거래처 ============================================================
	
	
	// ================================================ 수주 현황 ==========================================================
	
	// http://localhost:8088/person/orderStatus
	@RequestMapping(value="/orderStatus", method = RequestMethod.GET)
	public void orderStatusGET(Model model, ClientPageVO cpvo, 
								@RequestParam HashMap<String, Object> search, 
								@RequestParam(value="input", required = false) Object input) throws Exception {
		logger.debug("@@@ cnotroller : orderStatusGET() 호출 @@@");
		
		// 페이지 정보
		if(search.get("pageSize")!=null) {
			int pageSize = Integer.parseInt(search.get("pageSize").toString());
			cpvo.setPageSize(pageSize);
		} else {
			cpvo.setPageSize(10);
		}
//		cpvo.setPageSize(2);
		
		// 페이지 하단부 정보
		ClientPageMaker pm = new ClientPageMaker();
		pm.setClientPageVO(cpvo);
		pm.setPageBlock(5);
		
		List<OrderStatusVO> searchOrderStatusList = new ArrayList<>();
		
		// 검색 있을 때
		if((search.get("client_actname") != null && !search.get("client_actname").equals("")) 
				|| (search.get("prod_code") != null && !search.get("prod_code").equals(""))
				|| (search.get("emp_id") != null && !search.get("emp_id").equals(""))
				|| (search.get("order_finish") != null && !search.get("order_finish").equals(""))
				|| (search.get("order_date_fromDate") != null && !search.get("order_date_fromDate").equals(""))
				|| (search.get("order_date_toDate") != null && !search.get("order_date_toDate").equals(""))
				|| (search.get("order_deliveryDate_fromDate") != null && !search.get("order_deliveryDate_fromDate").equals(""))
				|| (search.get("order_deliveryDate_toDate") != null && !search.get("order_deliveryDate_toDate").equals(""))) {
			
			search.put("startPage", cpvo.getStartPage());
			search.put("pageSize", cpvo.getPageSize());
			
			// 검색
			searchOrderStatusList = osService.getSearchOrderStatus(search);
			
			pm.setTotalCount(osService.getSearchCountOrderStatus(search));
			logger.debug("@@@ cnotroller 검색결과 list 호출 = " + searchOrderStatusList);
			
			model.addAttribute("search", search);
			model.addAttribute("searchOrderStatusList", searchOrderStatusList);
			logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@orderStatusList : "+searchOrderStatusList);
			model.addAttribute("pm", pm);
			
			
			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@ cnotroller : input 정보 전달");
			} // if(검색)
		}
		// 검색 없을 때
		else {
			logger.debug("@@@ cnotroller 전체 수주현황 수 : "+ osService );
			
			pm.setTotalCount(osService.getTotalOrderStatus());
			
			searchOrderStatusList = osService.getOsList(cpvo);
			
			model.addAttribute("searchOrderStatusList", searchOrderStatusList);
			model.addAttribute("pm", pm);
			
			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@ controller : input 정보 전달");
			}
		} // else
	} // orderStatusGET()
	
	// 팝업 검색
//	@RequestMapping(value = "/osSearch", method = RequestMethod.GET)
//	public String popUpGET(Model model, @RequestParam("type") String type, 
//			@RequestParam("input") String input) throws Exception {
//		logger.debug("@@@ cnotroller : popUpGET() 호출");
//		logger.debug("@@@ cnotroller : type = " + type);
//		
//		
//		if(type.equals("line")) {
//			return "redirect:/performance/line?input="+input;
//		}
//		
//		else if(type.equals("prod")) {
//			return "redirect:/performance/product?input="+input;
//
//		}
//		
//		else if(type.equals("client")) {
//			return "redirect:/person/Clients?input="+input;
//		}
//		
//		else /* if(type.equals("order"))*/ {
//			return "redirect:/person/orderStatus?input="+input;
//		}
//		
//		
//	} //popUpGET()
	
	// 수주 등록
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	public String addOrder(OrderStatusVO osvo) throws Exception{
		logger.debug("@#@# C : addOrder(osvo) 호출 ");
		logger.debug("@#@# C : osvo = "+osvo);
		
		osService.registOrder(osvo);
		
		return "redirect:/person/orderStatus";
	}
	
	// 수주 수정
	
	// 수주 삭제
	
	
	
	// ===================================================== 수주 현황 ==========================================================
	
	// ===================================================== 수주 관리 ==========================================================
	
	// http://localhost:8088/person/orderManage
	// 수주 관리 목록 조회
	@RequestMapping(value = "/orderManage", method = RequestMethod.GET)
	public void orderManageGET(Model model) throws Exception {
		logger.debug(" orderManageGET() 호출@@@@@ ");
		
		List<ClientsVO> orderManageList = osService.getOrderManageList();
		logger.debug("orderManageList : " + orderManageList);

		model.addAttribute("orderManageList", orderManageList);
	}
	
	
	
	
	
	
	
	
	
	// ===================================================== 수주 관리 ==========================================================
}
