<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 목록</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
	<script type="text/javascript">
	
	function select(row) {
		
		var wh_code = row.cells[0].innerText;
      	opener.document.getElementById("wh_code").value = wh_code;
        
		window.close();
	}
	
	</script>
</head>
<body>
	<h1>창고 목록</h1>
	
	<table border="1">
		<tr>
			<th>창고 코드</th>
			<th>창고 유형</th>
		</tr>
		<c:forEach var="wh" items="${whPopup}">
			<tr onclick = "select(this);">
				<td>${wh.warehouse.wh_code }</td>
				<td>${wh.warehouse.wh_dv }</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>