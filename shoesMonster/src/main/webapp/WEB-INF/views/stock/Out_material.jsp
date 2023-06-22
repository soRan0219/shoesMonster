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
		<h1> 출고 관리 </h1>
		
		 <table border="1">
    <tr>
 		<th>출고 번호</th>
 		<th>거래처명</th>
 		<th>품번</th>
 		<th>품병</th>
 		<th>주문 수량</th>
 		<th>재고 수량</th>
 		<th>단가</th>
 		<th>총액</th>
 		<th>출고일</th>
 		<th>담당자</th>
 		<th>출고 번호</th>
 		
 	</tr>
        <c:forEach var="out" items="${out_matList }">
            <tr>
                <td>${out.out_num}</td>
                <td>${out.client.client_actname}</td>
                <td>${out.product.prod_code}</td>
                <td>${out.product.prod_name}</td>
                <td>${out.orders.order_count}</td>
                <td>${out.out_count}</td>
                <td>${out.product.prod_price}원</td>
                <td>${out.product.prod_price*out.orders.order_count}원</td>
                <td>${out.out_date}</td>
                <td>${out.emp.emp_name}</td>
                <td>${out.out_YN}</td>
                
            </tr>
        </c:forEach>
    </table>
   
    
<div>
    <c:if test="${count2 > 0 }">
    	<c:if test="${startPage > pageBlock }">
    		<span><a href="/stock/Out_material?num=${startPage - pageBlock}">이전</a></span>
    	</c:if>
	
		<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
			<a href="/stock/Out_material?num=${i }">${i }</a>
		</c:forEach>
		
		<c:if test="${endPage < count2 }">
			<a href="/stock/Out_material?num=${startPage + pageBlock}">다음</a>
		</c:if>
    </c:if>
</div>
</body>
</html>