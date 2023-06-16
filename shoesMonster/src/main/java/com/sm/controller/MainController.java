package com.sm.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sm.domain.EmployeesVO;
import com.sm.service.EmployeesService;

@Controller
@RequestMapping(value = "/smmain/*")
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private EmployeesService eService;
	
	
	// http://localhost:8088/smmain/smLogin
	// 로그인
	@RequestMapping(value = "/smLogin", method = RequestMethod.GET)
	public void loginMainGET() {
		logger.debug(" loginGET() 호출@@@@@@ ");
		logger.debug(" 연결된 뷰 페이지로 이동 (/smmain/loginMain.jsp)@@@@@@ ");
		
	}
	// 로그인 - 정보 처리
	@RequestMapping(value = "/smLogin", method = RequestMethod.POST)
	public String loginMainPOST(EmployeesVO empvo, HttpSession session) {
		logger.debug(empvo+"");
		
		EmployeesVO resultVO = eService.empLogin(empvo);
		
		logger.debug(resultVO+"");
		
		if(resultVO != null) {
			session.setAttribute("id", resultVO);
			logger.debug(" 로그인 성공! ");
			return "redirect:/smmain/smMain.jsp";
		}else {
			logger.debug(" 로그인 실패! ");
			return "redirect:/smmain/smLogin.jsp";
		}
	}
	
}
