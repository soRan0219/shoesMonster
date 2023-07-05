<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
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
      	opener.document.getElementById("raw_price").value = rawPrice;
        
		window.close();
	}
	
	</script>
</head>
<body>
	<h1>발주 정보</h1>
	<small>총 ${countPop}건</small>
	<form action="" method="get">
		품명 <input type="text" name="rawMaterial.raw_name" placeholder="품명을 입력하세요">
		거래처명 <input type="text" name="clients.client_actname" placeholder="거래처명을 입력하세요"> 
		<input type="submit" value="검색"></input>
    </form>
	
	<!-- ////////////////////////////////////////////////////////////////////////////////////// -->
	<div class="col-md-12 col-sm-12  ">
		<div class="x_panel">
			<div class="x_title">
				<h2>
					발주 정보 목록 <small>총 ${countPop}건</small>
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
				<div class="table-responsive">
					<form action="" method="post">
						<table class="table table-striped jambo_table bulk_action"
							id="data-table">
							<thead>
								<tr class="headings">
									
									<th class="column-title">거래처 코드</th>
									<th class="column-title">거래처명</th>
									<th class="column-title">품번</th>
									<th class="column-title">품명</th>
									<th class="column-title">색상</th>
									<th class="column-title">입고창고</th>
									<th class="column-title">재고 수량</th>
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
										<td class=" " style="color: ${ro.stock.stock_count <= 20 ? 'red' : 'inherit'}" >${ro.stock.stock_count}</td>
										<td class=" " ><fmt:formatNumber value=" ${ro.rawMaterial.raw_price }"/>원</td>
										
									</tr>

								</c:forEach>
							</tbody>
						</table>
					</form>

				</div>
			</div>
		</div>
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

	
</body>
</html>