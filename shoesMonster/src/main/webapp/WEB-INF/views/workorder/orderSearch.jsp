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
		
		
		$('table tr:not(:first-child)').click(function(){
			
			$(this).css('background', '#ccc');
			
			let prodCode = $(this).find('#prodCode').text();
			
			$('#orderCode', opener.document).val(prodCode);
			
			window.close();
			
		}); //테이블 행 클릭
		
	}) //jQuery
	
</script>

</head>
<body>
	<h1>/workorder/orderSearch</h1>
	
<%-- 	${prodList } --%>
	
	<table border="1">
		<tr>
			<th>수주코드</th>
			<th>납기일</th>
			<th>수주 수량</th>
			<th>거래처코드</th>
		</tr>
		<c:forEach var="prod" items="${prodList }">
			<tr>
				<td id="prodCode">${prod.prod_code }</td>
				<td>${prod.prod_name }</td>
				<td>${prod.prod_category }</td>
				<td>${prod.client_code }</td>
			</tr>
		</c:forEach>
	</table>
	
	
</body>
</html>