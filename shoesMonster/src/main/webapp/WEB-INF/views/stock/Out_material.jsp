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
		
		<form action="" method="POST">
		<label>출고 번호</label>
			<input type="text" name="out_num"  placeholder="검색어를 입력해주세요">
		
		
		<label>거래처명</label>
		<input type="text" name="client_actname" placeholder="검색어를 입력해주세요">
		
		<!-- 이것도 옵션으로 바꿀까 생각해보기 -->
		<label>품명</label>
		<input type="text" name="prod_name" placeholder="검색어를 입력해주세요">
			

		<input type="submit" value="검색">
		
		</form>
		
		
		 <table border="1">
    <tr>
 		<th>출고 번호</th>
 		<th>수주번호</th>
 		<th>납품예정일</th>
 		<th>거래처 코드</th>
 		<th>거래처 명</th>
 		<th>담당자 명</th>
 		<th>제품 코드</th>
 		<th>제품 이름</th>
 		<th>제품 가격</th>
 		<th>출고 날짜</th>
 		<th>출고 여부</th>
 		<th>주문 갯수</th>
 		<th>주문 여부</th>
 		
 	</tr>
        <c:forEach var="out" items="${out_matList }">
            <tr>
                <td>${out.out_mat.out_num}</td>
                <td>${out.orders.order_code}</td>
                <td>${out.orders.order_deliveryDate}</td>
                <td>${out.orders.client_code}</td>
                <td>${out.client.client_actname}</td>
                <td>${out.orders.emp_id}</td>
                <td>${out.prod_code}</td>
                <td>${out.prod_name}</td>
                <td>${out.prod_price}원</td>
                <td>${out.out_mat.out_date}</td>
                <td>${out.out_mat.out_YN}</td>
                <td>${out.orders.order_count}</td>
                <td>${out.orders.order_finish}</td>
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