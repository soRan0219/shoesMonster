package com.sm.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;
import com.sm.service.PerformanceService;

@Controller
@RequestMapping(value = "/performance/*")
public class PerfomanceController {
	
	// ���� ��ü ����
	@Autowired
	private PerformanceService service;

	private static final Logger logger = LoggerFactory.getLogger(PerfomanceController.class);
	
	// http://localhost:8088/performance/product
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public void productGET() {
		logger.debug("productGET() ȣ��");
		
	}
	
	@RequestMapping(value = "/product", method = RequestMethod.POST)
	public String productPOST(ProductVO vo) throws Exception {
		
		logger.debug("productPOST() ȣ��");
		logger.debug("vo : " + vo);
		
		service.insertProd(vo);
		
		return "";
	}
	
	//======== 라인 - /line ================================ 
	// http://localhost:8088/performance/line
	@RequestMapping(value = "/line", method = RequestMethod.GET)
	public void lineGET() throws Exception{
		logger.debug("@@lineGET() 호출@@");
	}
	
	@RequestMapping(value = "/line", method = RequestMethod.POST)
	public void linePOST(LineVO vo) throws Exception{
		logger.debug("@@linePOST() 호출@@");
		
		logger.debug("@@vo : "+vo);
		
		service.insertLine(vo);
	}
	
	// http://localhost:8088/performance/linelist
	@RequestMapping(value = "/linelist", method = RequestMethod.GET)
	public void lineListGET(Model model) throws Exception{
		logger.debug("@@lineListGET() 호출@@");
		
		List<LineVO> boardList = service.getLineList();
		logger.debug("boardList : "+boardList);
		
		model.addAttribute("boardList", boardList);
	}
	
	// 라인 - 검색
	@RequestMapping(value = "/linelist", method = RequestMethod.GET)
	public void lineSearchGET(Model model) throws Exception{
		logger.debug("lineSearchGET() 호출");
		
		List<LineVO> boardList = service.getLineList();
		logger.debug("boardList : "+boardList);
		
		model.addAttribute("boardList", boardList);
		
	}
	
	//======== 라인 - /line ================================
}





