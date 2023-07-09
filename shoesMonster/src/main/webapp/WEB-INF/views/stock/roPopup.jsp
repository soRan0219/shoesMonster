<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<link href="../resources/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../resources/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../resources/vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../resources/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

<!-- bootstrap-progressbar -->
<link
	href="../resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css"
	rel="stylesheet">
<!-- JQVMap -->
<link href="../resources/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet" />
<!-- bootstrap-daterangepicker -->
<link href="../resources/vendors/bootstrap-daterangepicker/daterangepicker.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../resources/build/css/custom.min.css" rel="stylesheet">

<meta charset="UTF-8">
<title>발주 정보</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
	background-color: #fff;
}
</style>
<!-- 폰트 -->

<script type="text/javascript">
	
	function select(row) {
		
		var clientCode = row.cells[0].innerText;
		var clientName = row.cells[1].innerText;
		var rawCode = row.cells[2].innerText;
        var rawName = row.cells[3].innerText;
        var rawColor = row.cells[4].innerText;
        var whCode = row.cells[5].innerText;
        var stockCount = row.cells[6].innerText;
        var rawPrice = row.cells[7].innerText;
		
      	opener.document.getElementById("client_code").value = clientCode;
      	opener.document.getElementById("client_actname").value = clientName;
      	opener.document.getElementById("raw_code").value = rawCode;
      	opener.document.getElementById("raw_name").value = rawName;
      	opener.document.getElementById("raw_color").value = rawColor;
      	opener.document.getElementById("wh_code").value = whCode;
      	opener.document.getElementById("stock_count").value = stockCount;
      	opener.document.getElementById("stock_count").style.color = parseInt(stockCount) <= 50 ? 'red' : 'inherit';
      	opener.document.getElementById("raw_price").value = rawPrice;
        
		window.close();
	}
	
	</script>
</head>
<div class="x_panel" style="margin-bottom: -1%;">

	<h1 style="margin-left: 1%;">발주 정보</h1>
	
	<div style="margin-left: 1%;">
		<form action="" method="get">
			품명 <input type="text" name="rawMaterial.raw_name" placeholder="품명을 입력하세요."> &nbsp;
			거래처명 <input type="text" name="clients.client_actname" placeholder="거래처명을 입력하세요."> &nbsp;
			<input type="submit" class="B B-info" value="검색"></input> &nbsp; &nbsp;
	    </form>
	</div>   
	 
	<div class="x_title">
		<h2 style="width: 110px;"> 발주 정보 목록 </h2>
		
		<span style="float:left; margin-top: 0.5%;">총 ${countPop}건</span>
		<div class="clearfix"></div>
	</div>
			
	<div class="table-responsive">
		<form action="" method="post">
			<table class="table table-striped jambo_table bulk_action" id="data-table" style="text-align:center;">
			<thead>
				<tr class="headings">
					<th class="column-title">거래처 코드</th>
					<th class="column-title">거래처명</th>
					<th class="column-title">품번</th>
					<th class="column-title">품명</th>
					<th class="column-title">색상</th>
					<th class="column-title">입고창고</th>
					<th class="column-title">재고수량</th>
					<th class="column-title">단가</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="ro" items="${roPopup }">
					<tr class="even pointer" onclick="select(this);">
						<td class=" ">${ro.rawMaterial.client_code }</td>
						<td class=" ">${ro.clients.client_actname }</td>
						<td class=" ">${ro.rawMaterial.raw_code }</td>
						<td class=" ">${ro.rawMaterial.raw_name }</td>
						<td class=" ">${ro.rawMaterial.raw_color }</td>
						<td class=" ">${ro.rawMaterial.wh_code }</td>
						<td class=" " style="color: ${ro.stock.stock_count <= 50 ? 'red' : 'inherit'}" >${ro.stock.stock_count}</td>
						<td class=" " ><fmt:formatNumber value=" ${ro.rawMaterial.raw_price }"/>원</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
		</form>
		
	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
            <c:if test="${countPop > 0 }">
			<li class="paginate_button previous disabled">
                <c:if test="${bp.prev}">
                    <span><a href="/stock/roPopup?page=${bp.startPage -1}&rawMaterial.raw_name=${ro.rawMaterial.raw_name}}&clients.client_actname=${ro.clients.client_actname}">이전</a></span>
                </c:if>
            </li>
			<li class="paginate_button previous disabled">
                <c:forEach var="i" begin="${bp.startPage}" end="${bp.endPage}"
                    step="1">
                    <a href="/stock/roPopup?page=${i }&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">${i }</a>
                </c:forEach>
           </li>
           <li class="paginate_button previous disabled">
                <c:if test="${bp.next && bp.endPage > 0}">
                    <a href="/stock/roPopup?page=${bp.endPage + 1}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">다음</a>
                </c:if>
            </li>
            </c:if>
        </ul>
    </div>
		
	</div>
</div>
		
