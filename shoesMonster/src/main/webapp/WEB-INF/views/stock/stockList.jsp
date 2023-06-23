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
	
	<div>
	        재고 번호 <input type="text"  placeholder="발주 번호를 입력하세요">
	   	품명 <input type="text" placeholder="품명을 입력하세요">
	   	거래처명 <input type="text" placeholder="거래처명을 입력하세요"> 
	   	<button type="submit">검색</button>
    </div>
    
    
    
    
    
    
    <table border="1">
    <tr>
 		<th>창고 이름</th>
 		<th>제품 상태</th>
 		<th>제품 코드</th>
 		<th>제품 이름</th>
 		<th>창고 이름</th>
 		<th>창고 주소</th>
 		<th>창고 코드</th>
 		
 	</tr>
        <c:forEach var="s" items="${stockList }">
        
        <c:if test="${s.wh_dv  == '완제품'}">
            <tr>
                <td>${s.wh_name}</td>
                <td>${s.wh_dv}</td>
                <td>${s.product.prod_code}</td>
        		<td>${s.product.prod_name}</td>
        		<td>${s.wh_name}</td>
        		<td>${s.wh_addr}</td>
        		<td>${s.wh_code}</td>
            </tr>
            </c:if>
            
            <c:if test="${s.wh_dv  == '원자재'}">
            <tr>
                <td>${s.wh_name}</td>
                <td>${s.wh_dv}</td>
                <td>${s.raw_mat.raw_code}</td>
        		<td>${s.raw_mat.raw_name}</td>
        		<td>${s.wh_name}</td>
        		<td>${s.wh_addr}</td>
        		<td>${s.wh_code}</td>
            </tr>
            </c:if>
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