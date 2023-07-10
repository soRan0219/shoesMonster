<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

.table-wrapper {
    overflow-x: auto; /* 테이블 직접 조절 */
    overflow-y: hidden;
}
.table-wrapper table {
    width: 100%; /* 테이블 직접 조절 */
    white-space: nowrap; 
    text-align: center;
}
.input-fielda {
    cursor: pointer;
    display: inline-block;
    text-align-last: center;
}
.input-fieldb {
    display: inline-block;
    text-align-last: center;
}

</style>
<!-- 폰트 -->

<script type="text/javascript">
	
	function stockPopup(code) {
		window.open("stockPopup?code=" + code, "재고 상세", "width=800, height=320, left=200, top=150, location=no");
	}
	
</script>

<div class="right_col" role="main">

	<h1 style="margin-left: 1%;"> 재고 관리 </h1>
	<div style="margin: 1% 1%">
	<hr>
		<form action="" method="get">
	 		원자재 코드 <input type="text" name="raw_code" placeholder="원자재 코드를 입력하세요."> &nbsp;
		   	원자재 품명 <input type="text" name="raw_mat.raw_name" placeholder="원자재 품명을 입력하세요."> &nbsp;
		   	창고 코드 <input type="text" name="wh_code" placeholder="창고 코드를 입력하세요."> &nbsp; &nbsp;
		   	<input type="submit" class="B B-info" value="조회"></input>
		</form>
	<hr>
	</div>
	
	<div style="margin-left: 1%; margin-bottom: 1%">
		<a href="/stock/stockList_raw"><input type="button" value="원자재" class="B B-info" style="background-color: #EFEFEF; color: #73879c; width: 8%; font-weight: 500; font-size: 15px"></input></a>
	    <a href="/stock/stockList_prod"><input type="button" value="완제품" class="B B-info" style="background-color: #EFEFEF; color: #73879c; width: 8%; font-weight: 500; font-size: 15px"></input></a>
	</div>
	
	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			<form id="fr">
	
				<div class="x_title">
					<h2>원자재 목록<small>총 ${bp.totalCount } 건</small></h2>
					
					<div class="clearfix"></div>
				</div>
		<div class="x_content">
			<div class="table-responsive">
				<div class="table-wrapper" >
				<table id="data-table" class="table table-striped jambo_table bulk_action" style="text-align-last:center;">
					<thead>    
					    <tr class="headings">
					 		<th>유형</th>
					 		<th>제품 코드</th>
					 		<th>제품명</th>
					 		<th>색상</th>
					 		<th>재고 수량</th>
					 		<th>창고 코드</th>
					 		<th>담당자</th>
					 		<th>실수량</th>
					 	</tr>
			 		</thead>
			 	
			 	<c:forEach var="s" items="${stock_ListR}">
			             <tr>
			                 <td>${s.warehouse.wh_dv}</td>
			                 <td>${s.raw_code}</td>
			                 <td>${s.raw_mat.raw_name}</td>
			                 <td>${s.raw_mat.raw_color}</td>
			                 <td style="color: ${s.stock_count <= 50 ? 'red' : 'inherit'}">${s.stock_count}</td>
			                 <td>${s.wh_code}</td>
			                 <td>${s.warehouse.emp_id}</td>
			                 <c:if test = "${sessionScope.id.emp_department eq '자재팀' or sessionScope.id.emp_department eq '관리자'}">
			                 	<td><input type="button" onclick="stockPopup('${s.raw_code}')" class="B B-info" value="수정"></td>
			                 </c:if>
			             </tr>
				 </c:forEach>
			   </table>
			</div>
			</div>
			</div>
 		</form>
	</div>
</div>
<!-- //////////////////////////////////////////////////////////////////////// -->	      

		<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
			<ul class="pagination">
			    <c:if test="${countR3 > 0 }">
					<li class="paginate_button previous disabled"> 
						<c:if test="${bp.prev}">
						    <span><a href="/stock/stockList_raw?page=${bp.startPage - 1}&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">Previous</a></span>
						</c:if>
					</li>
					<li class="paginate_button previous disabled">
						<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
						    <a href="/stock/stockList_raw?page=${idx }&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">${idx }</a>
						</c:forEach>
					</li>
					<li class="paginate_button previous disabled">
						<c:if test="${bp.next && bp.endPage > 0}">
						    <a href="/stock/stockList_raw?page=${bp.endPage + 1}&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">Next</a>
						</c:if>
					</li>
				</c:if>
			</ul>
		</div>

  		
	
</div>

<%@ include file="../include/footer.jsp"%>