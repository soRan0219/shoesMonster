<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>입고 관리</h1>

	입고 번호 <input type="text" placeholder="입고 번호를 입력하세요.">
	거래처명 <input type="text"  placeholder="거래처명을 입력하세요.">
	품명 <input type="text"  placeholder="품명을 입력하세요.">
	입고 날짜 <input type="date">
	<button type="submit"></button>
	
	 
	<tr>
		<th>입고 번호</th>
		<th>거래처명</th>
		<th>품번</th>
		<th>품명</th>
		<th>발주 수량</th>
		<th>재고 수량</th>
		<th>단가</th>
		<th>총액</th>
		<th>입고일</th>
		<th>담당자</th>
		<th>입고 버튼</th>
	</tr>

	<c:forEach var="in" items="${in_material}">

		<tr>
			<td>${in.in_num }</td>
			<td>${in.client_code }</td>
			<td>${in. }</td>
			<td>${in. }</td>
			<td>${in. }</td>
			<td>${in. }</td>
			<td>${in. }</td>
			<td>${in. }</td>
			<td>${in. }</td>
			<td>${in. }</td>
			<td>${in.in_YN }</td>
		</tr>
	</c:forEach>

</body>
</html>