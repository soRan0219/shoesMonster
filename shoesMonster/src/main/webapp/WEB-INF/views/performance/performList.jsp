<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>슈몬 생산실적</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";
	
	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/performance/search?type="+search + "&input=" + inputId;
		var popup = window.open(url, "", popupOpt);
		
		popup.onload = function() {
			popup.postMessage({inputId:inputId}, '*');
		};
	} //openWindow()
	
	//이벤트리스너 - 팝업 호출하는 input 아이디 저장
	window.addEventListener('message', function(event){
		var data = event.data;
		var inputId = data.inputId;
		var value = data.value;
		
		$('#'+inputId).val(value);
	});
	
	
	
	//jQuery
	$(document).ready(function(){
		
		//테이블 항목들 인덱스 부여
		$('table tr').each(function(index){
			$(this).find('td:first').text(index);
		});
		
		
		
		
		
		//======================= 검색 ===============================//
		$('#work_code').click(function(){
			//작업지시코드 검색
			openWindow("work", "work_code");
		}); //work_code click
		
		
	}); //jQuery
	
</script>

</head>
<body>
	<h1> /performance/performList </h1>
	
	<div>
		<fieldset>
			작업지시코드: <input type="text" id="work_code" name="work_code">
		</fieldset>
	</div>
	
	
	<table border="1">
		<tr>
			<th>번호</th>
			<th>생산실적코드</th>
			<th>작업지시코드</th>
			<th>라인코드</th>
			<th>품번</th>
			<th>실적일</th>
			<th>실적수량</th>
			<th>양품수</th>
			<th>불량수</th>
			<th>불량사유</th>
		</tr>
		<c:forEach var="vo" items="${perfList }">
			<tr>
				<td></td>
				<td>${vo.perform_code }</td>
				<td>${vo.work_code }</td>
				<td>${vo.workOrder.line_code }</td>
				<td>${vo.workOrder.prod_code }</td>
				<td>${vo.perform_date }</td>
				<td>${vo.perform_qt }</td>
				<td>${vo.perform_fair }</td>
				<td>${vo.perform_defect }</td>
				<td>${vo.defect_note }</td>
			</tr>
		</c:forEach>
	</table>
	
	
	
</body>
</html>