<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp"%>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script type="text/javascript">
	
	function roPopup() {
		
		window.open("roPopup","거래처 목록","width=500, height=500, left=300, top=150, location=no");
	}
	
	function detailPopup(rawCode) {
		
		window.open("detailPopup?rawCode=" + rawCode, "거래처 상세", "width=1000, height=500, left=200, top=150");
	}
	
	function totalAmount() {
		
		var roCount = parseInt(document.getElementById("raw_order_count").value);
		var rawPriceInput = document.getElementById("raw_price").value;
		var rawPrice = parseFloat(rawPriceInput.replace(/,/g, ""));
		
		var totalAmount = roCount * rawPrice;
		
		var fmtAmount = totalAmount.toLocaleString() + "원";
		
		document.getElementById("total_amount").textContent = fmtAmount;
	}
	
	function check() {
		if (document.getElementById("client_actname").value === "") {
			alert("발주 항목을 선택해주세요.");
			return false;
		} else if (document.getElementById("raw_order_count").value === "") {
			alert("발주 수량을 입력해주세요.");
			return false;
		}
	}
</script>

<!-- page content -->
<div class="right_col" role="main">




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
	    <input type="button" value="발주 등록" onclick="toggleDiv('regist')"></input>
    </form>
    </div>

    <hr>

    <form action="" method="get">
	    발주 번호 <input type="text" name="raw_order_num" placeholder="발주 번호를 입력하세요">
	   	품명 <input type="text" name="rawMaterial.raw_name" placeholder="품명을 입력하세요">
<!-- 	   		품명 <input type="text" name="raw_name" placeholder="품명을 입력하세요"> -->
	   	거래처명 <input type="text" name="clients.client_actname" placeholder="거래처명을 입력하세요"> 
<!-- 	   	발주 날짜 <input type="date" id="start_date" max=""> ~ <input type="date" id="end_date" max="2023-06-18"> -->
	   	<input type="submit" value="검색"></input>

    </form>
    
    <div id="list">
    
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
        		<td><input type="button" onclick="detailPopup('${vo.raw_code}')">${vo.raw_code }</td>
        		<td>${vo.rawMaterial.raw_name }</td>
        		<td>${vo.rawMaterial.raw_color }</td>
                <td>${vo.raw_order_count}</td>
	            <td>${vo.stock.stock_raw_count != null ? vo.stock.stock_raw_count : 0}</td>
        		<td><fmt:formatNumber value=" ${vo.rawMaterial.raw_price}"/>원</td>
        		<td><fmt:formatNumber value=" ${vo.rawMaterial.raw_price*vo.raw_order_count}"/>원</td>
                <td>${vo.raw_order_date}</td>
        		<td>${vo.emp_id }</td>
            </tr>
        </c:forEach>
    </table>
      ${param }/${param.clients.client_actname}/${rvo.clients.client_actname}
   		<c:if test="${count1 > 10 }">
			<c:if test="${bp.prev}">
			    <a href="/stock/raw_order?page=${bp.startPage - 1}&raw_order_num=${param.raw_order_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">이전</a>
			</c:if>
			
			<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
			    <a href="/stock/raw_order?page=${idx}&raw_order_num=${param.raw_order_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">${idx}</a>
			</c:forEach>
			
			<c:if test="${bp.next && bp.endPage > 0}">
			    <a href="/stock/raw_order?page=${bp.endPage + 1}&raw_order_num=${param.raw_order_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">다음</a>
			</c:if>
		</c:if>
		<br><br>
    bp.startPage : ${bp.startPage } <br>
    bp.endPage : ${bp.endPage } <br>
	param.raw_order_num : ${param.raw_order_num} <br>
	param.raw_name : ${param.rawMaterial.raw_name} <br>
	param.client_actname : ${clients.client_actname} <br><br>
	
	
	</div>
	
	<!-- ============================ 발주 현황 ============================ -->
	
	<!-- ============================ 발주 등록 ============================ -->
	<div id="regist">
	
	<h1>발주 등록</h1>
	<form action="" method="post" onsubmit="return check()">
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
				<td><input type="text" name="raw_order_date" value="<fmt:formatDate value="${today }" pattern="yyyy-MM-dd"/>" readonly></td>
				<td onclick="roPopup();"><input type="text" name="client_actname" id="client_actname" required readonly></td>
				<td onclick="roPopup();"><input type="text" name="raw_code" id="raw_code" readonly></td>
				<td onclick="roPopup();"><input type="text" name="raw_name" id="raw_name" readonly></td>
				<td><input type="text" name="raw_color" id="raw_color" readonly></td>
				<td><input type="number" min="1" id="raw_order_count" name="raw_order_count" oninput="totalAmount()"></td> <!-- CSS할 때 증감버튼 없애기 -->
				<td><input type="text" name="stock_raw_count" id="stock_raw_count" readonly></td>
				<td><input type="text" name="raw_price" id="raw_price" readonly></td>
				<td id="total_amount"></td>
				<td>${sessionScope.emp_id }</td>
			</tr>
		</table>
		
		<input type="submit" value="발주 신청">
	</form>
	
	로그인 아이디 : ${emp_id } <!-- 로그인 확인 후 삭제하기 -->
	</div>
<!-- ============================ 발주 등록 ============================ -->
	
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


