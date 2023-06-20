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
import org.springframework.web.bind.annotation.RequestParam;

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
    // http://localhost:8080/stock/raw_order?num=1
	// http://localhost:8088/stock/raw_order?num=1

//    @RequestMapping(value = "/raw_order", method = RequestMethod.GET)
//    public String ro_ListGET(Model model) throws Exception {
//        logger.debug("ro_ListGET() 호출");
//        
//        // Service - DB에 저장된 발주 목록 가져오기
//        List<Raw_orderVO> ro_List = ro_service.getRaw_Order_List();
//        logger.debug("ro_List : " + ro_List);
//        
//        model.addAttribute("ro_List", ro_List);
//        
//        return "/stock/raw_order";
//    }
    // 발주 목록 조회
	
	
	// 발주 페이징 처리
	 // http://localhost:8080/stock/raw_order
		// http://localhost:8088/stock/raw_order
    @RequestMapping(value="/raw_order", method = RequestMethod.GET)
    public void getListPage(Model model , @RequestParam("num") int num) throws Exception {
    	
    	 // 게시물 총 갯수
    	 int count1 = ro_service.count1();
    	 
    	 // 한 페이지에 출력할 게시물 갯수
    	 int postNum = 2;
    	 
    	// 하단 페이징 번호 ([ 게시물 총 갯수 ÷ 한 페이지에 출력할 갯수 ]의 올림)
    	 int pageNum = (int)Math.ceil((double)count1/postNum);
    	  
    	 // 출력할 게시물
    	 int displayPost = (num - 1) * postNum;
    	 
//    	// 한번에 표시할 페이징 번호의 갯수
//    	 int pageNum_cnt = 10;
//
//    	 // 표시되는 페이지 번호 중 마지막 번호
//    	 int endPageNum = (int)(Math.ceil((double)count1 / (double)pageNum_cnt) * pageNum_cnt);
//
//    	 // 표시되는 페이지 번호 중 첫번째 번호
//    	 int startPageNum = endPageNum - (pageNum_cnt - 1);
//    	 
//    	// 마지막 번호 재계산
//    	 int endPageNum_tmp = (int)(Math.ceil((double)count1 / (double)pageNum_cnt));
//    	  
//    	 if(endPageNum > endPageNum_tmp) {
//    	  endPageNum = endPageNum_tmp;
//    	 }
//    	 
//    	 boolean prev = startPageNum == 1 ? false : true;
//    	 boolean next = endPageNum * pageNum_cnt >= count1 ? false : true;
//    	
    	List<Raw_orderVO> ro_List = ro_service.getRaw_orderPage(displayPost, postNum);
    	
    	model.addAttribute("ro_List", ro_List);
    	 model.addAttribute("pageNum", pageNum);
//    	 
//    	// 시작 및 끝 번호
//    	 model.addAttribute("startPageNum", startPageNum);
//    	 model.addAttribute("endPageNum", endPageNum);
//
//    	 // 이전 및 다음 
//    	 model.addAttribute("prev", prev);
//    	 model.addAttribute("next", next);
//    	 
//    	 logger.debug("count : " + count1);
//    	// 현재 페이지
//    	 model.addAttribute("select", num);
//    	 model.addAttribute("count1",count1);
    }
    // 발주 페이징 처리
	
	
	// 입고 페이징
    //http://localhost:8088/stock/In_material?num=1
  	//http://localhost:8080/stock/In_material?num=1
    @RequestMapping(value = "/In_material",method = RequestMethod.GET)
    public void In_matPage(Model model, @RequestParam("num") int num) throws Exception {
        
    	
    	// 게시물 총 갯수
        int count = service.count();

        // 한 페이지 출력 갯수
        int postNum = 1;

        // 하단 페이지 번호
        int pageNum = (int) Math.ceil((double) count / postNum);

        // 출력 게시물
        int displayPost = (num - 1) * postNum;

        // 한번에 표시할 페이징 번호의 갯수
        int pageNum_cnt = 1;

        // 표시되는 페이지 번호 중 첫번째 번호
        int startPageNum = (int) (Math.ceil((double) num / pageNum_cnt) * pageNum_cnt) - pageNum_cnt + 1;

        // 표시되는 페이지 번호 중 마지막 번호
        int endPageNum = startPageNum + pageNum_cnt - 1;
        if (endPageNum > pageNum) {
            endPageNum = pageNum;
        }

        // 이전 및 다음
        boolean prev = startPageNum != 1;
        boolean next = endPageNum != pageNum;
    
        
        List<In_materialVO> In_materialList = service.getIn_matPage(displayPost, postNum);
        
        
        model.addAttribute("In_materialList", In_materialList);
        model.addAttribute("pageNum", pageNum);
        
        // 시작 및 끝 번호
        model.addAttribute("startPageNum", startPageNum);
        model.addAttribute("endPageNum", endPageNum);

        // 이전 및 다음 
        model.addAttribute("prev", prev);
        model.addAttribute("next", next);
        
        // 현재 페이지
        model.addAttribute("select",num);
    }
    // 입고 페이징
}
