package com.sm.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.WorkOrderVO;
import com.sm.service.WorkOrderService;

@Controller
@RequestMapping(value = "/workorder/*")
public class WorkOrderController {
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderController.class);
	
	@Autowired
	private WorkOrderService wService;
	
	//작업지시 목록
	//http://localhost:8088/workorder/workOrderList
	@RequestMapping(value = "/workOrderList", method = RequestMethod.GET)
	public void workOrderListGET(Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: workOrderListGET() 호출");
		
		List<WorkOrderVO> workList = wService.getAllWorkOrder();
		
		model.addAttribute("workList", workList);
		
	} //workOrderListGET()
	
	
} //WorkOrderController
