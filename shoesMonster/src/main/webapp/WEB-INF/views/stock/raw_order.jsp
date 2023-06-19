<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>발주 관리</h1>
    
    <button>발주 현황</button>
    <button>발주 등록</button>
    
    <hr>
    
    <table border="1">
    <tr>
        <th>발주 번호</th>
        <th>거래처명</th>
        <th>품번</th>
        <th>품명</th>
        <th>발주 수량</th>
        <th>재고 수량</th>
        <th>단가</th>
        <th>총액</th>
        <th>발주일</th>
        <th>담당자</th>
        <th>담당자</th>
    </tr>
        <c:forEach var="vo" items="${ro_List }">
            <tr>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
                <td>${vo.raw_code}</td>
            </tr>
        </c:forEach>
    </table>
    
    <div>
<c:if test="${prev}">
 <span>[ <a href="/stock/raw_order?num=${startPageNum - 1}">이전</a> ] 
</c:if>

<c:forEach begin="${startPageNum}" end="${endPageNum}" var="num">
 <span>
 
  <c:if test="${select != num}">
   <a href="/stock/raw_order?num=${num}">${num}</a>
  </c:if>    
  
  <c:if test="${select == num}">
   <b>${num}</b>
  </c:if>
    
  
</c:forEach>

<c:if test="${next}">
 <span>[ <a href="/stock/raw_order?num=${endPageNum + 1}">다음</a> ] 
</c:if>
</div>
    
</body>
</html>