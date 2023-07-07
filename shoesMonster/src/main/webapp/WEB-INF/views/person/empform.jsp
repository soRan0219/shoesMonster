<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->

<script type="text/javascript">

$(document).ready(function() {
	  // 수정 버튼 클릭 시
	  $('#modifyEmp').click(function() {
		$(this).prop('disabled', true);
	    // 첫 번째 테이블 처리
	    $('#empImg').append("<input type='file' name = 'file' accept='image/*'>");
	    $('#empTable tr').each(function(rowIndex) {
	      var $cells = $(this).find('td'); // 현재 행의 셀들을 선택
	      
	      $cells.each(function(index) {
	        var cellData = $(this).text(); // 셀의 내용을 가져옴
	        var inputHTML = ''; // 생성할 <input> 태그의 HTML
	        
	        // 종류에 따라 <input> 태그 생성 및 값 설정
	        switch (index) {
	          case 0:
	            inputHTML = '<input type="text" name="emp_id" value="' + cellData + '">';
	            break;
	          case 1:
	            inputHTML = '<input type="text" name="emp_pw" value="' + cellData + '">';
	            break;
	          case 2:
	            inputHTML = '<input type="text" name="emp_name" value="' + cellData + '">';
	            break;
	          case 3:
	            inputHTML = '<input type="text" name="emp_department" value="' + cellData + '">';
	            break;
	          case 4:
	            inputHTML = '<input type="text" name="emp_position" value="' + cellData + '">';
	            break;
	          case 5:
	            inputHTML = '<input type="email" name="emp_email" value="' + cellData + '">';
	            break;
	        }
	        
	        $(this).empty().append(inputHTML); // 현재 셀의 내용을 지우고 <input> 태그로 대체
	      });
	    });
	    
	    // 두 번째 테이블 처리
	    $('#empTable2 tr').each(function(rowIndex) {
	      var $cells = $(this).find('td'); // 현재 행의 셀들을 선택
	      
	      $cells.each(function(index) {
	        var cellData = $(this).text(); // 셀의 내용을 가져옴
	        var inputHTML = ''; // 생성할 <input> 태그의 HTML
	        
	        // 종류에 따라 <input> 태그 생성 및 값 설정
	        switch (index) {
	          case 0:
	            inputHTML = '<input type="text" name="emp_hiredate" value="' + cellData + '">';
	            break;
	          case 1:
	            inputHTML = '<input type="text" name="emp_work" value="' + cellData + '">';
	            break;
	          case 2:
	            inputHTML = '<input type="text" name="emp_tel" value="' + cellData + '">';
	            break;
	          case 3:
	            inputHTML = '<input type="text" name="emp_phone" value="' + cellData + '">';
	            break;
	          case 4:
	            inputHTML = '<input type="text" name="emp_birth" value="' + cellData + '">';
	            break;
	          case 5:
	            inputHTML = '<input type="text" name="emp_gender" value="' + cellData + '">';
	            break;
	        }
	        
	        $(this).empty().append(inputHTML); // 현재 셀의 내용을 지우고 <input> 태그로 대체
	      });
	    });
	  });
	  
	  $('#cancelEmp').click(function() {
		 $('#fr')[0].reset();
	  });
	  
	  $('#saveEmp').click(function() {
		$('#fr').submit();

	  });//save
	  
	});

</script>
</head>
<body>
	<div class="right_col" role="main">
	<div style="margin: 5% 12% 0% 12%;">
		<div style="text-align-last: right;">
			<button id="modifyEmp">수정</button>
			<button type="reset" id="cancelEmp">취소</button>
			<button type="submit" id="saveEmp">저장</button>
			<button onclick="location.href='/person/empform?emp_id=${vo.emp_id}'">새로고침</button>
		</div>
		<div>
			<h1>상세보기</h1>
			<form id="fr" action="/person/modifyEmp" method="post" enctype="multipart/form-data">
			<div id="empImg" style="border: 1px solid; width: 300px; height: 230px;">
				<img alt="" src="/imgDown?fileName=${vo.file }" width="300px" height="200px">
			</div>
			
				<table border="1" style="width: 100%" id="empTable">
					<tr>
						<th>사원번호</th> 
						<th>비밀번호</th>
						<th>이름</th>
						<th>부서</th>
						<th>직책</th>
						<th>이메일</th>
					</tr>
					<tr>
						<td>${vo.emp_id}</td>
						<td>${vo.emp_pw}</td>
						<td>${vo.emp_name}</td>
						<td>${vo.emp_department}</td>
						<td>${vo.emp_position}</td>
						<td>${vo.emp_email}</td>
					</tr>
					</table>
					<table border="1" style="width: 100%" id="empTable2">
					<tr>
						<th>입사일자</th>
						<th>재직구분</th>
						<th>내선번호</th>
						<th>연락처</th>
						<th>생년월일</th>
						<th>성별</th>
					</tr>
					<tr>
						<td id="emp_hiredate">${vo.emp_hiredate}</td>
						<td id="emp_work">${vo.emp_work}</td>
						<td id="emp_tel">${vo.emp_tel}</td>
						<td id="emp_phone">${vo.emp_phone}</td>
						<td id="emp_birth">${vo.emp_birth}</td>
						<td id="emp_gender">${vo.emp_gender}</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
	
	
</body>
</html>