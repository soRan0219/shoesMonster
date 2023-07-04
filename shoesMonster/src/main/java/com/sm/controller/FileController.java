package com.sm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sm.service.EmployeesService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
	@Autowired
	private EmployeesService service;
	
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	public String fileUploadGET(MultipartHttpServletRequest multi, Model model,
								@RequestParam("emp_id") String emp_id) throws Exception { 
		
		logger.debug(" fileUploadGET() 호출 ");
		// 전달된 정보 저장
		logger.debug(multi + "");
		
		// 인코딩
		multi.setCharacterEncoding("UTF-8");
		
		// 다중 파일정보 저장(Map)
		// 1. 파라메터 저장 2. 파일정보 저장
		Map map = new HashMap();
		
		// 전달하는 파라메터정보를 저장
		Enumeration enu = multi.getParameterNames();
		
		while(enu.hasMoreElements()){
			String name = (String)enu.nextElement();
			String value = multi.getParameter(name);
			// logger.debug("name : " + name+", value : " + value);
			map.put(name, value);
		}
		
		logger.debug("전달된 파라메터 정보(이름, 값) 저장완료(파일정보 제외)");
		
		logger.debug("map : " + map);
		
		// 파일정보(파라메터) + 파일업로드 처리
		List fileList = fileProcess(multi,emp_id);
		
		map.put("fileList", fileList);
		
		logger.debug("map : " + map);
		
		model.addAttribute("map",map);
		
		// 결과 뷰페이지로 이동
		return "redirect:/person/empform?emp_id="+emp_id;
	} // fileUploadGET()
	
	
	public List<String> fileProcess(MultipartHttpServletRequest multi, String emp_id) throws Exception {
		logger.debug("파일정보 저장 + 파일업로드 ");
		
		// 1) 파일의 정보(파라메터)
		List<String> fileList = new ArrayList<String>();
		
		Iterator<String> fileNames = multi.getFileNames();
		
		while(fileNames.hasNext()) {
			// 파일의 정보를 전달하는 input태그 이름(파라메터명)
			String fileName = fileNames.next();
			logger.debug("fileName : " + fileName);
			MultipartFile mFile = multi.getFile(fileName);
			
			String oFileName = mFile.getOriginalFilename();
			logger.debug("fileName(파일명)" + oFileName);
			
			// 파일의 정보를 저장
			fileList.add(oFileName);
			
			service.updateEmployeesImg(oFileName,emp_id);
			
			
			// 2) 파일업로드
			File file = new File("C:\\spring\\upload"+"\\"+fileName);
			
			if (mFile.getSize() != 0) {
				// 폼태그에서 업로드한 파일의 정보가 있을 때
				
				if (!file.exists()) { // 업로드 폴더에 파일이 없을 때
					
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					} // file.getParentFile().mkdirs()
					
				} //!file.exists()

				// 업로드에 필요한 임시 파일정보를 실제 업로드 위치로 이동
				mFile.transferTo(new File("C:\\spring\\upload"+"\\"+oFileName));
				
			} // mFile.getSize() != 0
			
		} // wile문
		
		logger.debug("파일정보 저장, 파일업로드 완료");
		
		return fileList;
	} // fileProcess()
	
	// http://localhost:8088/fileDown?fileName=파일명
	@RequestMapping(value = "/fileDown", method = RequestMethod.GET)
	public void fileDownloadGET(@RequestParam("fileName") String fileName,
								HttpServletResponse response) throws Exception {
		logger.debug(" fileDownloadGET() 호출 ");
		
		// 전달정보 저장
		logger.debug("fileName : " + fileName);
		
		// 업로드 폴더에서 다운로드 파일의 정보를 가져오기
		File downFile = new File("C:\\spring\\upload"+"\\"+fileName);
		
		// 응답정보를 통한 출력스트림객체 준비
		OutputStream out = response.getOutputStream();
		
		// 모든파일의 형태가 다운로드창을 수행
		
		fileName = URLEncoder.encode(fileName,"UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		
		// 파일 다운로드(전송)
		FileInputStream fis = new FileInputStream(downFile);
		
		byte[] buffer = new byte[1024*8];
		int data =0;
		while((data = fis.read(buffer)) != -1) {
			// => 파일의 끝(-1) 까지 반복
			out.write(buffer, 0, data);
		}
		
		out.flush(); // 버퍼의 빈공간을 채우기
		
		out.close();
		fis.close();
		
		logger.debug(" 파일 다운로드 완료! ");
		
		
	} // fileDownloadGET()
	
	@RequestMapping(value = "/imgDown", method = RequestMethod.GET)
	public void imgDownloadGET(@RequestParam("fileName") String fileName,
								HttpServletResponse response) throws Exception {
		logger.debug(" imgDownloadGET() 호출 ");
		
		// 전달정보 저장
		logger.debug("fileName : " + fileName);
		
		// 업로드 폴더에서 다운로드 파일의 정보를 가져오기
		File downFile = new File("C:\\spring\\upload"+"\\"+fileName);
		
		// 응답정보를 통한 출력스트림객체 준비
		OutputStream out = response.getOutputStream();
		
		// 이미지 파일의 경우는 원본파일(고화질) 직접 표시(피효율적인 처리)
		// => 썸네일 구현
		
		String imgName = fileName.substring(0, fileName.lastIndexOf("."));
		File thumbnail = new File("C:\\spring\\upload"+"\\"+imgName+".png");
		
		if (downFile.exists()) {
			thumbnail.getParentFile().mkdirs();
			
			// 썸네일 파일 생성
			Thumbnails.of(downFile)
					.size(50, 50)
					.outputFormat("png")
					.toFile(thumbnail);
			
			
			// 썸네일 정보 바로 출력
//			Thumbnails.of(downFile)
//			.size(50, 50)
//			.outputFormat("png")
//			.toOutputStream(out);
		}
		
		// 모든파일의 형태가 다운로드창으로 수행
//		fileName = URLEncoder.encode(fileName,"UTF-8");
//		response.setHeader("Cache-Control", "no-cache");
//		response.addHeader("Content-disposition", "attachment; fileName="+fileName);

		// 파일 다운로드(전송)
		FileInputStream fis = new FileInputStream(downFile);
		
		byte[] buffer = new byte[1024*8];
		int data =0;
		while((data = fis.read(buffer)) != -1) {
			// => 파일의 끝(-1) 까지 반복
			out.write(buffer, 0, data);
		}
		
		out.flush(); // 버퍼의 빈공간을 채우기
		
		out.close();
		fis.close();
		
		logger.debug(" 파일 다운로드 완료! ");
		
		
	} // imgDownloadGET()
	
	
	
	
	
} // controller
























