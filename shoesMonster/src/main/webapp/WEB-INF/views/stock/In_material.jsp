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

	<button type="submit">전체</button>
	<button type="submit">미입고</button>
	<button type="submit">입고 완료</button>
	
	<hr>

	입고 번호 <input type="text" placeholder="입고 번호를 입력하세요.">
	거래처명 <input type="text"  placeholder="거래처명을 입력하세요.">
	품명 <input type="text"  placeholder="품명을 입력하세요.">
	입고 날짜 <input type="date"> ~ <input type="date">
	<button type="submit">검색</button>
	
	<hr>
	
 <table border="1">
	<tr>
		<th>입고 번호</th>
		<th>거래처명</th>
		<th>상세보기</th>
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

	<c:forEach var="in" items="${In_materialList }">

		<tr>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td>${in.client_code }</td>
			<td><button type="submit">미입고</button></td>
		</tr>
	</c:forEach>
</table>

<c:if test="${prev}">
 <span>[ <a href="/stock/In_material?num=${startPageNum - 1}">이전</a> ] 
</c:if>

<c:forEach begin="${startPageNum}" end="${endPageNum}" var="num">
 <span>
 
  <c:if test="${select != num}">
   <a href="/stock/In_material?num=${num}">${num}</a>
  </c:if>    
  
  <c:if test="${select == num}">
   <b>${num}</b>
  </c:if>
    
 </span>
</c:forEach>

<c:if test="${next}">
 <span>[ <a href="/stock/In_material?num=${endPageNum + 1}">다음</a> ] 
</c:if>

</body>
</html>