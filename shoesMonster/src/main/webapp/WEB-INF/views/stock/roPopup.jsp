<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 정보</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
	<script type="text/javascript">
	
	function select(row) {
		
		var clientCode = row.cells[0].innerText;
		var clientName = row.cells[1].innerText;
		var rawCode = row.cells[2].innerText;
        var rawName = row.cells[3].innerText;
        var rawColor = row.cells[4].innerText;
        var stockCount = row.cells[5].innerText;
        var rawPrice = row.cells[6].innerText;
		
      	opener.document.getElementById("client_code").value = clientCode;
      	opener.document.getElementById("client_actname").value = clientName;
      	opener.document.getElementById("raw_code").value = rawCode;
      	opener.document.getElementById("raw_name").value = rawName;
      	opener.document.getElementById("raw_color").value = rawColor;
      	opener.document.getElementById("stock_count").value = stockCount;
      	opener.document.getElementById("raw_price").value = rawPrice;
        
		window.close();
	}
	
	</script>
</head>
<body>
	<h1>발주 정보</h1>
	
<!-- 	<form method="get"> -->
	<table border="1">
		<tr>
			<th>거래처 코드</th>
			<th>거래처명</th>
			<th>품번</th>
			<th>품명</th>
			<th>색상</th>
			<th>재고 수량</th>
			<th>단가</th>
		</tr>
		<c:forEach var="ro" items="${roPopup }">
			<tr onclick = "select(this);">
				<td>${ro.rawMaterial.client_code }</td>
				<td>${ro.clients.client_actname }</td>
				<td>${ro.rawMaterial.raw_code }</td>
				<td>${ro.rawMaterial.raw_name }</td>
				<td>${ro.rawMaterial.raw_color }</td>
				<td style="color: ${ro.stock.stock_count <= 20 ? 'red' : 'inherit'}">${ro.stock.stock_count}</td>
				<td><fmt:formatNumber value=" ${ro.rawMaterial.raw_price }"/>원</td>
			</tr>
		</c:forEach>
	</table>
<!-- 	</form> -->
	
	
</body>
</html>