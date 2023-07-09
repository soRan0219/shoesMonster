<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
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
				success : function(response){
					alert(obj.name + "의 재고 수량이 " + obj.stock_count + "개로 수정되었습니다.");
// 					location.reload();
					window.close();
					window.opener.location.reload();
				},
				error : function(){
					alert("올바른 수량을 입력해주세요.");
				}
			});
		});
		
	});
	
</script>
</head>
<body>

	<h1>재고 상세</h1>
	
<!-- 	<form action="" method="post"> -->
	<table border="1">
	 	<c:forEach var="s" items="${stockPopup}">
			<c:if test="${s.warehouse.wh_dv == '완제품'}">
				<tr>
			 		<th>유형</th>
			 		<th>제품 코드</th>
			 		<th>제품명</th>
			 		<th>색상</th>
			 		<th>사이즈</th>
			 		<th>재고 수량</th>
			 		<th>실제 수량</th>
			 		<th>창고 코드</th>
			 		<th>담당자</th>
			 	</tr>
				<tr>
					<th>${s.warehouse.wh_dv}</th>
					<td id="code">${s.prod_code}</td>
					<td id="name">${s.product.prod_name}</td>
					<td>${s.product.prod_color}</td>
					<td>${s.product.prod_size}</td>
					<td>${s.stock_count}</td>
					<td><input type="number" id="newCount" name="newCount" min="0"></td>
					<td>${s.wh_code}</td>
					<td>${s.warehouse.emp_id}</td>
				</tr>
			</c:if>
			<c:if test="${s.warehouse.wh_dv == '원자재'}">
				<tr>
			 		<th>유형</th>
			 		<th>제품 코드</th>
			 		<th>제품명</th>
			 		<th>색상</th>
			 		<th>재고 수량</th>
			 		<th>실제 수량</th>
			 		<th>창고 코드</th>
			 		<th>담당자</th>
			 	</tr>
				<tr>
					<th>${s.warehouse.wh_dv}</th>
					<td id="code">${s.raw_code}</td>
					<td id="name">${s.raw_mat.raw_name}</td>
					<td>${s.raw_mat.raw_color}</td>
					<td>${s.stock_count}</td>
					<td><input type="number" id="newCount" name="newCount" min="0"></td>
					<td>${s.wh_code}</td>
					<td>${s.warehouse.emp_id}</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	<hr>
<!-- 	실제 수량 <input type="number" id="newCount" name="newCount" min="0"> -->
<%-- 	<button type="submit" id="modify" name="code" value="${s.raw_code}">수정</button> --%>
	<input type="button" class="B B-info" value="수정" id="modify">
<!-- 	</form> -->
	
	
</body>
</html>