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

	<h1>수주 관리</h1>
	<div>
		업체 <input type="text">
		수주 일자 <input type="text">
		<input type="button" value="조회">
	<br>
		담당자 <input type="text">
		납품 예정일 <input type="text">
	</div>
	
	<div>
		수주관리
		<table border="1" id="">
			<tr>
				<th></th>
				<th>수주업체코드</th>
				<th>수주업체명</th>
				<th>수주일자</th>
				<th>납품예정일</th>
				<th>담당자코드</th>
				<th>담당자</th>
			</tr>

			<c:forEach var="vo" items="${orderManageList }" varStatus="i">
				<tr>
					<td>${i.count }</td>
					<td>${vo.clients.client_code}</td>
					<td>${vo.clients.client_actname}</td>
					<td>${vo.order_date}</td>
					<td>${vo.order_deliveryDate}</td>
					<td>${vo.employees.emp_id}</td>
					<td>${vo.employees.emp_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>