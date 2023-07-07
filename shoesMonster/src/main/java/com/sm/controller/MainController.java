package com.sm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.EmployeesVO;
import com.sm.service.EmployeesService;

@Controller
@RequestMapping(value = "/smmain/*")
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private EmployeesService empService;
	
	
	// http://localhost:8088/smmain/smLogin
	// 로그인
	@RequestMapping(value = "/smLogin", method = RequestMethod.GET)
	public void smLoginGET() {
		logger.debug(" loginGET() 호출@@@@@@ ");
		logger.debug(" 연결된 뷰 페이지로 이동 (/smmain/loginMain.jsp)@@@@@@ ");
	}
	
	// 로그인 - 정보 처리
	@RequestMapping(value = "/smLogin", method = RequestMethod.POST)
	public String smLoginPOST(EmployeesVO empvo, String id, String pw, HttpSession session, Model model) {
		logger.debug(id+"", pw+"");
		logger.debug(empvo+"");
		
		EmployeesVO resultVO = empService.empLogin(empvo);
		
		logger.debug(resultVO+"");
		
		if(resultVO != null) {
			session.setAttribute("id", resultVO);
			model.addAttribute(resultVO);
			logger.debug(" 로그인 성공! ");
			return "redirect:/smmain/smMain";
		}else {
			logger.debug(" 로그인 실패! ");
			return "redirect:/smmain/smLogin";
		}
	}
	
	// http://localhost:8088/smmain/smMain
	// 메인페이지
	@RequestMapping(value = "/smMain", method = RequestMethod.GET)
	public String mainGET(HttpSession session) {
		logger.debug(" mainGET() 호출@@@@@ ");
		
	    EmployeesVO resultVO = (EmployeesVO) session.getAttribute("id");
	    
	    if (resultVO == null) {
	        logger.debug("id 정보가 없습니다. 메인 화면으로 이동하지 않습니다.");
	        return "redirect:/smmain/smLogin#signin";
	    }
	    else {
	    	logger.debug("/smmain/smMain.jsp 페이지 이동");
	    	return "/smmain/smMain";
	    }
	}
	
	// 로그아웃 세션제어
	@RequestMapping(value = "/smLogout", method = RequestMethod.GET)
	public String smLogoutGET(HttpServletRequest request, HttpServletResponse response) {
		logger.debug(" smLogoutGET(호출)@@@@@ ");
		
		 request.getSession().invalidate();
		 
		 return "redirect:/smmain/smLogin#signin";
	}
	
}
