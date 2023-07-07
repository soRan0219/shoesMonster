<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

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
				
				let lineCode = $(this).find('#lineCode').text();
				
				var inputId = event.data.inputId;
				
// 				alert(inputId);
				
				if(inputId==="line_code") {
// 					window.opener.document.getElementById('lineCode').value = lineCode;
					$('#line_code', opener.document).val(lineCode);
				} else if(inputId==="search_line") {
					$('#search_line', opener.document).val(lineCode);
				}
				
				window.close();
				
			}); //테이블 행 클릭(라인 선택)
		}); //addEventListener
		
	}) //jQuery
	
</script>

</head>
<body>
	<h1>/workorder/lineSearch</h1>
	
<%-- 	${lineList } --%>
	
	<table border="1">
		<tr>
			<th>라인코드</th>
			<th>라인명</th>
			<th>작업장</th>
			<th>사용여부</th>
		</tr>
		<c:forEach var="line" items="${lineList }">
			<tr>
				<td id="lineCode">${line.line_code }</td>
				<td>${line.line_name }</td>
				<td>${line.line_place }</td>
				<td>${line.line_use }</td>
			</tr>
		</c:forEach>
	</table>
	
	
</body>
</html>