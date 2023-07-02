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
        var whCode = row.cells[5].innerText;
        var stockCount = row.cells[6].innerText;
        var rawPrice = row.cells[7].innerText;
		
      	opener.document.getElementById("client_code").value = clientCode;
      	opener.document.getElementById("client_actname").value = clientName;
      	opener.document.getElementById("raw_code").value = rawCode;
      	opener.document.getElementById("raw_name").value = rawName;
      	opener.document.getElementById("raw_color").value = rawColor;
      	opener.document.getElementById("wh_code").value = whCode;
      	opener.document.getElementById("stock_count").value = stockCount;
      	opener.document.getElementById("raw_price").value = rawPrice;
        
		window.close();
	}
	
	</script>
</head>
<body>
	<h1>발주 정보</h1>
	
	<form action="" method="get">
		품명 <input type="text" name="rawMaterial.raw_name" placeholder="품명을 입력하세요">
		거래처명 <input type="text" name="clients.client_actname" placeholder="거래처명을 입력하세요"> 
		<input type="submit" value="검색"></input>
    </form>
	
	<table border="1">
		<tr>
			<th>거래처 코드</th>
			<th>거래처명</th>
			<th>품번</th>
			<th>품명</th>
			<th>색상</th>
			<th>입고 창고</th>
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
				<td>${ro.rawMaterial.wh_code }</td>
				<td style="color: ${ro.stock.stock_count <= 20 ? 'red' : 'inherit'}">${ro.stock.stock_count}</td>
				<td><fmt:formatNumber value=" ${ro.rawMaterial.raw_price }"/>원</td>
			</tr>
		</c:forEach>
	</table>
	
	<c:if test="${countPop > 10 }">
        <c:if test="${bp.prev}">
    
            <a href="/stock/roPopup?page=${bp.startPage - 1}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">이전</a>
    
        </c:if>
        
        <c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
            <a href="/stock/roPopup?page=${idx}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">${idx}</a>
        </c:forEach>
        
        <c:if test="${bp.next && bp.endPage > 0}">
    
            <a href="/stock/roPopup?page=${bp.endPage + 1}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">다음</a>
    
        </c:if>
    </c:if>

	
</body>
</html>