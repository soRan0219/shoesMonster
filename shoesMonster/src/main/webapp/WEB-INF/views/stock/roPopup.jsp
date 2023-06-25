<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
	<script type="text/javascript">
	
	function select(row) {
		alert("dddd");
// 		window.opener.result();
// 		var table = window.opener.getElementById("table");
		var table = document.getElementById("table");
		var newRow = table.insertRow(-1);
		window.close();
	}
	
	
	</script>
</head>
<body>
	<h1>발주 정보</h1>
	
	<form method="get">
	<table border="1">
		<tr>
			<th>거래처명</th>
			<th>품번</th>
			<th>품명</th>
			<th>재고 수량</th>
			<th>단가</th>
		</tr>
		<c:forEach var="ro" items="${roPopup }">
			<tr onclick = "select();">
				<td>${ro.clients.client_actname }</td>
				<td>${ro.rawMaterial.raw_code }</td>
				<td>${ro.rawMaterial.raw_name }</td>
				<td>${ro.stock.stock_raw_count }</td>
				<td><fmt:formatNumber value=" ${ro.rawMaterial.raw_price }"/>원</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	
	
</body>
</html>