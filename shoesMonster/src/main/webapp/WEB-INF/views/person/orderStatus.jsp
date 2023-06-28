<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">

function popUp() {
	var queryString = window.location.search;
	var urlParams = new URLSearchParams(queryString);
	
	var isPop = urlParams.get("input");
	
	if(isPop==="null") {
		isPop = null;
	}
	
	
	// vvvvvvvvvvvvvvvvvv 페이징 완료하면 주석 풀기 ~~ vvvvvvvvvvvvvvvvvvvvv
// 	$('#pagination a').each(function(){
		
//    		var prHref = $(this).attr("href");
   		
//    		var newHref = prHref + "&input=" + isPop;
//    			$(this).attr("href", newHref);
			
// 	}); //페이징 요소


			
	$('#input').val(isPop);
			
		if(isPop) {
    		
//     	$('#addButton').hide();
//     	$('#modify').hide();
//     	$('#delete').hide();
//     	$('#save').hide();
    		
   		$('table tr:not(:first-child)').click(function(){
   			$(this).css('background', '#ccc');
    			
   			var orderCode = $(this).find('#orderCode').text();
     			
 			$('#'+isPop, opener.document).val(orderCode);
     			
     		window.close();
     	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
    		
	} else {
		console.log("팝업아님");
	} //if(팝업으로 열었을 때)
		
} //popUp()

$(function(){
	
	popUp();
	
// ========================================= 검색 ===================================================
	// 수주 일자 이날부터
	$('#order_date_fromDate').datepicker({
		showOn:'both',
		buttonImage:'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
		buttonImageOnly:'true',
		changeMonth:'true',
		changeYear:'true',
		nextText:'다음달',
		prevText:'이전달',
		showButtonPanel:'true',
		currentText:'오늘',
		closeText:'닫기',
		dateFormat:'yy-mm-dd',
		dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		onSelect: function(date, inst) {
			$('#order_deliveryDate_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
		}
	});
	
	// 이날까지
	$('#order_date_toDate').datepicker({
		showOn:'both',
		buttonImage:'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
		buttonImageOnly:'true',
		changeMonth:'true',
		changeYear:'true',
		nextText:'다음달',
		prevText:'이전달',
		showButtonPanel:'true',
		currentText:'오늘',
		closeText:'닫기',
		dateFormat:'yy-mm-dd',
		dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	});
	
	// 납품 예정일 이날부터
	$('#order_deliveryDate_fromDate').datepicker({
		showOn:'both',
		buttonImage:'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
		buttonImageOnly:'true',
		changeMonth:'true',
		changeYear:'true',
		nextText:'다음달',
		prevText:'이전달',
		showButtonPanel:'true',
		currentText:'오늘',
		closeText:'닫기',
		dateFormat:'yy-mm-dd',
		dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		onSelect: function(date, inst) {
			$('#order_deliveryDate_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
		}
	});
	
	// 이날까지
	$('#order_deliveryDate_toDate').datepicker({
		showOn:'both',
		buttonImage:'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
		buttonImageOnly:'true',
		changeMonth:'true',
		changeYear:'true',
		nextText:'다음달',
		prevText:'이전달',
		showButtonPanel:'true',
		currentText:'오늘',
		closeText:'닫기',
		dateFormat:'yy-mm-dd',
		dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	});
// ========================================= 검색 ===================================================
});
</script>

<!-- page content -->
<div class="right_col" role="main">

	<h1>수주 현황</h1>
	
	<form action="" method="get">
		<input type="hidden" name="input" id="input" value="${input }">
		업체 <input type="text" name="client_code">
		수주 일자 <input type="text" name="order_date_fromDate" id="order_date_fromDate"> ~
				  <input type="text" name="order_date_toDate" id="order_date_toDate">
		품번 <input type="text" name="prod_code">
		<input type="submit" value="조회">
		<br>
		담당자 <input type="text" name="emp_id">
		납품 예정일 <input type="text" name="order_deliveryDate_fromDate" id="order_deliveryDate_fromDate">
				    <input type="text" name="order_deliveryDate_toDate" id="order_deliveryDate_toDate">
		출하완료여부 
		<select name="order_finish">
			<option selected value= "전체">전체</option>
			<option value="Y">Y</option>
			<option value="N">N</option>
		</select>
	</form>
	
	
	<table border="1" id="">
		<tr>
			<th></th>
			<th>수주번호</th>
			<th>업체</th>
			<th>수주일자</th>
			<th>담당자</th>
			<th>품번</th>
			<th>품명</th>
			<th>단위</th>
			<th>납품예정일</th>
			<th>수주량</th>
			<th>완료여부</th>
		</tr>
		
		<c:forEach var="vo" items="${orderStatusList }" varStatus="i">
			<c:if test="${vo.orders.order_finish == '전체' }">
				<tr>
					<td>${i.count }</td>
					<td id="orderCode">${vo.orders.order_code}</td>
					<td>${vo.orders.client_code}</td>
					<td>${vo.orders.order_date}</td>
					<td>${vo.orders.emp_id}</td>
					<td>${vo.prod_code}</td>
					<td>${vo.prod_name}</td>
					<td>${vo.prod_unit}</td>
					<td>${vo.orders.order_deliveryDate}</td>
					<td>${vo.orders.order_count}</td>
					<td><input type="checkbox">${vo.orders.order_finish}</td>
				</tr>
			</c:if>
			
			<c:if test="${vo.orders.order_finish == 'Y' }">
				<tr>
					<td>${i.count }</td>
					<td>${vo.orders.order_code}</td>
					<td>${vo.orders.client_code}</td>
					<td>${vo.orders.order_date}</td>
					<td>${vo.orders.emp_id}</td>
					<td>${vo.prod_code}</td>
					<td>${vo.prod_name}</td>
					<td>${vo.prod_unit}</td>
					<td>${vo.orders.order_deliveryDate}</td>
					<td>${vo.orders.order_count}</td>
					<td><input type="checkbox">${vo.orders.order_finish}</td>
				</tr>
			</c:if>
			
			<c:if test="${vo.orders.order_finish == 'N' }">
				<tr>
					<td>${i.count }</td>
					<td>${vo.orders.order_code}</td>
					<td>${vo.orders.client_code}</td>
					<td>${vo.orders.order_date}</td>
					<td>${vo.orders.emp_id}</td>
					<td>${vo.prod_code}</td>
					<td>${vo.prod_name}</td>
					<td>${vo.prod_unit}</td>
					<td>${vo.orders.order_deliveryDate}</td>
					<td>${vo.orders.order_count}</td>
					<td><input type="checkbox">${vo.orders.order_finish}</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">