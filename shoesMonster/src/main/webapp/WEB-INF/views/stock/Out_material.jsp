<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="javax.servlet.http.HttpSession" %>
    
<%@ include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/smmain/smMain" />
</c:if>

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->

<script type="text/javascript">
	function checkStock(orderCount, stockCount) {
	    if (orderCount > stockCount) {
	        alert("재고 수량이 부족합니다. 물량을 확인해 주세요.");
	        return false;
	    } 
	}
</script>
	
<!-- page content -->
<div class="right_col" role="main">
	
	<h1 style="margin-left: 1%;"> 출고 관리 </h1>
	
	
	<!-- 버튼 제어 -->	
	<div style="margin-left: 1%;">
<!--		<input type="button" value="전체" class="B B-info" onclick="showAll()"></input> -->
<!--	    <input type="button" value="미출고" class="B B-info" onclick="show1()" id="noMat"></input> -->
<!--	    <input type="button" value="출고완료" class="B B-info" onclick="show2()" id="yesMat"></input> -->
	</div>
	
	<script>
	    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
	
	    if (team === "물류팀" || team === "관리자") {
	        document.getElementById("noMat").disabled = false;
	        document.getElementById("yesMat").disabled = false;
	    } else {
	        document.getElementById("noMat").hidden = true;
	        document.getElementById("yesMat").hidden = true;
	    }
	</script>
	<!-- 버튼 제어 -->
	
	
	
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

		<form method="get" style="margin-left: 1%;">
		<fieldset>
			<button type="submit" value="" class="B B-info" name="orders.out_YN">전체</button>
	        <input type="submit" value="미출고" class="B B-info" name="orders.out_YN" ></input> 
	        <input type="submit" value="출고완료" class="B B-info" name="orders.out_YN" ></input> 
		
       		<label>출고 번호:</label>
        	<input type="text" name="out_num" value="" placeholder="출고 번호를 입력하세요.">
        	<label>품명:</label>
        	<input type="text" name="prod.prod_name" value="" placeholder="품명을 입력하세요.">
        	<label>거래처명:</label>
        	<input type="text" name="clients.client_actname" value="" placeholder="거래처명을 입력하세요."> 
        	<input type="submit" class="btn btn-info" value="검색">
		</fieldset>
		</form>

  <!-- ///////////////////////////////////////////////목록 템플릿  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ -->
    
    <div class="col-md-12 col-sm-12  ">
		<div class="x_panel">
			<div class="x_title">
				<h2>
					출고 목록 <small>총 ${count4}건</small>
				</h2>
				
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<div class="table-responsive">
					<form action="" method="post">
						<table class="table table-striped jambo_table bulk_action" id="data-table">
							<thead>
								<tr class="headings">
									<th class="column-title">출고 번호</th>
									<th class="column-title">수주번호</th>
									<th class="column-title">거래처명</th>
									<th class="column-title">거래처코드</th>
									<th class="column-title">제품 코드</th>
									<th class="column-title">제품 이름</th>
									<th class="column-title">주문 수량</th>
									<th class="column-title">재고 수량</th>
									<th class="column-title">납품가</th>
									<th class="column-title">납품예정일</th>
									<th class="column-title">출고 날짜</th>
									<th class="column-title">출고 여부</th>
									<th class="column-title">담당자</th>
									<th class="column-title">출고 처리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="out" items="${out_List }">
									<tr class="even pointer">
										<td class=" ">${out.out_num}</td>
										<td class=" ">${out.orders.order_code}</td>
										<td class=" ">${out.clients.client_actname}</td>
										<td class=" ">${out.orders.client_code}</td>
										<td class=" ">${out.prod.prod_code}</td>
										<td class=" ">${out.prod.prod_name}</td>
										<td class=" ">${out.orders.order_count}</td>
										<td class=" " style="color: ${out.stock.stock_count <= 20 ? 'red' : 'inherit'}">${out.stock.stock_count}</td>
										<td class=" "><fmt:formatNumber value=" ${out.prod.prod_price}" />원</td>
										<td class=" ">${out.orders.order_deliveryDate}</td>
										<td class=" ">${out.out_date}</td>
										<td class=" ">${out.orders.out_YN}</td>
										<td class=" ">${out.o_emp_id}</td>
										<td class=" ">
											<c:if test = "${sessionScope.id.emp_department eq '물류팀' or sessionScope.id.emp_department eq '관리자'}">
												<c:if test="${out.out_num == null}">
													<button type="submit" name="out_Button" value="${out.orders.order_code},${out.orders.order_count},${out.prod.prod_code}" class="B B-info" id="matYN" onclick="return checkStock(${out.orders.order_count}, ${out.stock.stock_count})">출고 처리</button>
												</c:if>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
      
// ============    
      
 <div>
           <c:if test="${count4 > 10 }">
        <c:if test="${bp.prev}">

            <a class="btn btn-secondary" href="/stock/Out_material?page=${bp.startPage - 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}&orders.out_YN=${rvo.orders.out_YN}">이전</a>

        </c:if>
        
        <c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
            <a class="btn btn-secondary" href="/stock/Out_material?page=${idx}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}&orders.out_YN=${rvo.orders.out_YN}">${idx}</a>
        </c:forEach>
        
        <c:if test="${bp.next && bp.endPage > 0}">

            <a class="btn btn-secondary" href="/stock/Out_material?page=${bp.endPage + 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}&orders.out_YN=${rvo.orders.out_YN}">다음</a>

        </c:if>
        </c:if>
        </div>     
      
      
// ============  
		
	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
      
		   	<c:if test="${count4 > 10 }">
			<li class="paginate_button previous disabled">
				<c:if test="${bp.prev}">
				    <a href="/stock/Out_material?page=${bp.startPage - 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}">Previous</a>
				</c:if>
			</li>
			<li class="paginate_button previous disabled">
				<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
				    <a href="/stock/Out_material?page=${idx}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}">${idx}</a>
				</c:forEach>
			</li>
			<li class="paginate_button previous disabled">
				<c:if test="${bp.next && bp.endPage > 0}">
				    <a href="/stock/Out_material?page=${bp.endPage + 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}">Next</a>
				</c:if>
			</li>
			</c:if>
		</ul>
	</div>
	
</div>
    
    
    <!-- //////////////////////////////////목록 템플릿  /////////////////////////////////////// -->

   
    
<!-- <div> -->

<!-- </div> -->


<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


