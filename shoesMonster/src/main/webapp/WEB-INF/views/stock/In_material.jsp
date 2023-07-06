<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>

<!-- page content -->
<div class="right_col" role="main">

	<h1>입고 관리</h1>


	<input type="button" value="전체" class="btn btn-info" onclick="showAll()"></input> <input
		type="button" value="미입고" class="btn btn-info" onclick="show1()"></input> 
		
		<input type="button"
		value="입고완료" class="btn btn-info" onclick="show2()" ></input>

	<script>
		function show1() {
			var table = document.getElementById("data-table");
			var rows = table.getElementsByTagName("tr");

			for (var i = 1; i < rows.length; i++) {
				var row = rows[i];
				var statusCell = row.cells[13];

				if (statusCell.innerText.trim() !== "미입고") {
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
				var statusCell = row.cells[13];

				if (statusCell.innerText.trim() !== "입고완료") {
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

	<!-- 	입고 번호 <input type="text" valeu="in_num" placeholder="입고 번호를 입력하세요."> -->
	<!-- 	거래처명 <input type="text"  valeu="clien_name" placeholder="거래처명을 입력하세요."> -->
	<!-- 	품명 <input type="text" valeu="raw_name" placeholder="품명을 입력하세요."> -->
	<!-- 	입고 날짜 <input type="date"> ~ <input type="date"> -->
	<!-- 	<button type="submit">검색</button> -->


<!-- //////////////////////////////////////////////////////////////////////// -->
<!-- page content -->
	
	<h2 style="margin-left: 1%;">재고관리</h2>

<div style="margin-left: 1%;">

	<form action="" method="get">

		<label>품명</label> <input type="text" name="rawMaterial.raw_name" placeholder="품명을 입력해주세요">
		<label>입고 번호</label> <input type="text" name="in_mat.in_num" placeholder="입고 번호를 입력해주세요">
		<label>거래처명</label> <input type="text" name="clients.client_actname" placeholder="거래처명을 입력해주세요">
		<input type="submit" class="btn btn-info" value="검색">

	</form>
</div>

	<hr>

	<!--//////////////////////////////////////////// 테이블 템플릿 ////////////////////////////////////////////////////// -->

	<div class="col-md-12 col-sm-12  ">
		<div class="x_panel">
			<div class="x_title">
				<h2>입고 목록</h2>
					<span style="float: right; margin-top: 1%;">총 ${count1} 건</span>
					<div class="clearfix"></div>
				</div>
<!-- //////////////////////////////////////////////////////////////////////// -->	
	<div style="overflow-x: auto;">		
		<form action="" method="post">
			<table class="table table-striped jambo_table bulk_action" style="text-align:center;" id="data-table">
			<colgroup>
			    <col style="width: 100px">
			    <col style="width: 100px">
			    <col style="width: 100px">
			    <col style="width: 130px">
			    <col style="width: 100px">
			    <col style="width: 130px">
			    <col style="width: 100px">
			    <col style="width: 100px">
			    <col style="width: 100px">
			    <col style="width: 100px">
			    <col style="width: 130px">
			    <col style="width: 100px">
			    <col style="width: 100px">
			    <col style="width: 100px">
			    <col style="width: 130px">
			</colgroup>			
						
			<thead>
				<tr class="headings">
					<th>입고 번호</th>
					<th>발주 번호</th>
					<th>입고 창고</th>
					<th>거래처명</th>
					<th>품번</th>
					<th>품명</th>
					<th>색상</th>
					<th>발주 수량</th>
					<th>재고 수량</th>
					<th>단가</th>
					<th>총액</th>
					<th>입고일</th>
					<th>담당자</th>
					<th>입고 확인</th>
					<th>입고 버튼</th>
				</tr>
			</thead>
			
			<c:forEach var="rvo" items="${ro_List }">
				<tr>
					<td>${rvo.in_mat.in_num }</td>
					<td>${rvo.raw_order_num }</td>
					<td>${rvo.rawMaterial.wh_code }</td>
					<td>${rvo.clients.client_actname }</td>
					<td>${rvo.raw_code }</td>
					<td>${rvo.rawMaterial.raw_name }</td>
					<td>${rvo.rawMaterial.raw_color }</td>
					<td>${rvo.raw_order_count}</td>
					<td>${rvo.stock.stock_count != null ? rvo.stock.stock_count : 0}</td>
					<td ><fmt:formatNumber
							value=" ${rvo.rawMaterial.raw_price}" />원</td>
					<td><fmt:formatNumber
							value=" ${rvo.rawMaterial.raw_price*rvo.raw_order_count}" />원</td>
					<td>${rvo.in_mat.in_date }</td>
					<td>${rvo.emp_id }</td>
					<td>${rvo.in_mat.in_YN eq null ? '미입고' : rvo.in_mat.in_YN}</td>

					<td>
					<c:if test="${rvo.in_mat.in_num == null}">
						<button type="submit" name="in_Button" value="${rvo.raw_order_num},${rvo.raw_code},${rvo.raw_order_count},${rvo.rawMaterial.wh_code }">입고 처리</button>
					</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	</form>
</div>
</div>
<!-- //////////////////////////////////////////////////////////////////////// -->	
<div>
			<c:if test="${count1 > 10 }">
				<c:if test="${bp.prev}">
					<span><a class="btn btn-secondary"
						href="/stock/In_material?page=${bp.startPage -1}&in_mat.in_num=${rvo.in_mat.in_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">이전</a></span>
				</c:if>

				<c:forEach var="i" begin="${bp.startPage}" end="${bp.endPage}"
					step="1">
					<a class="btn btn-secondary"
						href="/stock/In_material?page=${i }&in_mat.in_num=${rvo.in_mat.in_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">${i }</a>
				</c:forEach>

				<c:if test="${bp.next && bp.endPage > 0}">
					<a class="btn btn-secondary"
						href="/stock/In_material?page=${bp.endPage + 1}&in_mat.in_num=${rvo.in_mat.in_num}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">다음</a>
				</c:if>
			</c:if>
		</div>

	</div>



	<!--//////////////////////////////////////////// 테이블 템플릿 ////////////////////////////////////////////////////// -->




</div>










<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


