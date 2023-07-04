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
		


  <!-- ///////////////////////////////////////////////목록 템플릿  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ -->
    
    <div class="col-md-12 col-sm-12  ">
		<div class="x_panel">
			<div class="x_title">
				<h2>
					출고 목록 <small>Out_material</small>
				</h2>
				<ul class="nav navbar-right panel_toolbox">
					<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
					</li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false"><i
							class="fa fa-wrench"></i></a>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							<a class="dropdown-item" href="#">Settings 1</a> <a
								class="dropdown-item" href="#">Settings 2</a>
						</div></li>
					<li><a class="close-link"><i class="fa fa-close"></i></a></li>
				</ul>
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<p>
					출고 테이블
					<code>Shoes Monseter</code>
					since 2023
				</p>
				<div class="table-responsive">
					<form action="" method="post">
						<table class="table table-striped jambo_table bulk_action" id="data-table">
							<thead>
								<tr class="headings">
									<th>
										<div class="icheckbox_flat-green" style="position: relative;">
											<input type="checkbox" id="check-all" class="flat"
												style="position: absolute; opacity: 0;">
											<ins class="iCheck-helper"
												style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
										</div>
									</th>
									<th class="column-title">출고 번호</th>
									<th class="column-title">수주번호</th>
									<th class="column-title">거래처명</th>
									<th class="column-title">거래처코드</th>
									<th class="column-title">제품 코드</th>
									<th class="column-title">제품 이름</th>
									<th class="column-title">주문 수량</th>
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
										<td class="a-center ">
											<div class="icheckbox_flat-green" style="position: relative;">
												<input type="checkbox" class="flat" name="table_records"
													style="position: absolute; opacity: 0;">
												<ins class="iCheck-helper"
													style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
											</div>
										</td>
										<td class=" ">${out.out_num}</td>
										<td class=" ">${out.orders.order_code}</td>
										<td class=" ">${out.clients.client_actname}</td>
										<td class=" ">${out.orders.client_code}</td>
										<td class=" ">${out.prod.prod_code}</td>
										<td class=" ">${out.prod.prod_name}</td>
										<td class=" ">${out.orders.order_count}</td>
										<td class=" ">${out.prod.prod_price}원</td>
										<td class=" ">${out.orders.order_deliveryDate}</td>
										<td class=" ">$${out.out_date}<i
											class="success fa fa-long-arrow-up"></i></td>
										<td class=" ">${out.out_YN}</td>
										<td class=" ">${out.emp_id}</td>
										<td class=" "><button type="submit">출고 처리</button></td>
									</tr>

								</c:forEach>
							</tbody>
						</table>
					</form>

				</div>
			</div>
		</div>
		<div>
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
		</div>

	</div>
    
    
    <!-- //////////////////////////////////목록 템플릿  /////////////////////////////////////// -->





	
	<br><br>
    bp.startPage : ${bp.startPage } <br>
    bp.endPage : ${bp.endPage } <br>
    param : ${param } <br>
	
	
   
    
<!-- <div> -->

<!-- </div> -->


</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


