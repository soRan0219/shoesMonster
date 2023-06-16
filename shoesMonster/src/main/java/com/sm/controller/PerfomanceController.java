package com.sm.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sm.domain.ProductList;
import com.sm.domain.ProductVO;
import com.sm.service.PerformanceService;

@Controller
@RequestMapping(value = "/performance/*")
public class PerfomanceController {
	
	// 서비스 객체 주입
	@Autowired
	private PerformanceService service;

	private static final Logger logger = LoggerFactory.getLogger(PerfomanceController.class);
	
	// http://localhost:8088/performance/product
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public void productGET(Model model) throws Exception{
		logger.debug("productGET() 호출");
		
		List<ProductVO> list = service.getProdList();
		List<ProductVO> products = new ArrayList<ProductVO>();
		model.addAttribute("prodList", list);
		model.addAttribute("products", products);
		
	}
	
	@RequestMapping(value = "product", method = RequestMethod.POST)
	public String productPOST(ProductList products) throws Exception {
		
		logger.debug("productPOST() 호출");
		logger.debug("prducts : " + products.getProducts());
		service.insertProd(products.getProducts());
//		service.insertProd(vo);
		
		return "";
	}
	
	
}
