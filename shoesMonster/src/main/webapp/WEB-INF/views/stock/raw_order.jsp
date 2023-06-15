<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>발주 관리</h1>
	
	<button>발주 현황</button>
	<button>발주 등록</button>
	
	<hr>
	
	<table border="1">
	<tr>
		<th>발주 번호</th>
		<th>거래처명</th>
		<th>품번</th>
		<th>품명</th>
		<th>발주 수량</th>
		<th>재고 수량</th>
		<th>단가</th>
		<th>총액</th>
		<th>발주일</th>
		<th>담당자</th>
	</tr>
		<c:forEach var="vo" items="">
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</c:forEach>
	</table>
	
	
	
</body>
</html>