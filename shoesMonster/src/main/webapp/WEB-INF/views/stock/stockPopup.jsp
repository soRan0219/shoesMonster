<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<link rel="icon" href="../resources/images/favicon-32x32.png">

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="../resources/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<!-- bootstrap-progressbar -->
<link
	href="../resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<!-- Custom Theme Style -->
<link href="../resources/build/css/custom.min.css" rel="stylesheet">

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
	background-color: #fff;
}
</style>
<!-- 폰트 -->

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#modify").click(function() {
			
			var obj = {
					stock_count : $("#newCount").val(),
					code : $("#code").text(),
					name : $("#name").text()
				};
			
			$.ajax({
				url : "/stock/stockPopup",
				type: "POST",
				contentType : "application/json",
				data: JSON.stringify(obj),
				success : function(){
// 					alert(obj.name + "의 재고 수량이 " + obj.stock_count + "개로 수정되었습니다.");
// 					location.reload();
// 					window.close();
// 					window.opener.location.reload();
					
					Swal.fire({
						title : "<div style='color:#495057;font-size:15px;font-weight:lighter'>"+obj.name + "의 재고 수량이 \n " 
																						+ obj.stock_count +" 개로 수정되었습니다",
						
						icon : 'success',
						width: '250px',

						}).then((result) => {
							if (result.isConfirmed) {
								location.reload();
								window.close();
								window.opener.location.reload();
							}
						});

					},
				error : function(){
// 					alert("올바른 수량을 입력해주세요.");
					Swal.fire({
						title : "<div style='color:#495057;font-size:15 px;font-weight:lighter'>"+ "올바른 수량을 입력해주세요",
						icon : 'question',
						width: '250px',
						});
				}//error
				
			});//ajax
			
		});// #modify.click
		
	});// document.ready
	
	
	
	
</script>
</head>
<body>
	
	<!-- 여기까지 삭제 -->
<div class="x_panel" style="margin-bottom: -1%;">

	<h1 style="margin-left: 1%;">재고 상세</h1>

<!-- 	<form action="" method="post"> -->
	
	<div class="table-responsive">
	<table class="table table-striped jambo_table bulk_action" id="data-table" style="text-align:center;">
	 	<c:forEach var="s" items="${stockPopup}">
			<c:if test="${s.warehouse.wh_dv == '완제품'}">
			<thead>
				<tr class="headings">
			 		<th class="column-title">유형</th>
			 		<th class="column-title">제품 코드</th>
			 		<th class="column-title">제품명</th>
			 		<th class="column-title">색상</th>
			 		<th class="column-title">사이즈</th>
			 		<th class="column-title">재고 수량</th>
			 		<th class="column-title">실제 수량</th>
			 		<th class="column-title">창고 코드</th>
			 		<th class="column-title">담당자</th>
			 	</tr>
			</thead>
			<tbody>
				<tr>
					<td class=" ">${s.warehouse.wh_dv}</td>
					<td id="code" class=" ">${s.prod_code}</td>
					<td id="name" class=" ">${s.product.prod_name}</td>
					<td class=" ">${s.product.prod_color}</td>
					<td class=" ">${s.product.prod_size}</td>
					<td class=" ">${s.stock_count}</td>
					<td class=" "><input type="number" id="newCount" name="newCount" min="0"></td>
					<td class=" ">${s.wh_code}</td>
					<td class=" ">${s.warehouse.emp_id}</td>
				</tr>
			</c:if>
			<c:if test="${s.warehouse.wh_dv == '원자재'}">
				<thead>
				<tr class="headings">
			 		<th class="column-title">유형</th>
			 		<th class="column-title">제품 코드</th>
			 		<th class="column-title">제품명</th>
			 		<th class="column-title">색상</th>
			 		<th class="column-title">재고 수량</th>
			 		<th class="column-title">실제 수량</th>
			 		<th class="column-title">창고 코드</th>
			 		<th class="column-title">담당자</th>
			 	</tr>
			 	</thead>
			 	<tbody>
				<tr class="headings">
					<td class=" ">${s.warehouse.wh_dv}</td>
					<td id="code" class=" ">${s.raw_code}</td>
					<td id="name" class=" ">${s.raw_mat.raw_name}</td>
					<td class=" ">${s.raw_mat.raw_color}</td>
					<td class=" ">${s.stock_count}</td>
					<td class=" "><input type="number" id="newCount" name="newCount" min="0"></td>
					<td class=" ">${s.wh_code}</td>
					<td class=" ">${s.warehouse.emp_id}</td>
				</tr>
				</tbody>
			</c:if>
		</c:forEach>
		</table>


<!-- 	실제 수량 <input type="number" id="newCount" name="newCount" min="0"> -->
<%-- 	<button type="submit" id="modify" name="code" value="${s.raw_code}">수정</button> --%>
	<input type="button" class="B B-info" value="수정" id="modify">
<!-- 	</form> -->
<br>
	</div>
</div>
	
</body>
</html>