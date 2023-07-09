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
</style>
<!-- 폰트 -->

<script type="text/javascript">
	
	function stockPopup(code) {
		window.open("stockPopup?code=" + code, "재고 상세", "width=600, height=300, left=200, top=150, location=no");
	}
	
</script>

<div class="right_col" role="main">

	<h1 style="margin-left: 1%;"> 재고 관리 </h1>

	<div style="margin-left: 1%;">
		<a href="/stock/stockList_raw"><input type="button" value="원자재" class="B B-info" ></input></a>
	    <a href="/stock/stockList_prod"><input type="button" value="완제품" class="B B-info" ></input></a>
	</div>
	
	<div style="margin-left: 1%;">    
		<form action="" method="get">
	 		원자재 코드 : <input type="text" name="raw_code" placeholder="원자재 코드를 입력하세요">
		   	원자재 품명 : <input type="text" name="raw_mat.raw_name" placeholder="원자재 품명을 입력하세요">
		   	창고 코드 : <input type="text" name="wh_code" placeholder="창고 코드 입력하세요"> 
		   	<input type="submit" class="B B-info" value="검색"></input>
		</form>
	</div>

	<hr>

	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			<form id="fr">
	
				<div class="x_title">
					<h2>원자재 목록<small>총 ${bp.totalCount } 건</small></h2>
					
					<div class="clearfix"></div>
				</div>
				<div style="overflow-x: auto;">
				<table id="data-table" border="1" class="table table-striped jambo_table bulk_action" style="text-align:center;">
					<colgroup>
					    <col style="width: 100px">
					    <col style="width: 100px">
					    <col style="width: 100px">
					    <col style="width: 100px">
					    <col style="width: 100px">
					    <col style="width: 100px">
					    <col style="width: 100px">
					    <col style="width: 100px">
					</colgroup>
					<thead>    
					    <tr class="headings">
					 		<th>유형</th>
					 		<th>제품 코드</th>
					 		<th>제품명</th>
					 		<th>색상</th>
					 		<th>재고 수량</th>
					 		<th>창고 코드</th>
					 		<th>담당자</th>
					 		<th>수정 버튼</th>
					 	</tr>
			 		</thead>
			 	
			 	<c:forEach var="s" items="${stock_ListR}">
			             <tr>
			                 <th>${s.warehouse.wh_dv}</th>
			                 <td>${s.raw_code}</td>
			                 <td>${s.raw_mat.raw_name}</td>
			                 <td>${s.raw_mat.raw_color}</td>
			                 <td style="color: ${s.stock_count <= 50 ? 'red' : 'inherit'}">${s.stock_count}</td>
			                 <td>${s.wh_code}</td>
			                 <td>${s.warehouse.emp_id}</td>
			                 <c:if test = "${sessionScope.id.emp_department eq '물류팀' or sessionScope.id.emp_department eq '관리자'}">
			                 	<td><input type="button" onclick="stockPopup('${s.raw_code}')" class="B B-info" value="수정"></td>
			                 </c:if>
			             </tr>
				 </c:forEach>
			   </table>
			</div>
 		</form>
	</div>
</div>
<!-- //////////////////////////////////////////////////////////////////////// -->	      
           		
<!-- ㅇㅇㅇㅇㅇ -->
	<div>
	    <c:if test="${countR3 > 0 }">
			<c:if test="${bp.prev}">
			    <span><a class="btn btn-secondary" href="/stock/stockList_raw?page=${bp.startPage - 1}&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">이전</a></span>
			</c:if>
			
			<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
			    <a class="btn btn-secondary" href="/stock/stockList_raw?page=${idx }&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">${idx }</a>
			</c:forEach>
			
			<c:if test="${bp.next && bp.endPage > 0}">
			    <a class="btn btn-secondary" href="/stock/stockList_raw?page=${bp.endPage + 1}&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">다음</a>

		</c:if>
		</c:if>
<!-- ㅇㅇㅇㅇㅇ -->
	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
		    <c:if test="${countR3 > 10 }">
				<li class="paginate_button previous disabled"> 
					<c:if test="${bp.prev}">S
					    <span><a href="/stock/stockList_raw?page=${bp.startPage - 1}&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">Previous</a></span>
					</c:if>
				</li>
				<li class="paginate_button previous disabled">
					<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
					    <a chref="/stock/stockList_raw?page=${idx }&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">${idx }</a>
					</c:forEach>
				</li>
				<li class="paginate_button previous disabled">
					<c:if test="${bp.next && bp.endPage > 0}">
					    <a href="/stock/stockList_raw?page=${bp.endPage + 1}&raw_code=${svo.raw_code }&raw_mat.raw_name=${svo.raw_code }&wh_code=${svo.wh_code}">Next</a>
					</c:if>
				</li>
<!-- ㅇㅇㅇㅇㅇ -->
			</c:if>
		</ul>
	</div>
	
</div>

<%@ include file="../include/footer.jsp"%>