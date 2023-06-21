package com.sm.controller;

import java.util.HashMap;
import java.util.Iterator;
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

import com.sm.domain.WorkOrderVO;
import com.sm.service.OrderStatusService;
import com.sm.service.PerformanceService;
import com.sm.service.WorkOrderService;

@Controller
@RequestMapping(value = "/workorder/*")
public class WorkOrderController {
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderController.class);
	
	//작업지시 service
	@Autowired
	private WorkOrderService wService;
	
	//품목, 라인 service
	@Autowired
	private PerformanceService pService;
	
	//수주 service
	@Autowired
	private OrderStatusService osService;
	
	//작업지시 목록
	//http://localhost:8088/workorder/workOrderList
	@RequestMapping(value = "/workOrderList", method = RequestMethod.GET)
	public void workOrderListGET(Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: workOrderListGET() 호출");
		
		List<WorkOrderVO> workList = wService.getAllWorkOrder();
		
		model.addAttribute("workList", workList);
		
	} //workOrderListGET()
	
	//라인, 품목, 수주 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String lineGET(Model model, @RequestParam("type") String type) throws Exception {
		logger.debug("@@@@@ CONTROLLER: lineGET() 호출");
		logger.debug("@@@@@ CONTROLLER: type = " + type);
		
		if(type.equals("line")) {
			model.addAttribute("lineList", pService.getLineList());
			return "/workorder/lineSearch";
		}
		
		else if(type.equals("prod")) {
			model.addAttribute("prodList", pService.getProdList());
			return "/workorder/prodSearch";
		}
		
		else /* if(type.equals("order"))*/ {
			
			model.addAttribute("orderList", osService.getOsList());
			return "/workorder/orderSearch";
		}
		
//		return "";
	} //lineGET()
	
	//작업지시 추가
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addWorkOrder(/*@RequestBody */WorkOrderVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: addWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: vo = " + vo);
		
		//서비스 - 작업지시 등록
		wService.regWorkOrder(vo);
		
		return "redirect:/workorder/workOrderList";
	} //addWorkOrder()
	
	//작업지시 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteWorkOrder(@RequestParam(value="checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deleteWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);
		
		//서비스 - 작업지시 삭제 
		wService.removeWorkOrder(checked);
		
		return "redirect:/workorder/workOrderList";
	} //deleteWorkOrder()
	
	//작업지시 조회 POST
	@ResponseBody
	@RequestMapping(value = "/detail", method = RequestMethod.POST/*, produces = "application/text; charset=utf8"*/)
	public /*HashMap<String, Object>*/WorkOrderVO getWorkOrder(@RequestBody WorkOrderVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: workCode = " + vo.getWork_code());
		
		//서비스 - 작업지시 정보 가져오기
		WorkOrderVO preVO = wService.getWorkOrder(vo.getWork_code());
		logger.debug("@@@@@ CONTROLLER: preVO = " + preVO);
		
		//정보 가지고 돌아감
//		HashMap<String, Object> voMap = new HashMap<String, Object>();
//		voMap.put("preVO", preVO);
		
		return preVO;
	} //getWorkOrder()
	
	//작업지시 수정 
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyWorkOrder(/*@RequestBody */WorkOrderVO uvo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: modifyWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: uvo = " + uvo);
		
		//서비스 - 작업지시 수정
		wService.modifyWorkOrder(uvo);
		
		return "redirect:/workorder/workOrderList";
	} //modifyWorkOrder()
	
	//작업지시 검색
	@ResponseBody
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public List<WorkOrderVO> searchWorkOrder(@RequestBody HashMap<String, Object> search) throws Exception {
		logger.debug("@@@@@ CONTROLLER: searchWorkOrder() 호출");
		
		for(String key : search.keySet()) {
			if(search.get(key)==null) {
				search.replace(key, "");
			}
		}
		logger.debug("@@@@@ CONTROLLER: 조회할 정보 - " + search);
		
		//서비스 - 작업지시 검색
		List<WorkOrderVO> searchList = wService.searchWorkOrder(search);
		logger.debug("@@@@@ CONTROLLER: 검색결과list = " + searchList);
		
		return searchList;
	} //searchWorkOrder()
	
	
	
	
} //WorkOrderController
