<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

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
	<h1>/workorder/prodSearch</h1>
	
<%-- 	${prodList } --%>
	
	<table border="1">
		<tr>
			<th>품번</th>
			<th>품명</th>
			<th>카테고리</th>
			<th>단위</th>
			<th>색상</th>
			<th>규격</th>
			<th>거래처코드</th>
		</tr>
		<c:forEach var="prod" items="${prodList }">
			<tr>
				<td id="prodCode">${prod.prod_code }</td>
				<td>${prod.prod_name }</td>
				<td>${prod.prod_category }</td>
				<td>${prod.prod_unit }</td>
				<td>${prod.prod_color }</td>
				<td>${prod.prod_size }</td>
				<td>${prod.client_code }</td>
			</tr>
		</c:forEach>
	</table>
	
	<div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/workorder/search?type=prod&nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
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
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/workorder/search?type=prod&nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&">&gt;</a>
		</c:if>
	</div>
	
	
</body>
</html>