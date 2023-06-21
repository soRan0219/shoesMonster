package com.sm.controller;


import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sm.domain.LineVO;
import com.sm.domain.ProductList;
import com.sm.domain.ProductVO;
import com.sm.domain.WarehouseVO;
import com.sm.domain.Wh_prodVO;
import com.sm.service.PerformanceService;

@Controller
@RequestMapping(value = "/performance/*")
public class PerfomanceController {
	
	// 서비스 객체 주입
	@Autowired
	private PerformanceService service;

	private static final Logger logger = LoggerFactory.getLogger(PerfomanceController.class);
	
	//======================================================================================
	
	// http://localhost:8088/performance/product
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public void productGET(Model model, ProductVO vo) throws Exception{
		logger.debug("productGET() 호출");
		List<ProductVO> products = new ArrayList<ProductVO>();
		model.addAttribute("products", products);
		logger.debug("vo : " + vo);
		
		if (vo.getProd_code() != null || vo.getProd_name() !=null || 
			vo.getProd_category() !=null || vo.getProd_unit() !=null ) {
			List<ProductVO> list = service.getProdList(vo);
			model.addAttribute("prodList", list);
			logger.debug("검색 리스트 가져감");
			
		}else {
			List<ProductVO> list = service.getProdList();
			model.addAttribute("prodList", list);
			logger.debug(" 모든 리스트 가져감");
		}
		
	}
	
	@RequestMapping(value = "product", method = RequestMethod.POST)
	public String productPOST(ProductList products) throws Exception {
		
		logger.debug("productPOST() 호출");
		logger.debug("prducts : " + products.getProducts());
		service.insertProd(products.getProducts());
//		service.insertProd(vo);
		
		return "redirect:/performance/product";
	}
	
	//======== 라인 - /line ================================ 
	// http://localhost:8088/performance/line
	@RequestMapping(value = "/line", method = RequestMethod.GET)
	public void lineGET(Model model, LineVO lvo) throws Exception{
		logger.debug("@@lineGET() 호출@@");
		
		logger.debug("lvo : "+lvo);
		
		// 검색
		if(lvo.getLine_code() != null || lvo.getLine_name() != null ||
		   lvo.getLine_place() != null || lvo.getLine_use() != 0) {
			
			List<LineVO> searchlist = service.getSearchLine(lvo);
			model.addAttribute("boardList", searchlist );
			
			logger.debug("searchlist : "+searchlist);
			
			logger.debug("@@ 검색 리스트 호출 @@");
		
		}else {
			List<LineVO> boardList = service.getLineList();
			model.addAttribute("boardList", boardList);
			
			logger.debug("@@ 모든 리스트 호출 @@");
		}
	}
	
//	@RequestMapping(value = "/line", method = RequestMethod.POST)
//	public void linePOST()throws Exception{
//		logger.debug("linePOST() 호출");
//		
//		List<LineVO> boardList = service.getLineList();
//		logger.debug("boardList : "+boardList);
//		
//		model.addAttribute("boardList", boardList);
//		
//	}
	
	
	//======== 라인 - /line ================================
	
	//======== 창고 - /warehouse ===========================
	// http://localhost:8088/performance/warehouse
	@RequestMapping(value = "/warehouse", method = RequestMethod.GET)
	public void warehouseGET(Model model, 
					@RequestParam(required = false) String prod_code,
					@RequestParam(required = false) String raw_code
					, Wh_prodVO wh_prod) throws Exception{
		
		logger.debug("warehouseGET() 호출");
		
//		String itemName = null;
//		
//		if(prod_code == null && raw_code != null) {
//			// raw_code 처리
//			
//			
//		}else if(raw_code == null && prod_code != null) {
//			
//		}
		
		List<WarehouseVO> whList = service.getWhList();
		model.addAttribute("whList", whList);
		
		logger.debug("whList : "+whList);
		
		logger.debug("@@ 모든 리스트 호출 @@");
	}
	//======== 창고 - /warehouse ===========================
	
}//PerfomanceController





