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
		
		$("#roCancel").click(function() {
			
			var raw_order_num = $("#roCancel").val();
			
// 			alert("발주번호 : " + raw_order_num);
			var confirmResult = confirm(raw_order_num +" 발주를 취소하시겠습니까?");
			
			if (confirmResult) {
				$.ajax({
					url : "/stock/detailPopup",
					type: "POST",
					contentType : "application/json",
					data: JSON.stringify(raw_order_num),
					success : function(response){
						alert("발주가 정상적으로 취소되었습니다.");
						window.close();
						window.opener.location.reload();
					},
					error : function(){
						alert("실패실패");
					}
				});
			}
		});
		
	});
	
</script>
</head>
<body>
	<h1>발주 상세</h1>
	<table border="1">
		<tr>
			<th>발주 번호</th>
			<td>${raw_order_num }</td>
		</tr>
	</table>
	<br>
	<table border="1">
	    <tr>
	 		<th>거래처 코드</th>
	 		<th>거래처명</th>
	 		<th>거래처 담당자</th>
	 		<th>거래처 번호</th>
	 		<th>담당자 번호</th>
	 		<th>팩스 번호</th>
	    </tr>
	    <c:forEach var="ro" items="${ro_detail }">
			<tr>
		 		<td>${ro.clients.client_code }</td>
		 		<td>${ro.clients.client_actname }</td>
		 		<td>${ro.clients.client_name }</td>
		 		<td>${ro.clients.client_tel }</td>
		 		<td>${ro.clients.client_phone }</td>
		 		<td>${ro.clients.client_fax }</td>
		    </tr>
	    </c:forEach>
	</table>
	<hr>
	<button type="submit" id="roCancel" name="roCancel" value="${raw_order_num }">발주 취소</button>
	
</body>
</html>