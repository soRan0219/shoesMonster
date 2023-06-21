package com.sm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.sm.domain.Out_materialVO;
import com.sm.domain.Raw_orderVO;
import com.sm.domain.StockVO;
import com.sm.service.In_materialService;
import com.sm.service.Out_materialService;
import com.sm.service.Raw_orderService;
import com.sm.service.StockService;

@Controller
@RequestMapping(value = "/stock/*")
public class stockController {
	
	@Autowired
	private In_materialService service;
	
	@Autowired
	private Raw_orderService ro_service;
	
	@Autowired
	private StockService s_service;
	
	@Autowired
	private Out_materialService o_service;
	
	private static final Logger logger = LoggerFactory.getLogger(stockController.class);
	

	
	// 발주 목록 + 페이징 처리 - 시작
    // http://localhost:8080/stock/raw_order
	// http://localhost:8088/stock/raw_order
	@RequestMapping(value="/raw_order", method = RequestMethod.GET)
    public void getListPage(HttpServletRequest request, Model model) throws Exception {
        
         // 게시물 총 개수
         int count1 = ro_service.count1();
         
         // 한 페이지에 출력할 게시물 개수
         int pageSize = 1;
         
         String pageNum = request.getParameter("num");
         if(pageNum == null) {
        	 pageNum = "1";
         }
         
         // 행번호
         int currentPage = Integer.parseInt(pageNum);
         int startRow = (currentPage - 1) * pageSize;
         
         // 페이징 처리 - 하단
 		 int pageCount = count1/pageSize + (count1%pageSize == 0? 0 : 1);
 		 int pageBlock = 1;

 		 // 페이지 번호
 		 int startPage = ((currentPage-1)/pageBlock)*pageBlock + 1;
 		 int endPage = startPage+pageBlock-1;
 		 if(endPage > pageCount) {
 			 endPage = pageCount;
 		 } 
         
         List<Raw_orderVO> ro_List = ro_service.getRaw_order(startRow, pageSize);
        
         model.addAttribute("ro_List", ro_List);
         model.addAttribute("startPage", startPage);
         model.addAttribute("endPage", endPage);
         model.addAttribute("pageBlock", pageBlock);
         model.addAttribute("count1",count1);
    }
	// 발주 목록 + 페이징 처리 - 끝
	
	
	
    

	
	
	// 입고 페이징
    
    //http://localhost:8088/stock/In_material
    //http://localhost:8088/stock/In_material?num=1
  	//http://localhost:8080/stock/In_material?num=1
	@RequestMapping(value = "/In_material", method = RequestMethod.GET)
	public void In_matPage(HttpServletRequest request, Model model, In_materialVO ivo) throws Exception {

		if (ivo.getClient_code() != null || ivo.getIn_num() != null || ivo.getRaw_order_num() != null) {

			int count = service.count(ivo);

			int postNum = 2;

			// 하단 페이지 번호
//             int pageNum = (int) Math.ceil((double) count / postNum);
			String pageNum = request.getParameter("num");
			if (pageNum == null) {
				pageNum = "1";
			}

			int currentPage = Integer.parseInt(pageNum);
			int displayPost = (currentPage - 1) * postNum;

			// 페이징 처리 2 - 하단
			int pageCount = count / postNum + (count % postNum == 0 ? 0 : 1);
			int pageBlock = 2;

			// 페이지 번호
			int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}

			List<In_materialVO> In_materialList = service.getIn_matPage(displayPost, postNum, ivo);
			model.addAttribute("In_materialList", In_materialList);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageBlock", pageBlock);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("count", count);

		} else {// 검색어 null 일때

			int count = service.count();

			int postNum = 2;

			// 하단 페이지 번호
//     	        int pageNum = (int) Math.ceil((double) count / postNum);
			String pageNum = request.getParameter("num");
			if (pageNum == null) {
				pageNum = "1";
			}

			int currentPage = Integer.parseInt(pageNum);
			int displayPost = (currentPage - 1) * postNum;

			// 페이징 처리 2 - 하단
			int pageCount = count / postNum + (count % postNum == 0 ? 0 : 1);
			int pageBlock = 2;

			// 페이지 번호
			int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}

			List<In_materialVO> In_materialList = service.getIn_matPage(displayPost, postNum);
			model.addAttribute("In_materialList", In_materialList);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageBlock", pageBlock);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("count", count);
		}
     

        
        

        
        

    }
    // 입고 페이징
    
    ///////////////////////////////////////////재고 페이지 ///////////////////////////////////////////
   
    	//http://localhost:8088/stock/stockList
    	@RequestMapping(value="/stockList" ,method = RequestMethod.GET)
    	public void stockList(HttpServletRequest request , Model model) throws Exception {
    		
    		 // 게시물 총 개수
            int count3 = s_service.count3();
            
            // 한 페이지에 출력할 게시물 개수
            int pageSize = 1;
            
            String pageNum = request.getParameter("num");
            if(pageNum == null) {
           	 pageNum = "1";
            }
            
            // 행번호
            int currentPage = Integer.parseInt(pageNum);
            int startRow = (currentPage - 1) * pageSize;
            
            // 페이징 처리 - 하단
    		 int pageCount = count3/pageSize + (count3%pageSize == 0? 0 : 1);
    		 int pageBlock = 1;

    		 // 페이지 번호
    		 int startPage = ((currentPage-1)/pageBlock)*pageBlock + 1;
    		 int endPage = startPage+pageBlock-1;
    		 if(endPage > pageCount) {
    			 endPage = pageCount;
    		 } 
            
            List<StockVO> stockList = s_service.getStockList(startRow, pageSize);
           
            model.addAttribute("stockList", stockList);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);
            model.addAttribute("pageBlock", pageBlock);
            model.addAttribute("count3",count3);
    		
    	}
    
    
    ///////////////////////////////////////////재고 페이지 ///////////////////////////////////////////
    	
    	//////////////////////////// 출고 페이지 ///////////////////////////////////////
    	 //http://localhost:8088/stock/Out_material
    	@RequestMapping(value="/Out_material" ,method = RequestMethod.GET)
    	public void out_matList(HttpServletRequest request , Model model) throws Exception {
    		
		// 게시물 총 개수
		int count2 = o_service.count2();

		// 한 페이지에 출력할 게시물 개수
		int pageSize = 1;

		String pageNum = request.getParameter("num");
		if (pageNum == null) {
			pageNum = "1";
		}

		// 행번호
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize;

		// 페이징 처리 - 하단
		int pageCount = count2/ pageSize + (count2 % pageSize == 0 ? 0 : 1);
		int pageBlock = 1;

		// 페이지 번호
		int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		List<Out_materialVO> out_matList = o_service.getOut_matList(startRow, pageSize);

		model.addAttribute("out_matList", out_matList);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageBlock", pageBlock);
		model.addAttribute("count2", count2);
    		
    	}
    	
    	
    	//////////////////////////// 출고 페이지 ///////////////////////////////////////
}
