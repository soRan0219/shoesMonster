package com.sm.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.sm.domain.EmployeesVO;
import com.sm.domain.LineVO;
import com.sm.domain.LineWhPageMaker;
import com.sm.domain.LineWhPageVO;
import com.sm.domain.PagingVO;
import com.sm.domain.PerformanceVO;
import com.sm.domain.ProductList;
import com.sm.domain.ProductVO;
import com.sm.domain.RawMaterialList;
import com.sm.domain.RawMaterialVO;
import com.sm.domain.RequirementsList;
import com.sm.domain.RequirementsVO;
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

	// ======================================================================================

	// http://localhost:8088/performance/product
	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public void productGET(Model model, ProductVO vo, PagingVO pvo,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
			@RequestParam(value = "input", required = false) String input) throws Exception {
		logger.debug("productGET() 호출");
		List<ProductVO> products = new ArrayList<ProductVO>();
		model.addAttribute("products", products);
		logger.debug("vo : " + vo);
		logger.debug(" @@@@@@@@@@ input: " + input + "@@@@@@@@@@@@@@@");

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}

		if (vo.getProd_code() != null || vo.getProd_name() != null || vo.getProd_category() != null
				|| vo.getProd_unit() != null) {
			int total = service.countProd(vo);
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			List<ProductVO> list = service.getProdList(vo, pvo);
			model.addAttribute("prodList", list);
			model.addAttribute("paging", pvo);
			model.addAttribute("vo", vo);
			logger.debug("pvo : " + pvo);
			logger.debug("vo : " + vo);

			logger.debug("검색 리스트 가져감");

			if (input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@");
			}

		} else {
			int total = service.countProd();
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			logger.debug("pvo : " + pvo);
			List<ProductVO> list = service.getProdList(pvo);
			model.addAttribute("prodList", list);
			model.addAttribute("paging", pvo);
			logger.debug(" 모든 리스트 가져감");
		}

	}

	// 품목관리 정보 추가
	@RequestMapping(value = "product", method = RequestMethod.POST)
	public String productPOST(ProductList products) throws Exception {

		logger.debug("productPOST() 호출");
		logger.debug("prducts : " + products.getProducts());
		service.insertProd(products.getProducts());
//		service.insertProd(vo);

		return "redirect:/performance/product";
	}

	// 품목관리 삭제
	@RequestMapping(value = "/prodDelete", method = RequestMethod.POST)
	public String deleteProd(@RequestParam(value = "checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deleteProd() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);

		// 서비스 - 품목관리 삭제
		service.removeProd(checked);

		return "redirect:/performance/product";
	} // deleteProd()
	
	// 품목관리 조회 POST
	@ResponseBody
	@RequestMapping(value = "/prodOne", method = RequestMethod.POST)
	public ProductVO getProd(@RequestBody ProductVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getProd() 호출");
		logger.debug("@@@@@ CONTROLLER: prod_Code = " + vo.getProd_code());
		
		//서비스 - 품목관리 정보 가져오기
		ProductVO preVO = service.getProd(vo.getProd_code());
		logger.debug("@@@@@ CONTROLLER: preVO = " + preVO);
		
		return preVO;
	} //getProd()
	
	//품목관리 수정 
	@RequestMapping(value = "/prodModify", method = RequestMethod.POST)
	public String modifyProd(/*@RequestBody */ProductVO uvo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: modifyProd() 호출");
		logger.debug("@@@@@ CONTROLLER: uvo = " + uvo);
		
		//서비스 - 작업지시 수정
		service.modifyProd(uvo);
		
		return "redirect:/performance/product";
	} //modifyProd()

	// =====================================================================================

	// 원자재관리
	// http://localhost:8088/performance/rawMaterial
	@RequestMapping(value = "/rawMaterial", method = RequestMethod.GET)
	public void rawMaterialGET(Model model, RawMaterialVO vo, PagingVO pvo,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
			@RequestParam(value = "input", required = false) String input) throws Exception {

		logger.debug("rawMaterialGET() 호출");
		List<RawMaterialVO> raws = new ArrayList<RawMaterialVO>();
		model.addAttribute("raws", raws);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		logger.debug("vo : " + vo);

		if (vo.getRaw_code() != null || vo.getClients().getClient_actname() != null || vo.getRaw_name() != null) {

			logger.debug("if문 호출");
			int total = service.countRaw(vo);
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			List<RawMaterialVO> list = service.getRawList(vo, pvo);
			model.addAttribute("rawList", list);
			model.addAttribute("paging", pvo);
			model.addAttribute("vo", vo);
			logger.debug("pvo : " + pvo);
			logger.debug("vo : " + vo);

			logger.debug("검색 리스트 가져감");
			
			// input 추가 
			if (input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@");
			}

		} else {
			logger.debug("else문 호출");
			int total = service.countRaw();
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			logger.debug("pvo : " + pvo);
			List<RawMaterialVO> list = service.getRawList(pvo);
			model.addAttribute("rawList", list);
			model.addAttribute("paging", pvo);
			logger.debug(" 모든 리스트 가져감");
		}

	}

	// 원자재관리 정보 추가
	@RequestMapping(value = "rawMaterial", method = RequestMethod.POST)
	public String rawMaterialPOST(RawMaterialList raws) throws Exception {

		logger.debug("rawMaterialPOST() 호출");
		logger.debug("raws : " + raws.getRaws());
		service.insertRaw(raws.getRaws());
		// service.insertProd(vo);

		return "redirect:/performance/rawMaterial";
	}

	// 원자재관리 정보 삭제
	@RequestMapping(value = "/rawMaterialDelete", method = RequestMethod.POST)
	public String deleteRawMaterial(@RequestParam(value = "checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deleteRawMaterial() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);

		// 서비스 - 원자재관리 삭제
		service.removeRaw(checked);

		return "redirect:/performance/rawMaterial";
	} // deleteRawMaterial()
	
	// 원자재관리 조회 POST
	@ResponseBody
	@RequestMapping(value = "/rawOne", method = RequestMethod.POST)
	public RawMaterialVO getRaw(@RequestBody RawMaterialVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getRaw() 호출");
		logger.debug("@@@@@ CONTROLLER: raw_Code = " + vo.getRaw_code());

		// 서비스 - 원자재관리 정보 가져오기
		RawMaterialVO preVO = service.getRaw(vo.getRaw_code());
		logger.debug("@@@@@ CONTROLLER: preVO = " + preVO);

		return preVO;
	} // getProd()

	// 원자재관리 수정
	@RequestMapping(value = "/rawModify", method = RequestMethod.POST)
	public String modifyRaw(RawMaterialVO uvo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: modifyRaw() 호출");
		logger.debug("@@@@@ CONTROLLER: uvo = " + uvo);

		// 서비스 - 원자재관리 수정
		service.modifyRaw(uvo);

		return "redirect:/performance/rawMaterial";
	} // modifyRaw()

	// =====================================================================================

	// 소요량관리
	// http://localhost:8088/performance/requirement
	@RequestMapping(value = "/requirement", method = RequestMethod.GET)
	public void requirementGET(Model model, RequirementsVO vo, PagingVO pvo,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) throws Exception {

		logger.debug("requirementGET() 호출");
		List<RequirementsVO> reqs = new ArrayList<RequirementsVO>();
		model.addAttribute("reqs", reqs);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		logger.debug("vo : " + vo);

		if (vo.getReq_code() != null || vo.getProd_code() != null || vo.getProd().getProd_name() != null) {
			
			logger.debug("if문 호출");
			logger.debug("vo : " + vo);
			int total = service.countReq(vo);
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			List<RequirementsVO> list = service.getReqList(vo, pvo);
			model.addAttribute("reqList", list);
			model.addAttribute("paging", pvo);
			model.addAttribute("vo", vo);
			logger.debug("pvo : " + pvo);
			logger.debug("vo : " + vo);

			logger.debug("검색 리스트 가져감");

		} else {
			logger.debug("else문 호출");
			int total = service.countReq();
			pvo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			logger.debug("pvo : " + pvo);
			List<RequirementsVO> list = service.getReqList(pvo);
			model.addAttribute("reqList", list);
			model.addAttribute("paging", pvo);
			logger.debug(" 모든 리스트 가져감");
		}

	}

	// 소요량관리 정보 추가
	@RequestMapping(value = "requirement", method = RequestMethod.POST)
	public String requirementPOST(RequirementsList reqs) throws Exception {

		logger.debug("requirementPOST() 호출");
		logger.debug("reqs : " + reqs.getReqs());
		service.insertReq(reqs.getReqs());
		// service.insertProd(vo);

		return "redirect:/performance/requirement";
	}

	// 소요량관리 정보 삭제
	@RequestMapping(value = "/requirementDelete", method = RequestMethod.POST)
	public String deleteRequirement(@RequestParam(value = "checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deleteRequirement() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);

		// 서비스 - 소요량관리 삭제
		service.removeReq(checked);

		return "redirect:/performance/requirement";
	} // deleteRequirement()
	
	// 소요량관리 조회 POST
		@ResponseBody
		@RequestMapping(value = "/reqOne", method = RequestMethod.POST)
		public RequirementsVO getreq(@RequestBody RequirementsVO vo) throws Exception {
			logger.debug("@@@@@ CONTROLLER: getreq() 호출");
			logger.debug("@@@@@ CONTROLLER: req_Code = " + vo.getReq_code());
			
			//서비스 - 소요량관리 정보 가져오기
			RequirementsVO preVO = service.getReq(vo.getReq_code());
			logger.debug("@@@@@ CONTROLLER: preVO = " + preVO);
			
			return preVO;
		} //getProd()
		
		//소요량관리 수정 
		@RequestMapping(value = "/reqModify", method = RequestMethod.POST)
		public String modifyreq(RequirementsVO uvo) throws Exception {
			logger.debug("@@@@@ CONTROLLER: modifyreq() 호출");
			logger.debug("@@@@@ CONTROLLER: uvo = " + uvo);
			
			//서비스 - 소요량관리 수정
			service.modifyReq(uvo);
			
			return "redirect:/performance/requirement";
		} //modifyWorkOrder()

	// =====================================================================================

	// ======== 라인 - /line ================================
	// http://localhost:8088/performance/line
	@RequestMapping(value = "/line", method = RequestMethod.GET)
	public void lineGET(Model model, LineVO lvo, LineWhPageVO vo, LineWhPageMaker lwpm,
			@RequestParam Map<String, Object> params, @RequestParam(value = "input", required = false) String input)
			throws Exception {
		logger.debug("@@lineGET() 호출@@");

		logger.debug("lvo : " + lvo);

		List<LineVO> boardList = new ArrayList<>();

		// 검색
		if (lvo.getLine_code() != null || lvo.getLine_name() != null || lvo.getLine_place() != null
				|| lvo.getLine_use() != 0) {
			
			// 이거 해야 전체 목록 보여짐
			if(lvo.getLine_use() == 0) {
				lvo.setLine_use(3);
			}
			
			// 페이징처리 + 검색
			boardList = service.getSearchLinePage(vo, lvo);
			model.addAttribute("boardList", boardList);

			// 객체 다 넘기기
			model.addAttribute("lvo", lvo);
			model.addAttribute("vo", vo);
			model.addAttribute("params", params);

			logger.debug("@@!!@@ 검색 리스트 (페이징처리) 불러옴 @@!!@@");

			// 페이징처리 하단부 객체 저장
			lwpm.setLwPageVO(vo);
			lwpm.setTotalCount(service.getSearchTotalCount(lvo));
			logger.debug("lwpm (서치) : " + lwpm.getTotalCount());
			model.addAttribute("lwpm", lwpm);

			if (input != null && !input.equals("")) {
				model.addAttribute("input", input);
				logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@");
			}

		} else {
			// 페이징처리된 리스트정보
			boardList = service.getLineListPage(vo);
			model.addAttribute("boardList", boardList);
			
			model.addAttribute("lvo", lvo);

			logger.debug("@@ 모든 리스트 호출 @@");

			// 페이징처리 하단부 객체 저장
			lwpm.setLwPageVO(vo);
			lwpm.setTotalCount(service.getTotalCount());
			logger.debug("lwpm : " + lwpm.getTotalCount());
			model.addAttribute("lwpm", lwpm);
		}

	}
	
	// 사원 팝업
	@RequestMapping(value = "/lineEmpSearch", method = RequestMethod.GET)
	public String popUpLineGET(@RequestParam("type") String type,
				@RequestParam(value = "input", required = false) String input) throws Exception{
		
		logger.debug("@#@#@# C : popUpLineGET() 호출");
		logger.debug("@#@#@# C : type = "+type);
		
		if(type.equals("emp")) {
			return "redirect:/person/empinfo?input="+input;
		}
		
		return "redirect:/performance/line?input="+input;
	}
	
	// 라인 추가
	@RequestMapping(value = "/lineadd", method = RequestMethod.POST)
	public String addLine(LineVO lvo) throws Exception{
		logger.debug("@#@#@# C : addLine(LineVO lvo) 호출 ");
		logger.debug("@#@#@# C : lvo = "+lvo);
		
		// 라인 등록
		service.registLine(lvo);
		
		return "redirect:/performance/line";
	}
	
	// 라인 삭제
	@RequestMapping(value = "/linedelete", method = RequestMethod.POST)
	public String deleteLine(@RequestParam(value="checked[]") List<String> checked) throws Exception{
		logger.debug("@#@#@# C : deleteLine() 호출 ");
		logger.debug("@#@#@# C : checked = "+checked);
		
		service.deleteLine(checked);
		
		return "redirect:/performance/line";
	}
	
	// 라인 수정
	@RequestMapping(value = "/linemodify", method = RequestMethod.POST)
	public String modifyLine(LineVO lvo) throws Exception{
		logger.debug("@#@#@# C : modifyLine(LineVO lvo) 호출 ");
		logger.debug("@#@#@# C : lvo = "+lvo);
		
		service.modifyLine(lvo);
		
		return "redirect:/performance/line";
	}
	
	// 라인 조회 POST
	@ResponseBody
	@RequestMapping(value = "/line", method = RequestMethod.POST)
	public LineVO getlinePOST(@RequestBody LineVO lvo ) throws Exception {
		logger.debug("@#@#@# C : linePOST() 호출");
		logger.debug("@#@#@# C : lineCode = "+lvo.getLine_code());

		LineVO lpvo = service.getLine(lvo.getLine_code());
		logger.debug("@#@#@# C : lpvo = "+lpvo);
		
		return lpvo;
	}
	
	// ======== 라인 - /line ================================

	
	// ======== 창고 - /warehouse ===========================
	// http://localhost:8088/performance/warehouse
	@RequestMapping(value = "/warehouse", method = RequestMethod.GET)
	public void warehouseGET(Model model, LineWhPageVO vo, EmployeesVO emp,
							 LineWhPageMaker lwpm, Wh_prodVO wvo
							 ,@RequestParam HashMap<String, Object> params) throws Exception {

		logger.debug("@@ warehouseGET() 호출 @@");

		List<WarehouseVO> whList = new ArrayList<>();
		
		// 이거 해야 전체 목록 보여짐
					
			
		logger.debug("wh_use : "+wvo.getWh_use());


		// 검색(+페이징)
//		if(wvo.getWh_code() != null || wvo.getProd_code() != null || wvo.getRaw_code() != null ||
//				wvo.getWh_name() != null || wvo.getWh_use() != 0) {
			
		if(wvo.getWh_code() != null  || wvo.getWh_name() != null ||
		   wvo.getEmp() != null || wvo.getWh_use() != 0) {
		
			if(wvo.getWh_use() == 0) {
				wvo.setWh_use(3);
			}
			
			whList = service.searchWarehousePage(vo, wvo);
			model.addAttribute("whList", whList);

			// 객체 다 넘기기
			model.addAttribute("wvo", wvo);
			model.addAttribute("vo", vo);
			model.addAttribute("params", params);

			logger.debug("@@!!@@ 검색 리스트 (페이징처리) 불러옴 @@!!@@");

			// 페이징처리(하단부) 저장
			lwpm.setLwPageVO(vo);
			lwpm.setTotalCount(service.searchWh_TotalCount(wvo));
			logger.debug("lwpm (서치) : " + lwpm.getTotalCount());
			model.addAttribute("lwpm", lwpm);

			
		}else {
			
		// 모든 목록(+페이징)
		whList = service.getWh_prodListPage(vo);
		model.addAttribute("whList", whList);
		
		model.addAttribute("wvo", wvo);
		
		logger.debug("@@ 모든 리스트 호출 @@");

		// 페이징처리(하단부) 저장
		lwpm.setLwPageVO(vo);
		lwpm.setTotalCount(service.getWh_TotalCount());
		model.addAttribute("lwpm", lwpm);
		
		}
	}
	
//	// 품목 검색 팝업창
//	@RequestMapping(value = "/whsearch", method = RequestMethod.GET)
//	public String popUpGET(@RequestParam("input") String input,
//			   @RequestParam("type") String type) throws Exception{
//	
//		logger.debug("@#@#@# C : popUpGET() 호출 @#@#@#");
//		logger.debug("@#@#@# C : type = "+type);
//		
//		if(type.equals("prod")) {
//		return "redirect:/performance/product?input="+input;
//		}
//		else if(type.equals("raw")) {
//			return "redirect:/performance/rawMaterial?input="+input;
//		}
//		
//			return "redirect:/performance/warehouse?input="+input;
//		
//	}
	
	// 담당자(사원) 팝업 검색
	@RequestMapping(value = "/whsearch", method = RequestMethod.GET)
	public String popUpGET(@RequestParam("input") String input,
			   			   @RequestParam("type") String type) throws Exception{
	
		logger.debug("@#@#@# C : popUpGET() 호출 @#@#@#");
		logger.debug("@#@#@# C : type = "+type);
		
		if(type.equals("emp")) {
			return "redirect:/person/empinfo?input="+input;
		}
		
		return "redirect:/performance/warehouse?input="+input;
		
	}
	
	// 창고 추가
	@RequestMapping(value = "/whadd", method = RequestMethod.POST)
	public String addWh(Wh_prodVO wvo) throws Exception{
		logger.debug("@#@#@# C : addWh(Wh_prodVO wvo) 호출 ");
		logger.debug("@#@#@# C : wvo = "+wvo);
		
		service.registWh(wvo);
		
		return "redirect:/performance/warehouse";
	}
	
	// 창고 삭제
	@RequestMapping(value = "/whdelete", method = RequestMethod.POST)
	public String deleteWh(@RequestParam(value="checked[]") List<String> checked) throws Exception{
		logger.debug("@#@#@# C : deleteWh() 호출 ");
		logger.debug("@#@#@# C : checked = "+checked);
		
		service.deleteWh(checked);;
		
		return "redirect:/performance/warehouse";
	}
	
	// 창고 수정
	@RequestMapping(value = "/whmodify", method = RequestMethod.POST)
	public String modifyWh(Wh_prodVO wvo) throws Exception{
		logger.debug("@#@#@# C : modifyWh(Wh_prodVO wvo) 호출 ");
		logger.debug("@#@#@# C : wvo = "+wvo);
		
		service.modifyWh(wvo);
		
		return "redirect:/performance/warehouse";
	}
	
	// 창고 조회 POST
	@ResponseBody
	@RequestMapping(value = "/warehouse", method = RequestMethod.POST)
	public Wh_prodVO warehousePOST(@RequestBody Wh_prodVO wvo ) throws Exception {
		logger.debug("@#@#@# C : warehousePOST() 호출");
		logger.debug("@#@#@# C : whCode = "+wvo.getWh_code());

		Wh_prodVO whVO = service.getWarehouse(wvo.getWh_code());
		logger.debug("@#@#@# C : whVO = "+whVO);
		
		return whVO;
	}
	
	
	// ======== 창고 - /warehouse ===========================

	
	
	//// ************************* 생산실적 ************************* ////
	// 생산실적 목록
	// http://localhost:8088/performance/performList
	@RequestMapping(value = "/performList", method = RequestMethod.GET)
	public void performanceList(LineWhPageVO pvo,
								@RequestParam HashMap<String, Object> search,
								Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: performanceList() 호출");
		
		//페이지 정보
		if(search.get("pageSize")!=null) {
			int pageSize = Integer.parseInt(search.get("pageSize").toString());
			pvo.setPageSize(pageSize);
		} else {
			pvo.setPageSize(2);
		}
		
		//페이징 하단부 정보
		LineWhPageMaker pm = new LineWhPageMaker();
		pm.setLwPageVO(pvo);
		pm.setPageBlock(2);
		
		List<PerformanceVO> perfList = new ArrayList<>();
		
		//검색 있을 때
		if((search.get("search_work_code")!=null && search.get("search_work_code").equals("")) || 
				(search.get("search_fromDate")!=null && search.get("search_fromDate").equals("")) || 
				(search.get("search_toDate")!=null && search.get("search_toDate").equals("")) ||
				(search.get("search_line_code")!=null && search.get("search_line_code").equals("")) ||
				(search.get("search_prod_code")!=null && search.get("search_prod_code").equals(""))) {
			
			logger.debug("@@@@@ CONTROLLER: 검색 service 호출");
			
			search.put("startPage", pvo.getStartPage());
			search.put("pageSize", pvo.getPageSize());
			
			//서비스 - 생산실적관리 검색, 개수
			perfList = service.getPerfList(search);
			logger.debug("@@@@@ CONTROLLER: 검색 list = " + perfList);
			logger.debug("@@@@@ CONTROLLER: 검색 결과 수 = " + service.getPerfCnt(search));
			pm.setTotalCount(service.getPerfCnt(search));
			
			logger.debug("@@@@@ CONTROLLER: 페이징정보 ====> " + pvo + ", " + pm);
			
			model.addAttribute("search", search);
			model.addAttribute("perfList", perfList);
			model.addAttribute("pm", pm);
			
		} 
		//검색 없을 때
		else {
			logger.debug("@@@@@ CONTROLLER: 목록 service 호출");
			
			// 서비스 - 생산실적목록
			perfList = service.getPerfList(pvo);
			
			//페이징정보 - 전체 수
			pm.setTotalCount(service.getPerfCnt());
			
			logger.debug("@@@@@ CONTROLLER: 페이징정보 ====> " + pvo + ", " + pm);
			
			model.addAttribute("perfList", perfList);
			model.addAttribute("pm", pm);
		}
		
		logger.debug("@@@@@ CONTROLLER: perfList = " + perfList);

		model.addAttribute("perfList", perfList);
	} // performanceList()

	// 작업지시, 라인, 품번 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String workOrderGET(Model model, @RequestParam("type") String type, @RequestParam("input") String input,
			PagingVO pvo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: workOrderGET() 호출");
		logger.debug("@@@@@ CONTROLLER: type = " + type);

		if(type.equals("work")) {
			String state = URLEncoder.encode("마감", "UTF-8");
			return "redirect:/workorder/workOrderList?input=" + input + "&search_state=" + state;
		}
		if(type.equals("line")) {
			return "redirect:/performance/line?input=" + input;
		}
		if(type.equals("prod")) {
			return "redirect:/performance/product?input=" + input;
		}
		return "";
	} // workOrderGET()

	// 생산실적 등록
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addPerformance(PerformanceVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: addPerformance() 호출");
		logger.debug("@@@@@ CONTROLLER: vo = " + vo);

		// 서비스 - 작업지시 등록
		service.regPerformance(vo);

		return "redirect:/performance/performList";
	} // addPerformance()

	// 생산실적 삭제
	@RequestMapping(value = "/deletePerform", method = RequestMethod.POST)
	public String deletePerformance(@RequestParam(value = "checked[]") List<String> checked) throws Exception {
		logger.debug("@@@@@ CONTROLLER: deletePerformance() 호출");
		logger.debug("@@@@@ CONTROLLER: checked = " + checked);

		// 서비스 - 작업지시 삭제
		service.removePerformance(checked);

		return "redirect:/performance/performList";

	} //deletePerformance()
	
	//생산실적 조회 POST
	@ResponseBody
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public PerformanceVO getPerformData(@RequestBody PerformanceVO vo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getPerformData() 호출");
		logger.debug("@@@@@ CONTROLLER: performCode = " + vo.getPerform_code());
		
		//서비스 - 생산관리 정보 가져오기
		PerformanceVO preVO = service.getPerformanceInfo(vo.getPerform_code());
		logger.debug("@@@@@ CONTROLLER: preVO = " + preVO);
		logger.debug("@@@@@ CONTROLLER: 실적일 =========> " + preVO.getPerform_date());
		
		return preVO;
	} //getPerformData()
	
	//생산실적 수정 
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPerformance(PerformanceVO uvo) throws Exception {
		logger.debug("@@@@@ CONTROLLER: modifyPerformance() 호출");
		logger.debug("@@@@@ CONTROLLER: uvo = " + uvo);
		
		//서비스 - 작업지시 수정
		service.modifyPerformance(uvo);
		
		return "redirect:/performance/performList";
	} //modifyPerformance()
	
	//생산실적 현황 - 양불수
	//http://localhost:8088/performance/performStatus
	@RequestMapping(value = "/performStatus", method = RequestMethod.GET)
	public void getPerformStatus(Model model) throws Exception {
		logger.debug("@@@@@ CONTROLLER: getPerformStatus() 호출");
		
		model.addAttribute("status", service.getPerformStatus());
		
	} //getPerformStatus()
	
	
	
	
	

}// PerfomanceController
