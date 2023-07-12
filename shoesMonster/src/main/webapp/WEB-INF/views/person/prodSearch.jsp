<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<link rel="icon" href="../resources/images/favicon-32x32.png">

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->

<script type="text/javascript">
	
	$(function(){
		
		//이벤트 리스너 - 팝업 호출한 부모창 input 아이디 가져와서 해당 input에 넣기
		window.addEventListener('message', function(event){
		
			$('table tr:not(:first-child)').click(function(){
				
				$(this).css('background', '#ccc');
				
				let prodCode = $(this).find('#prodCode').text();
				
				var inputId = event.data.inputId;
				
				if(inputId==="prod_code") {
					$('#prod_code', opener.document).val(prodCode);
				} else if(inputId==="search_prod") {
					$('#search_prod', opener.document).val(prodCode);
				}
				
				window.close();
				
			}); //테이블 행 클릭
		
		}); //addEventListener
		
	}) //jQuery
	
</script>

</head>
<body>
	<h1>/person/prodSearch.jsp</h1>
	
<%-- 	${prodList } --%>
	
	<table border="1">
		<tr>
			<th>품번</th>
			<th>품명</th>
			<th>단위</th>
			<th>수량</th>
			<th>비고</th>
		</tr>
		<c:forEach var="prod" items="${prodList }">
			<tr>
				<td id="prodCode">${prod.prod_code }</td>
				<td>${prod.prod_name }</td>
				<td>${prod.prod_unit }</td>
				<td>${prod.prod_size }</td>
				<td>${prod.prod_note }</td>
			</tr>
		</c:forEach>
	</table>
	
	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
			<li class="paginate_button previous disabled">		
				<c:if test="${paging.startPage != 1 }">
					<a href="/workorder/search?type=prod&nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">Previous</a>
				</c:if>
			</li>
			<li class="paginate_button previous disabled">	
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
					<c:choose>
						<c:when test="${p == paging.nowPage }">
							<b>${p }</b>
						</c:when>
						<c:when test="${p != paging.nowPage }">
							<a href="/workorder/search?type=prod&nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
						</c:when>
					</c:choose>
				</c:forEach>
			</li>
			<li class="paginate_button previous disabled">	
				<c:if test="${paging.endPage != paging.lastPage}">
					<a href="/workorder/search?type=prod&nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&">Next</a>
				</c:if>
			<li class="paginate_button previous disabled">	
		</ul>
	</div>
	
	
</body>
</html>