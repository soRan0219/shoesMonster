<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 템플릿 -->
<link href="../resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../resources/build/css/custom.min.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/smmain/smMain" />
</c:if>

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
	background-color: #F7F7F7;
	padding: 0px;
	margin: 0px;
}



</style>
<!-- 폰트 -->

<script type="text/javascript">

$(document).ready(function() {
	  // 수정 버튼 클릭 시
	  $('#modifyEmp').click(function() {
		$(this).prop('disabled', true);
	    // 첫 번째 테이블 처리
	    $('#empImg').append("<br><br><input type='file' name = 'file' accept='image/*'>");
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
	  
	  //==================모달==================================
		  
	  
	});

</script>

<style>
.table-wrapper {
    overflow-x: auto; /* 테이블 직접 조절 */
    overflow-y: hidden;
}
.table-wrapper table {
    width: 100%; /* 테이블 직접 조절 */
    white-space: nowrap; 
    text-align: center;
}
.input-fielda {
    cursor: pointer;
    display: inline-block;
    text-align-last: center;
}
.input-fieldb {
    display: inline-block;
    text-align-last: center;
}
</style>

</head>
<body>

<div class="right_col" role="main">
	
<div class="col-md-12 col-sm-12" style="margin-top: 5%;">
	<div class="x_panel">
		<div class="x_title">

	
	<div style="margin: 1% 1%;">
		<h1>상세보기</h1>
			<div style="float: right;">
			<br>
			<button id="modifyEmp" class="B B-info">수정</button>
			<button type="reset" id="cancelEmp" class="B B-info">취소</button>
			<button type="submit" id="saveEmp" class="B B-info">저장</button>
			
			<!-- 버튼 제어 -->
				<script>
					//권한 설정
					var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
					if (team === "인사팀" || team === "관리자") {
					    document.getElementById("modifyEmp").disabled = false;
					    document.getElementById("cancelEmp").disabled = false;
					    document.getElementById("saveEmp").disabled = false;
					} else {
					    document.getElementById("modifyEmp").hidden = true;
					    document.getElementById("cancelEmp").hidden = true;
					    document.getElementById("saveEmp").hidden = true;
					}
				</script>
			<!-- 버튼 제어 -->
			
		</div>
	<div class="x_content">
		<div class="table-responsive">
			<div class="table-wrapper" >
			<form id="fr" action="/person/modifyEmp" method="post" enctype="multipart/form-data">
			<div id="empImg" style="border: 1px solid; width: 300px; height: 230px;">
				<c:if test="${!empty id.file }">
								<img src="/imgDown?fileName=${vo.file }" alt="..." width="380px" height="220px"
								class="img-circle profile_img">
							</c:if>
							
							<c:if test="${empty vo.file }">
								<img src="../resources/images/person.png" alt="..." width="270px" height="200px"
								class="img-circle profile_img">
							</c:if>
			</div><br><br>
				<table border="1" id="empTable" style="width: 100%; text-align-last: center; margin-bottom: 1%;">
					<tr style="background-color:#2A3F54; color:#E7E7E7;">
						<th>사원번호</th> 
						<th>비밀번호</th>
						<th>이름</th>
						<th>부서</th>
						<th>직책</th>
						<th>이메일</th>
					</tr>
					<tr style="color:#212529 ">
						<td>${vo.emp_id}</td>
						<td>${vo.emp_pw}</td>
						<td>${vo.emp_name}</td>
						<td>${vo.emp_department}</td>
						<td>${vo.emp_position}</td>
						<td>${vo.emp_email}</td>
					</tr>
					</table>
					<table border="1" style="width: 100%; text-align-last: center; margin-bottom: 1%;" id="empTable2">
					<tr style="background-color:#2A3F54; color:#E7E7E7;">
						<th>입사일자</th>
						<th>재직구분</th>
						<th>내선번호</th>
						<th>연락처</th>
						<th>생년월일</th>
						<th>성별</th>
					</tr>
					<tr style="color:#212529 ">
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
	</div>
	</div>
	</div>
	</div>
	
</div>


	
	
</body>
</html>