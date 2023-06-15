package com.sm.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	//http://localhost:8088/smmain/loginMain
	
	// 로그인
	@RequestMapping(value = "/loginMain", method = RequestMethod.GET)
	public void loginMainGET() {
		logger.debug(" loginGET() 호출@@@@@@ ");
		logger.debug(" 연결된 뷰 페이지로 이동 (/smmain/loginMain.jsp)@@@@@@ ");
		
	}
	
}
