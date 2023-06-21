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

	<h1> 재고 관리 </h1>
	
	<hr>
	
	<form action="">
	        재고 번호 <input type="text" placeholder="발주 번호를 입력하세요">
	   	품명 <input type="text" placeholder="품명을 입력하세요">
	   	거래처명 <input type="text" placeholder="거래처명을 입력하세요"> 
	   	<button type="submit">검색</button>
    </form>
    
    
    	<hr>    
    	${count3 } , ${stockList }
        <hr>
    
    
    
    <table border="1">
    <tr>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 		<th>재고 번호</th>
 	</tr>
        <c:forEach var="s" items="${stockList }">
            <tr>
                <td>${s.stock_num}</td>
                <td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>
        		<td>${s.stock_num}</td>	
            </tr>
        </c:forEach>
    </table>
   
    
<div>
    <c:if test="${count3 > 0 }">
    	<c:if test="${startPage > pageBlock }">
    		<span><a href="/stock/stockList?num=${startPage - pageBlock}">이전</a></span>
    	</c:if>
	
		<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
			<a href="/stock/stockList?num=${i }">${i }</a>
		</c:forEach>
		
		<c:if test="${endPage < count3 }">
			<a href="/stock/stockList?num=${startPage + pageBlock}">다음</a>
		</c:if>
    </c:if>
</div>
	
</body>
</html>