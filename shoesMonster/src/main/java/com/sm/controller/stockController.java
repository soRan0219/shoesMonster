package com.sm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.In_materialVO;
import com.sm.domain.Raw_orderVO;
import com.sm.service.In_materialService;
import com.sm.service.Raw_orderService;

@Controller
@RequestMapping(value = "/stock/*")
public class stockController {
	
	@Autowired
	private In_materialService service;
	
	@Autowired
	private Raw_orderService ro_service;
	
	private static final Logger logger = LoggerFactory.getLogger(stockController.class);
	
	// 발주 목록 조회
    // http://localhost:8080/stock/raw_order
	// http://localhost:8088/stock/raw_order
    @RequestMapping(value = "/raw_order", method = RequestMethod.GET)
    public void ro_ListGET(Model model) throws Exception {
        logger.debug("ro_ListGET() 호출");
        
        // Service - DB에 저장된 발주 목록 가져오기
        List<Raw_orderVO> ro_List = ro_service.getRaw_Order_List();
        logger.debug("ro_List : " + ro_List);
        
        model.addAttribute("ro_List", ro_List);
        
//        return "/stock/raw_order";
    }
    // 발주 목록 조회
	
	
	
	// 입고 관리 
		//http://localhost:8088/stock/In_mat
	//http://localhost:8080/stock/In_mat
//		@RequestMapping(value="/In_mat",method = RequestMethod.GET)
//		public String In_matGET(Model model,@ModelAttribute("result!@#$%^&*()_") String result) throws Exception{
//			logger.debug(" In_matGET() 호출 ");
//			logger.debug(" result!@#$%^&*()_" +result);
//			
//			// 서비스 - DB에 저장된 글 정보를 가져오기
//			List<In_materialVO> In_materialList = service.getIn_mat();
//			logger.debug("In_materialList : " + In_materialList);
//			// 연결된 뷰페이지로 전달 (뷰 - 출력)
//			model.addAttribute("In_materialList", In_materialList);
//			
//			return "/stock/In_mat";
//		}
	
	// 입고 관리 
		//http://localhost:8088/stock/In_material
		//http://localhost:8080/stock/In_material
	@RequestMapping(value = "/In_material",method = RequestMethod.GET)
	public void In_matGET(Model model) throws Exception {
		
		List<In_materialVO> In_materialList = service.getIn_mat();
		
		logger.debug("In_materialList : " + In_materialList);
		
		model.addAttribute("In_materialList", In_materialList);
	}
	// 입고 목록
}
