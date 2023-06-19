<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>발주 관리</h1>
    <form action="" name="ro">
	    <button value="0">발주 현황</button>
	    <button value="1">발주 등록</button>
    </form>
    
<%-- 	<c:if test="${param.ro == 0}"> --%>
	    
    <hr>
    <form action="">
	    발주 번호 <input type="text" placeholder="발주 번호를 입력하세요">
	   	품명 <input type="text" placeholder="품명을 입력하세요">
	   	거래처명 <input type="text" placeholder="거래처명을 입력하세요"> <br>
	   	발주 날짜 <input type="date" id="start_date" max=""> ~ <input type="date" id="end_date" max="2023-06-18">
	   	<button type="submit">검색</button>
    </form>
    
    <table border="1">
    <tr>
 		<th>발주 번호</th>
 		<th>거래처명</th>
 		<th>품번</th>
 		<th>품명</th>
 		<th>색상</th>
 		<th>발주 수량</th>
 		<th>재고 수량</th>
 		<th>단가</th>
 		<th>총액</th>
 		<th>발주일</th>
 		<th>담당자</th>

 	</tr>
        <c:forEach var="vo" items="${ro_List }">
            <tr>
                <td>${vo.raw_order_num}</td>
                <td>${vo.clients.client_actname}</td>
        		<td>${vo.rawMaterial.raw_code }</td>
        		<td>${vo.rawMaterial.raw_name }</td>
        		<td>${vo.rawMaterial.raw_color }</td>
                <td>${vo.raw_order_count}</td>
                <td>${vo.stock.stock_raw_count}</td>
        		<td><fmt:formatNumber value=" ${vo.rawMaterial.raw_price}"/>원</td>
        		<td><fmt:formatNumber value=" ${vo.rawMaterial.raw_price*vo.raw_order_count}"/>원</td>
                <td>${vo.raw_order_date}</td>
        		<td>${vo.emp_id }</td>
            </tr>
        </c:forEach>
    </table>
<%--     </c:if> --%>
    
    
    
    
</body>
</html>