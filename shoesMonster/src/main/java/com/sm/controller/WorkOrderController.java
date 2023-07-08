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

import com.sm.domain.LineWhPageMaker;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.WorkOrderVO;
import com.sm.service.WorkOrderService;

@Controller
@RequestMapping(value = "/workorder/*")
public class WorkOrderController {
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderController.class);
	
	//작업지시 service
	@Autowired
	private WorkOrderService wService;
	
	//작업지시 목록
	//http://localhost:8088/workorder/workOrderList
	@RequestMapping(value = "/workOrderList", method = RequestMethod.GET)
	public void workOrderListGET(LineWhPageVO pvo, 
								@RequestParam HashMap<String, Object> search, 
								@RequestParam(value = "input", required = false) Object input, 
								Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: workOrderListGET() 호출");
		logger.debug("@@@@@ CONTROLLER: search정보!!!!!!!!!!!!!!!" + search);
		
		//페이지 정보
		pvo.setPageSize(8);
		
		//페이징 하단부 정보
		LineWhPageMaker pm = new LineWhPageMaker();
		pm.setLwPageVO(pvo);
		pm.setPageBlock(5);
		
		List<WorkOrderVO> workList = new ArrayList<>();
		
		//검색 있을 때
		if((search.get("search_line")!=null && !search.get("search_line").equals("")) || (search.get("search_fromDate")!=null && !search.get("search_fromDate").equals("")) || (search.get("search_toDate")!=null && !search.get("search_toDate").equals("")) 
				|| (search.get("search_place")!=null && !search.get("search_place").equals("")) || (search.get("search_prod")!=null && !search.get("search_prod").equals(""))) {
			
			logger.debug("@@@@@ CONTROLLER: 검색 service 호출");
			
			search.put("startPage", pvo.getStartPage());
			search.put("pageSize", pvo.getPageSize());
			
			//서비스 - 작업지시 검색
			workList = wService.searchWorkOrder(search);
			logger.debug("@@@@@ CONTROLLER: 검색결과list = " + workList);
			
			logger.debug("@@@@@ CONTROLLER: 검색 결과 수 = " + wService.getSearchWorkOrder(search));
			pm.setTotalCount(wService.getSearchWorkOrder(search));
			
			model.addAttribute("search", search);
			model.addAttribute("workList", workList);
			model.addAttribute("pm", pm);
			
			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@ CONTROLLER: input 정보 전달");
			}
			
		} //if(검색)
		//검색 없을 때
		else {
			
			logger.debug("@@@@@ CONTROLLER: 전체 작업지시 수 = " + wService.getTotalWorkOrder());
			
			pm.setTotalCount(wService.getTotalWorkOrder());
			
			workList = wService.getAllWorkOrder(pvo);
			
			model.addAttribute("workList", workList);
			model.addAttribute("pm", pm);
			
			if(input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@ CONTROLLER: input 정보 전달");
			}
		} //else(모든)
		
		
	} //workOrderListGET()
	
	//라인, 품목, 수주 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String popUpGET(Model model, @RequestParam("type") String type, 
			@RequestParam("input") String input) throws Exception {
		logger.debug("@@@@@ CONTROLLER: popUpGET() 호출");
		logger.debug("@@@@@ CONTROLLER: type = " + type);
		
		
		if(type.equals("line")) {
			return "redirect:/performance/line?input="+input;
		}
		
		else if(type.equals("prod")) {
			return "redirect:/performance/product?input="+input;

		}
		
		else if(type.equals("client")) {
			return "redirect:/person/Clients?input="+input;
		}
		
		else if(type.equals("wh")) {
			return "redirect:/performance/warehouse?input="+input;
		}
		
		else if(type.equals("emp")) {
			return "redirect:/person/empinfo?input="+input;
		}
		
		else /* if(type.equals("order"))*/ {
			return "redirect:/person/orderStatus?input="+input;
		}
		
		
	} //popUpGET()
		
	//작업지시 추가
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addWorkOrder(WorkOrderVO vo, Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: addWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: vo = " + vo);
		
		//서비스 - 작업지시 등록
		model.addAttribute("woInsert", wService.regWorkOrder(vo));
		
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
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public WorkOrderVO getWorkOrder(@RequestBody WorkOrderVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getWorkOrder() 호출");
		logger.debug("@@@@@ CONTROLLER: workCode = " + vo.getWork_code());
		
		//서비스 - 작업지시 정보 가져오기
		WorkOrderVO preVO = wService.getWorkOrder(vo.getWork_code());
		logger.debug("@@@@@ CONTROLLER: preVO = " + preVO);
		
		return preVO;
	} //getWorkOrder()
	
	//작업지시 수정 
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyWorkOrder(WorkOrderVO uvo, Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: modifyWorkOrder() 호출");
		
		//서비스 - 작업지시 수정
		model.addAttribute("woModify", wService.modifyWorkOrder(uvo));
		
		return "redirect:/workorder/workOrderList";
	} //modifyWorkOrder()
	
	//작업지시 현재 작업 공정 변경
//	@RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
	@RequestMapping(value = "/updateStatus", method = RequestMethod.GET)
	public String updateStatus(WorkOrderVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: updateStatus() 호출");
		logger.debug("@@@@@ CONTROLLER: vo  = = = = = = > > > " + vo);
		
		wService.modifyStatus(vo);
		
		return "redirect:/workorder/workOrderList";
	} //updateStatus()
	
	
} //WorkOrderController
