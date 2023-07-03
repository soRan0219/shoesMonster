package com.sm.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sm.domain.BottomPaging;
import com.sm.domain.ClientsVO;
import com.sm.domain.In_materialVO;
import com.sm.domain.OrderStatusVO;
import com.sm.domain.Out_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.ProductVO;
import com.sm.domain.Raw_orderVO;
import com.sm.domain.StockVO;
import com.sm.domain.WarehouseVO;
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
    public void getListPage(PageVO vo, HttpServletRequest request, Model model ,Raw_orderVO rvo) throws Exception {
        
		
		if((rvo.getClients().getClient_actname() != null && !rvo.getClients().getClient_actname().equals("")) ||
		   (rvo.getRaw_order_num() != null && !rvo.getRaw_order_num().equals("")) || 
		   (rvo.getRawMaterial() != null && rvo.getRawMaterial().getRaw_name() != null && !rvo.getRawMaterial().getRaw_name().equals(""))) {
			

			// 게시물 총 개수
	        int count1 = ro_service.count1(rvo);

	         
	        List<Raw_orderVO> ro_List = ro_service.getRaw_order(vo, rvo);
	        logger.debug("@@@@@@@@@@@@@@ : " + vo);
	        logger.debug("@@@@@@@@@@@@@@ : " + ro_List);
	         
	        BottomPaging bp = new BottomPaging();
			bp.setPageVO(vo);
			bp.setTotalCount(count1);
			logger.debug("@@@@@@@@@@@@@@ : " + bp);
			
			model.addAttribute("ro_List", ro_List);
			model.addAttribute("count1", count1);
			model.addAttribute("bp", bp);

			model.addAttribute("rvo", rvo);
	
			

			
		} else {
			
		
			List<Raw_orderVO> ro_List = ro_service.getRaw_order(vo);
			
			int count1 = ro_service.count1();
			
			BottomPaging bp = new BottomPaging();
			bp.setPageVO(vo);
			bp.setTotalCount(count1);
			
			model.addAttribute("ro_List", ro_List);
			model.addAttribute("count1", count1);
			model.addAttribute("bp", bp);
			request.setAttribute("rvo", rvo);
		}
		
		
	}
	// 발주 목록 + 페이징 처리 - 끝
	// 발주 등록
	@RequestMapping(value="/raw_order", method = RequestMethod.POST)
	public String roRegist(@RequestParam("wh_code") String wh_code,
//						   @RequestParam("emp_id") String emp_id,
						   Raw_orderVO vo, RedirectAttributes rttr,
						   HttpSession session, HttpServletRequest request,
						   Model model) throws Exception {
		
		// 로그인 정보
//		String emp_id = (String)session.getAttribute("emp_id");
//		request.setAttribute("emp_id", emp_id);
		logger.debug("///////////////// wh_code : " + wh_code + "////////////////");
//		logger.debug("///////////////// emp_id : " + emp_id + "////////////////");
		
		ro_service.roInsert(vo);
	
		rttr.addFlashAttribute("result", "roInsert");
		
		return "redirect:/stock/raw_order";
	}

	// 발주 등록 팝업창
    @RequestMapping(value = "/roPopup", method = RequestMethod.GET)
    public void getClient(Model model, PageVO vo ,Raw_orderVO rvo) throws Exception {
        
        if((rvo.getClients().getClient_actname() != null && !rvo.getClients().getClient_actname().equals("")) ||
                   (rvo.getRawMaterial() != null && rvo.getRawMaterial().getRaw_name() != null && !rvo.getRawMaterial().getRaw_name().equals(""))) {
            
            List<Raw_orderVO> roPopup = ro_service.Popup(vo, rvo);
            
            int countPop = ro_service.countPop(rvo);
            
            BottomPaging bp = new BottomPaging();
            bp.setPageVO(vo);
            bp.setTotalCount(countPop);
            
            model.addAttribute("roPopup", roPopup);
            model.addAttribute("countPop", countPop);
            model.addAttribute("bp", bp);
            
            model.addAttribute("rvo", rvo);
            
        }else {
        
        
        List<Raw_orderVO> roPopup = ro_service.getPopup(vo);
        
        int countPop = ro_service.countPoP();
        
        BottomPaging bp = new BottomPaging();
        bp.setPageVO(vo);
        bp.setTotalCount(countPop);
        
        model.addAttribute("roPopup", roPopup);
        model.addAttribute("countPop", countPop);
        model.addAttribute("bp", bp);
        
        model.addAttribute("rvo", rvo);
        
        }
    }

	// 발주 거래처 상세 팝업
	@RequestMapping(value = "/detailPopup", method = RequestMethod.GET)
	public void getDetail(Model model, HttpServletRequest request) throws Exception {
//		request.setAttribute("rawCode", rawCode);
		
	}

	// 창고 목록 팝업
	@RequestMapping(value = "/whPopup", method = RequestMethod.GET)
	public void getWarehouse(Model model) throws Exception {
		
		List<WarehouseVO> whPopup = ro_service.whPopup();
		
		model.addAttribute("whPopup", whPopup);
		
	}
	
	// ====================================== 발주 - 끝 ====================================== //
	
	// ====================================== 입고 - 시작 ====================================== //
	
	// 입고 페이징
    //http://localhost:8080/stock/In_material
	//http://localhost:8088/stock/In_material
	@RequestMapping(value = "/In_material", method = RequestMethod.GET)
    public void In_matPage(HttpServletRequest request, Model model , Raw_orderVO rvo ,PageVO vo) throws Exception {
            
		if((rvo.getClients().getClient_actname() != null && !rvo.getClients().getClient_actname().equals("")) ||
                (rvo.getIn_mat().getIn_num() != null && !rvo.getIn_mat().getIn_num().equals("")) || 
                (rvo.getRawMaterial().getRaw_name() != null && !rvo.getRawMaterial().getRaw_name().equals(""))) {
                 
                 // 게시물 총 개수
                 int count1 = ro_service.count1(rvo);
                 logger.debug("@@@@@@@@@@@@@@@@@@@@@count1 : "+count1);
                 
                 List<Raw_orderVO> ro_List = ro_service.getRaw_order(vo, rvo);
                 logger.debug("@@@@@@@@@@@@@@ : " + vo);
                 logger.debug("@@@@@@@@@@@@@@ : " + ro_List);
                  
                 BottomPaging bp = new BottomPaging();
                 bp.setPageVO(vo);
                 bp.setTotalCount(count1);
                 logger.debug("@@@@@@@@@@@@@@ : " + bp);
                 
                 model.addAttribute("ro_List", ro_List);
                 model.addAttribute("count1", count1);
                 model.addAttribute("bp", bp);
                 model.addAttribute("rvo", rvo);
                 
             } else {
             
                 List<Raw_orderVO> ro_List = ro_service.getRaw_order(vo);
                 
                 int count1 = ro_service.count1();
                 
                 BottomPaging bp = new BottomPaging();
                 bp.setPageVO(vo);
                 bp.setTotalCount(count1);
                 
                 model.addAttribute("ro_List", ro_List);
                 model.addAttribute("count1", count1);
                 model.addAttribute("bp", bp);
                 model.addAttribute("rvo", rvo);
             }

    }
	
	// 입고 등록 버튼
	//http://localhost:8080/stock/In_material
	//http://localhost:8088/stock/In_material
    @RequestMapping(value = "/In_material" , method = RequestMethod.POST)
    public String inRegist(@RequestParam("in_Button") String in_Button, PageVO vo,
    					   Raw_orderVO rvo, RedirectAttributes rttr, HttpSession session, HttpServletRequest request, Model model) throws Exception{
        
    	String[] values = in_Button.split(",");
        String raw_order_num = values[0];
        String rawCode = values[1];
        int raw_order_count = Integer.parseInt(values[2]);
        String wh_code = values[3];

        logger.debug("@@@@@@@@@@@@@@@ 버튼 발주 번호 확인용 : " + raw_order_num);
        logger.debug("@@@@@@@@@@@@@@@ 원자재 코드 확인용 : " + rawCode);
        logger.debug("@@@@@@@@@@@@@@@ 발주 개수 확인용 : " + raw_order_count);
        logger.debug("@@@@@@@@@@@@@@@ 입고 창고 확인용 : " + wh_code);
        
        service.inInsert(raw_order_num);
//        service.updateIn(raw_order_num);
        
        // 로그인 정보
        String emp_id = (String)session.getAttribute("emp_id");
        request.setAttribute("emp_id", emp_id);
        
        
        boolean result = service.selectCheck(rawCode);
        
        if(result) {
        	logger.debug("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
        	service.updateStock(rawCode, raw_order_count);
        } else {
        	logger.debug("XXXXXXXXXXXXXXXXX ");
        	service.insertStock(rawCode, raw_order_count, wh_code);
        }
        
        // 재고에 입고할 항목있는지 조회(select)
//        service.selectCheck(rawCode);
        
        
        
        
        rttr.addFlashAttribute("result", "inInsert");
        
        logger.debug("@@@@@@@@@@@@ 리턴 확인용 : " + raw_order_num);
        
        return "redirect:/stock/In_material";
    }

    // ====================================== 입고 - 끝 ====================================== //
    
    // ====================================== 재고 - 시작 ====================================== //
   
	//http://localhost:8080/stock/stockList
	//http://localhost:8088/stock/stockList
	@RequestMapping(value="/stockList" ,method = RequestMethod.GET)
	public void stockList(PageVO vo, HttpServletRequest request , Model model, StockVO svo) throws Exception {
		
		logger.debug("/////////////////////////////////////svo /////////////////////////////////////" + svo);
		logger.debug("//////////// "+ svo.getRaw_code());
		logger.debug("//////////// "+ svo.getProd_code());
		logger.debug("//////////// "+ svo.getRaw_mat().getRaw_name());
		logger.debug("//////////// "+ svo.getProduct().getProd_name());
		logger.debug("//////////// "+ svo.getWh_code());
		
		if((svo.getRaw_code() != null && !svo.getRaw_code().equals("")) ||
		   (svo.getProd_code() != null && !svo.getProd_code().equals("")) ||
		   (svo.getRaw_mat().getRaw_name() != null && !svo.getRaw_mat().getRaw_name().equals("")) || 
		   (svo.getProduct().getProd_name() != null && !svo.getProduct().getProd_name().equals("")) || 
		   (svo.getWh_code() != null && !svo.getWh_code().equals(""))) {
					
				logger.debug("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");

					// 게시물 총 개수
			        int count3 = s_service.count3(svo);
			        logger.debug("검색 재고 개수 : " + count3);

			        List<StockVO> stock_List = s_service.getStock(vo, svo);
			        logger.debug("@@@@@@@@@@@@@@ : " + vo);
			        logger.debug("@@@@@@@@@@@@@@ : " + stock_List);
			         
			        BottomPaging bp = new BottomPaging();
					bp.setPageVO(vo);
					bp.setTotalCount(count3);
					logger.debug("@@@@@@@@@@@@@@ : " + bp);
					
					model.addAttribute("stock_List", stock_List);
					model.addAttribute("count3", count3);
					model.addAttribute("bp", bp);
					model.addAttribute("svo", svo);
  
    				} else {
    				
    					logger.debug("ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ");
    					
    					int count3 = s_service.count3();
    					logger.debug("재고 총 개수 : " + count3);
    					
    					List<StockVO> stock_List = s_service.getStock(vo);
					
						BottomPaging bp = new BottomPaging();
						bp.setPageVO(vo);
						bp.setTotalCount(count3);
						
						model.addAttribute("stock_List", stock_List);
						model.addAttribute("count3", count3);
						model.addAttribute("bp", bp);
						request.setAttribute("svo", svo);
				}
    		
            
    	}
	
	@RequestMapping(value ="/stockList" , method = RequestMethod.POST)
    public String updateCount(@RequestParam("modify_Button") String modify_Button,
    							@RequestParam("new_stock_count") String new_stock_count,
    						  HttpSession session, HttpServletRequest request) throws Exception{
        
		String[] values = modify_Button.split(",");
        String code = values[0];
//        String new_stock_count = values[1];
		
		logger.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ" + modify_Button + "ㅁㅁㅁㅁㅁㅁㅁㅁ");
		logger.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ" + code + "ㅁㅁㅁㅁㅁㅁㅁㅁ");
		logger.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ" + new_stock_count + "ㅁㅁㅁㅁㅁㅁㅁㅁ");
		
        String emp_id = (String)session.getAttribute("emp_id");
        request.setAttribute("emp_id", emp_id);
        
        
//        s_service.updateCount(stock_count,raw_code);
        
        return "redirect:/stock/stockList";
    }

    // ====================================== 재고 - 끝 ====================================== //
    	
    // ====================================== 출고 - 시작 ====================================== //
    	
    	//http://localhost:8080/stock/Out_material
    	//http://localhost:8088/stock/Out_material
//    	@RequestMapping(value="/Out_material" ,method = RequestMethod.GET)
//    	public void out_matList(HttpServletRequest request, Model model, OrderStatusVO ovo) throws Exception {
//
//    		if (ovo.getClients().getClient_actname() != null
//    				|| ovo.getOut_mat().getOut_num() != null ||  ovo.getProd().getProd_name() != null) {
//
//    			logger.debug("ovo : " + ovo);
//    			// 게시물 총 개수
//    			int count2 = o_service.count2(ovo);
//
//    			// 한 페이지에 출력할 게시물 개수
//    			int pageSize = 30;
//
//    			String pageNum = request.getParameter("num");
//    			if (pageNum == null) {
//    				pageNum = "1";
//    			}
//
//    			// 행번호
//    			int currentPage = Integer.parseInt(pageNum);
//    			int startRow = (currentPage - 1) * pageSize;
//
//    			// 페이징 처리 - 하단
//    			int pageCount = count2 / pageSize + (count2 % pageSize == 0 ? 0 : 1);
//    			int pageBlock = 5;
//
//    			// 페이지 번호
//    			int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
//    			int endPage = startPage + pageBlock - 1;
//    			if (endPage > pageCount) {
//    				endPage = pageCount;
//    			}
//
//    			List<Out_materialVO> out_matList = o_service.searchOut_mat(startRow, pageSize, ovo);
//
//    			model.addAttribute("out_matList", out_matList);
//    			model.addAttribute("startPage", startPage);
//    			model.addAttribute("endPage", endPage);
//    			model.addAttribute("pageBlock", pageBlock);
//    			model.addAttribute("count2", count2);
//    			model.addAttribute("ovo", ovo);
//
//    		} else {
//
//    			// 게시물 총 개수
//    			int count2 = o_service.count2();
//
//    			// 한 페이지에 출력할 게시물 개수
//    			int pageSize = 30;
//
//    			String pageNum = request.getParameter("num");
//    			if (pageNum == null) {
//    				pageNum = "1";
//    			}
//
//    			// 행번호
//    			int currentPage = Integer.parseInt(pageNum);
//    			int startRow = (currentPage - 1) * pageSize;
//
//    			// 페이징 처리 - 하단
//    			int pageCount = count2 / pageSize + (count2 % pageSize == 0 ? 0 : 1);
//    			int pageBlock = 5;
//
//    			// 페이지 번호
//    			int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
//    			int endPage = startPage + pageBlock - 1;
//    			if (endPage > pageCount) {
//    				endPage = pageCount;
//    			}
//
//    			List<Out_materialVO> out_matList = o_service.getOut_matList(startRow, pageSize);
//
//    			model.addAttribute("out_matList", out_matList);
//    			model.addAttribute("startPage", startPage);
//    			model.addAttribute("endPage", endPage);
//    			model.addAttribute("pageBlock", pageBlock);
//    			model.addAttribute("count2", count2);
//
//    		}
//    	}
    	
    	// 출고 처리 버튼
    	//http://localhost:8080/stock/Out_material
    	//http://localhost:8088/stock/Out_material
    	@RequestMapping(value = "/Out_material", method = RequestMethod.POST)
    	public void omRegist(OrderStatusVO vo, RedirectAttributes rttr,
    			HttpSession session, HttpServletRequest request
    			, Model model , String order_code) throws Exception {
    	    logger.debug("@@@@@@@@@@ 출고 처리 버튼 컨트롤러 @@@@@@@@@@");

    	    String emp_id = (String) session.getAttribute("emp_id"); // 로그인 정보 세션에 담아오기
    	    vo.getOut_mat().setEmp_id(emp_id); // 담당자 설정

//    	    o_service.omButton(vo, order_code); // 출고 처리 메서드 호출
    	    rttr.addFlashAttribute("result", "omButton");

//    	    return "redirect:/stock/Out_material";
    	}
    	// 출고 처리 버튼
    	
    	
    	// http://localhost:8080/stock/Out_material
    	// http://localhost:8088/stock/Out_material
    	@RequestMapping(value="/Out_material", method = RequestMethod.GET)
    	public void Out_material(PageVO vo, HttpServletRequest request, Model model ,Out_materialVO rvo) throws Exception {
            
    		if((rvo.getOut_num() !=null && !rvo.getOut_num().equals("")) ||
    		   (rvo.getProd().getProd_name() != null && !rvo.getProd().getProd_name().equals("")) ||
    		   (rvo.getClients().getClient_actname() != null && !rvo.getClients().getClient_actname().contentEquals(""))) {
    			
    			// 게시물 총 개수
    	        int count4 = o_service.count4(rvo);
    	        
    	        List<Out_materialVO> out_List = o_service.getSearch_Out(vo, rvo);
    	        
    	        logger.debug("@@@@@@@@@@@@@@ : " + vo);
    	        logger.debug("@@@@@@@@@@@@@@ : " + out_List);
    	         
    	        BottomPaging bp = new BottomPaging();
    			bp.setPageVO(vo);
    			bp.setTotalCount(count4);
    			logger.debug("@@@@@@@@@@@@@@ : " + bp);
    			
    			model.addAttribute("out_List", out_List);
    			model.addAttribute("count4", count4);
    			model.addAttribute("bp", bp);

    			model.addAttribute("rvo", rvo);
    	
    		} else {
    		
    			List<Out_materialVO> out_List = o_service.getOut_matList(vo);
    			
    			int count4 = o_service.count4();
    			
    			BottomPaging bp = new BottomPaging();
    			bp.setPageVO(vo);
    			bp.setTotalCount(count4);
    			
    			model.addAttribute("out_List", out_List);
    			model.addAttribute("count4", count4);
    			model.addAttribute("bp", bp);
    			request.setAttribute("rvo", rvo);
    		}
    		
    		
    	}
    	
    	// 출고 검색
//    	@RequestMapping(value="/Out_material",method=RequestMethod.POST)
//    	public void searchOut_mat(Model model , Out_materialVO ovo 
//    			,ClientsVO cvo , ProductVO pvo) throws Exception{
//    		
//    		if (ovo.getOut_num() != null || cvo.getClient_actname() != null || pvo.getProd_name() != null
//    				) {
//
////    			List<Out_materialVO> searchList = o_service.searchOut_mat(ovo);
//    			model.addAttribute("searchlist", searchList);
//
//    			logger.debug("searchlist : " + searchList);
//
//    			logger.debug("@@ 검색 리스트 호출 @@");
//
//    		} 
//    		
//    		
//    		
//    	}
    	
    // ====================================== 출고 - 끝 ====================================== //    
}
    	

