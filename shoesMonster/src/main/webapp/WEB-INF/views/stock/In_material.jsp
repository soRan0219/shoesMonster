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
	
<!-- 	입고 번호 <input type="text" valeu="in_num" placeholder="입고 번호를 입력하세요."> -->
<!-- 	거래처명 <input type="text"  valeu="clien_name" placeholder="거래처명을 입력하세요."> -->
<!-- 	품명 <input type="text" valeu="raw_name" placeholder="품명을 입력하세요."> -->
<!-- 	입고 날짜 <input type="date"> ~ <input type="date"> -->
<!-- 	<button type="submit">검색</button> -->

<form action="" method="get">
		
		<label>사원코드</label>
			<input type="text" name="client_code"  placeholder="검색어를 입력해주세요">
		
		
		<label>입고번호</label>
		<input type="text"  name="in_num" placeholder="검색어를 입력해주세요">
		
		<!-- 이것도 옵션으로 바꿀까 생각해보기 -->
		<label>발주번호</label>
		<input type="text"  name="raw_order_num" placeholder="검색어를 입력해주세요">
			
		<input type="submit" id="searchButton" value="검색">
	</form>




	<hr>
	
 <table border="1">
	<tr>
		<th>사원코드</th>
		<th>입고번호</th>
		<th>발주번호</th>
		<th>사원코드</th>
		<th>입고번호</th>
		<th>발주번호</th>
		<th>사원코드</th>
		<th>입고번호</th>
		<th>발주번호</th>
		<th>사원코드</th>
		<th>입고번호</th>
		<th>입고 버튼</th>
	</tr>

	<c:forEach var="in" items="${In_materialList }">

		<tr>
			<td>${in.client_code }</td>
			<td>${in.in_num }</td>
			<td>${in.raw_order_num }</td>
			<td>${in.client_code }</td>
			<td>${in.in_num }</td>
			<td>${in.raw_order_num }</td>
			<td>${in.client_code }</td>
			<td>${in.in_num }</td>
			<td>${in.raw_order_num }</td>
			<td>${in.client_code }</td>
			<td>${in.in_num }</td>
			<td><button type="submit">미입고</button></td>
		</tr>
	</c:forEach>
</table>

<div>
    <c:if test="${count > 0 }">
        <c:if test="${startPage > pageBlock }">
            <span><a href="/stock/In_material?num=${startPage - pageBlock}">이전</a></span>
        </c:if>
    
        <c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
            <a href="/stock/In_material?num=${i }">${i }</a>
        </c:forEach>
        
        <c:if test="${endPage < count }">
            <a href="/stock/In_material?num=${startPage + pageBlock}">다음</a>
        </c:if>
    </c:if>
    
</div>

</body>
</html>