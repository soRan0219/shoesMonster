package com.sm.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/stock/*")
public class stockController {
	
	private static final Logger logger = LoggerFactory.getLogger(stockController.class);
	
	// 발주 페이지로 이동 - /stock/raw_order
	// http://localhost:8080/stock/raw_order
	// http://localhost:8088/stock/raw_order
	@RequestMapping(value = "/raw_order", method = RequestMethod.GET)
	public void raw_orderGET() throws Exception {
		logger.debug("raw_orderGET() 호출");
	}
	// 발주 페이지로 이동 - /stock/raw_order
	
	// 발주 목록
	public void raw_order_listGET() {
		logger.debug("raw_order_listGET() 호출");
		
		
		
	}
	// 발주 목록
	
	
	
}
