<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%@ include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script type="text/javascript">
	
</script>

<!-- page content -->
<div class="right_col" role="main">

	<h1> 출고 관리 </h1>
		
	<input type="button" value="전체" onclick="showAll()"></input>
    <input type="button" value="미출고" onclick="show1()"></input>
    <input type="button" value="출고완료" onclick="show2()"></input>
    


<script>
    function show1() {
        var table = document.getElementById("data-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var statusCell = row.cells[10];

            if (statusCell.innerText.trim() !== "미출고") {
                row.style.display = "none";
            } else {
                row.style.display = "";
            }
        }
    }
    
    function show2() {
        var table = document.getElementById("data-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var statusCell = row.cells[10];

            if (statusCell.innerText.trim() !== "출고완료") {
                row.style.display = "none";
            } else {
                row.style.display = "";
            }
        }
    }
    
    function showAll() {
        var table = document.getElementById("data-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            row.style.display = "";
        }
    }

</script>	
	<hr>
		
		
<!-- 		<label>출고 번호</label> -->
<!-- 			<input type="text" name="out_num" value="out_num" placeholder="검색어를 입력해주세요"> -->
		<form action="" method="get">
		<fieldset>
       		<label>출고번호:</label>
        	<input type="text" name="out_mat.out_num" value="">
        	<label>품명:</label>
        	<input type="text" name="prod_name" value="">
        	<label>거래처명:</label>
        	<input type="text" name="client.client_actname" value=""> 
        	<input type="submit" value="검색">
		</fieldset>
		</form>
		
<!-- 		<!-- 이것도 옵션으로 바꿀까 생각해보기 --> 
<!-- 		<label>품명</label> -->
<!-- 		<input type="text" name="prod_name" value="prod_name" placeholder="검색어를 입력해주세요"> -->



	<form action="/stock/Out_material" method="post">

	<table id="data-table" border="1">
		<tr>
			<th>출고 번호</th>
			<th>수주번호</th>
			<th>거래처명</th>
			<th>거래처 코드</th>
			<th>제품 코드</th>
			<th>제품 이름</th>
			<th>주문 수량</th>
			<th>납품가</th>
			<th>납품예정일</th>
			<th>출고 날짜</th>
			<th>출고 여부</th>
			<th>담당자</th>
			<th>출고 처리</th>
		</tr>
		<c:forEach var="out" items="${out_List }">
            <tr>
                <td>${out.out_num}</td>
                <td>${out.orders.order_code}</td>
                <td>${out.clients.client_actname}</td>
                <td>${out.orders.client_code}</td>
                <td>${out.prod.prod_code}</td>
                <td>${out.prod.prod_name}</td>
                <td>${out.orders.order_count}</td>
                <td>${out.prod.prod_price}원</td>
                <td>${out.orders.order_deliveryDate}</td>
                <td>${out.out_date}</td>
                <td>${out.out_YN}</td>
                <td>${out.emp_id}</td>
                </tr>
        </c:forEach>
	</table>
	</form>
	
	<c:if test="${count4 > 10 }">
		<c:if test="${bp.prev}">

		    <a href="/stock/Out_material?page=${bp.startPage - 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}">이전</a>

		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a href="/stock/Out_material?page=${idx}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}">${idx}</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">

		    <a href="/stock/Out_material?page=${bp.endPage + 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}">다음</a>

		</c:if>
	</c:if>
	<br><br>
    bp.startPage : ${bp.startPage } <br>
    bp.endPage : ${bp.endPage } <br>
    param : ${param } <br>
	
	
   
    
<!-- <div> -->
<%--     <c:if test="${count2 > 0 }"> --%>
<%--     	<c:if test="${startPage > pageBlock }"> --%>
<%--     		<span><a href="/stock/Out_material?num=${startPage - pageBlock}&client_actname=${out.client.client_actname} --%>
<%--     		&prod_name=${out.prod_name}&out_num=${out.out_mat.out_num}">이전</a></span> --%>
<%--     	</c:if> --%>
	
<%-- 		<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1"> --%>
<%-- 			<a href="/stock/Out_material?num=${i }&client_actname=${out.client.client_actname} --%>
<%--     		&prod_name=${out.prod_name}&out_num=${out.out_mat.out_num}">${i }</a> --%>
<%-- 		</c:forEach> --%>
		
<%-- 		<c:if test="${endPage < count2 }"> --%>
<%-- 			<a href="/stock/Out_material?num=${startPage + pageBlock}&client_actname=${out.client.client_actname} --%>
<%--     		&prod_name=${out.prod_name}&out_num=${out.out_mat.out_num}">다음</a> --%>
<%-- 		</c:if> --%>
<%--     </c:if> --%>
<!-- </div> -->


</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


