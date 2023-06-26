<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>슈몬 발주</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		
		function roPopup() {
			
			window.open("roPopup","거래처 목록","width=500, height=500, left=300, top=150 location=no");
		
		}
		
		function totalAmount() {
			var rawOrderCount = parseInt(document.getElementById("raw_order_count").value);
			var rawPrice = parseFloat(document.getElementById("raw_price").value);
			var totalAmount = rawOrderCount * rawPrice;
			var fmtAmount = totalAmount.toLocaleString() + "원";
		  	document.getElementById("total_amount").textContent = fmtAmount;
		}
		
	</script>
</head>
<body>

<script type="text/javascript">
	function toggleDiv(divId) {
	    var listDiv = document.getElementById("list");
	    var registDiv = document.getElementById("regist");
	    
	    if(divId === "list"){
	    	listDiv.style.display = "block";
	   		registDiv.style.display = "none";
	    } else if(divId === "regist"){
	    	listDiv.style.display = "none";
	   	 	registDiv.style.display = "block";
	    }
	    
	}

	window.onload = function() {
		var listDiv = document.getElementById("list");
		var registDiv = document.getElementById("regist");
	
		listDiv.style.display = "block";
		registDiv.style.display = "none";
				
	};
</script>

	
	<%
// 		String emp_id = (String)session.getAttribute("emp_id");
	
		// 나중에 주석 풀기
// 		if(emp_id == null) {
// 			response.sendRedirect("/smmain/smLogin"); // 로그인페이지로 이동
// 		}
	%>
	

    <div>
    <form action="" name="ro">
	    <input type="button" value="발주 현황" onclick="toggleDiv('list')"></input>
	    <input type="button"value="발주 등록" onclick="toggleDiv('regist')"></input>
    </form>
    </div>

    <hr>
    
    <!-- ============================ 발주 현황 ============================ -->
    <div id="list">
    
    <h1>발주 관리</h1>
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
   
    
	<div>
	    <c:if test="${count1 > 0 }">
	    	<c:if test="${startPage > pageBlock }">
	    		<span><a href="/stock/raw_order?num=${startPage - pageBlock}">이전</a></span>
	    	</c:if>
		
			<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
				<a href="/stock/raw_order?num=${i }">${i }</a>
			</c:forEach>
			
			<c:if test="${endPage < count1 }">
				<a href="/stock/raw_order?num=${startPage + pageBlock}">다음</a>
			</c:if>
	    </c:if>
	</div>
	
	</div>
	<!-- ============================ 발주 현황 ============================ -->
	
	<!-- ============================ 발주 등록 ============================ -->
	<div id="regist">
	
	<form role="form" method="post">
		<h1>발주 등록</h1>
		<c:set var="today" value="<%=new Date() %>" />
		
		<table border="1" id="table">
			<tr>
				<th>발주일</th>
				<th>거래처명</th>
				<th>품번</th>
				<th>품명</th>
				<th>색상</th>
				<th>발주 수량</th>
				<th>재고 수량</th>
				<th>단가</th>
				<th>총액</th>
				<th>담당자</th> <!-- 발주번호처럼 '발주 신청' 버튼 눌렀을 때 저장하기 -->
			</tr>
			<tr>
				<td><fmt:formatDate value="${today }" pattern="yyyy-MM-dd"/></td>
				<td onclick="roPopup();"><input type="text" name="client_actname" id="client_actname" readonly></td>
				<td onclick="roPopup();"><input type="text" name="raw_code" id="raw_code" readonly></td>
				<td onclick="roPopup();"><input type="text" name="raw_name" id="raw_name" readonly></td>
				<td onclick="roPopup();"><input type="text" name="raw_color" id="raw_color" readonly></td>
				<td><input type="number" min="1" id="raw_order_count" oninput="totalAmount()" required></td> <!-- CSS할 때 증감버튼 없애기 -->
				<td><input type="text" name="stock_raw_count" id="stock_raw_count" readonly></td>
				<td><input type="text" name="raw_price" id="raw_price" readonly></td>
				<td id="total_amount"></td>
				<td>${sessionScope.emp_id }</td>
			</tr>
		</table>
		
		<input type="submit" value="발주 신청">
	</form>
	
	
	
	얼마 : ${raw_price*raw_order_count} <br>
	로그인 아이디 : ${emp_id }
	
	</div>
	<!-- ============================ 발주 등록 ============================ -->

</body>
</html>