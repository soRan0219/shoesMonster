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
	public String smLoginPOST(EmployeesVO empvo, String id, String pw, HttpSession session) {
		logger.debug(id+"", pw+"");
		logger.debug(empvo+"");
		
		EmployeesVO resultVO = empService.empLogin(empvo);
		
		logger.debug(resultVO+"");
		
		if(resultVO != null) {
			session.setAttribute("id", resultVO);
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
	public void mainGET() {
		logger.debug(" mainGET() 호출@@@@@ ");
		logger.debug("/smmain/smMain.jsp 페이지 이동");
	}
	
}
