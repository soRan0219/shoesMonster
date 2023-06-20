<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>수주 현황</h1>
	
	업체 <input type="text">
	수주 일자 <input type="text">
	품번 <input type="text">
	<input type="button" value="조회">
	<br>
	담당자 <input type="text">
	납품 예정일 <input type="text">
	출하완료여부 
	<select>
		<option>Y</option>
		<option>N</option>
	</select>
	
	
	<table border="1" id="">
		<tr>
			<th></th>
			<th>수주번호</th>
			<th>업체</th>
			<th>수주일자</th>
			<th>담당자</th>
			<th>품번</th>
			<th>품명</th>
			<th>단위</th>
			<th>납품예정일</th>
			<th>수주량</th>
			<th>완료여부</th>
		</tr>
		
		<c:forEach var="vo" items="${orderStatusList }" varStatus="i">
			<tr>
				<td>${i.count }</td>
				<td>${vo.order_code}"</td>
				<td>${vo.client_code}</td>
				<td>${vo.order_date}</td>
				<td>${vo.emp_id}</td>
				<td>${vo.prod_code}</td>
				<td>${vo.prod_name}</td>
				<td>${vo.prod_unit}</td>
				<td>${vo.order_deliveryDate}</td>
				<td>${vo.order_count}</td>
				<td>${vo.order_finish}</td>
			</tr>
		</c:forEach>
		
	</table>
	
</body>
</html>