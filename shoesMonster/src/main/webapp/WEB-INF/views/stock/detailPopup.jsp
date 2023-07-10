<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="../resources/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<!-- bootstrap-progressbar -->
<link
	href="../resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<!-- Custom Theme Style -->
<link href="../resources/build/css/custom.min.css" rel="stylesheet">

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
	background-color: #fff;
}
.table-11 table{
	margin-bottom: 0;
}

.table-12 table{
  margin-top: 0;
}
div:where(.swal2-container) button:where(.swal2-styled).swal2-deny{
	background-color: #868e96;
}

</style> 
<!-- 폰트 -->

<script type="text/javascript">
// 	$(document).ready(function(){
		
// 		$("#roCancel").click(function() {
			
// 			var raw_order_num = $("#roCancel").val();
			
// // 			alert("발주번호 : " + raw_order_num);
// 			var confirmResult = confirm(raw_order_num +" 발주를 취소하시겠습니까?");
			
// 			if (confirmResult) {
// 				$.ajax({
// 					url : "/stock/detailPopup",
// 					type: "POST",
// 					contentType : "application/json",
// 					data: JSON.stringify(raw_order_num),
// 					success : function(response){
// 						alert("발주가 정상적으로 취소되었습니다.");
// 						window.close();
// 						window.opener.location.reload();
// 					},
// 					error : function(){
// 						alert("실패실패");
// 					}
// 				});
// 			}
// 		});
		
// 	});
	
	$(document).ready(function () {
	
		var raw_order_num = $("#roCancel").val();
		
		$("#roCancel").click(function () {
			
			Swal.fire({
			  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" +raw_order_num+"\n 발주를 취소하시겠습니까?"+ "</div>",
			  icon: 'info', 
			  showDenyButton: true,
			  confirmButtonColor: '#17A2B8', 
			  cancelButtonColor: '#73879C', 
			  confirmButtonText: 'Yes', 
			  width : '300px',
			
			}).then((result) => {
				
				// confirm => 예를 눌렀을 때
				if(result.isConfirmed){
					
					$.ajax({
						url: "/stock/detailPopup",
						type: "POST",
						contentType : "application/json",
						data: JSON.stringify(raw_order_num),
						success: function () {
	
							Swal.fire({
								  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "발주가 정상적으로 \n취소되었습니다",
								  icon: 'success',
								  width : '300px',
								}).then((result) => {
								  if (result.isConfirmed) {
										window.close();
										window.opener.location.reload();
								  }
								}); // swal.fire2
						}, //success
						error: function () {
							Swal.fire({
								title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "취소 중 오류가 발생했습니다",
								icon : 'question',
								width: '300px',
								});
						}
						
					});//ajax
					
				}//if
				
			});//then
			
		}); // #roCancel.click
		
	}); // document.ready
	
</script>
</head>
<body>
<div class="x_panel" style="margin-bottom: -1%;">

	<h1 style="margin-left: 1%;">발주 상세</h1>
<div class="table-11">
	<div class="table-responsive">
		<table class="table table-striped jambo_table bulk_action" 
			   id="data-table" style="text-align:center;">
		<thead>
		<tr class="headings">
			<th class="column-title">발주 번호</th>
		</tr>
		</thead>
		<tbody>	
			<tr>	
			<td  class=" ">${raw_order_num }</td>
			</tr>
		</tbody>
	</table>
	</div>
</div>
<!-- ////////////////////////////////// -->
<div class="table-12">
	<div class="table-responsive">
	<table class="table table-striped jambo_table bulk_action" id="data-table" style="text-align:center;">
	   <thead>
	    <tr class="headings">
	 		<th class="column-title">거래처 코드</th>
	 		<th class="column-title">거래처명</th>
	 		<th class="column-title">거래처 담당자</th>
	 		<th class="column-title">거래처 번호</th>
	 		<th class="column-title">담당자 번호</th>
	 		<th class="column-title">팩스 번호</th>
	    </tr>
	    </thead>
	    <tbody>
	    <c:forEach var="ro" items="${ro_detail }">
			<tr>
		 		<td class=" ">${ro.clients.client_code }</td>
		 		<td class=" ">${ro.clients.client_actname }</td>
		 		<td class=" ">${ro.clients.client_name }</td>
		 		<td class=" ">${ro.clients.client_tel }</td>
		 		<td class=" ">${ro.clients.client_phone }</td>
		 		<td class=" ">${ro.clients.client_fax }</td>
		    </tr>
	    </c:forEach>
	    </tbody>
	</table>
	<hr>
	<button type="submit" id="roCancel" name="roCancel" class="B B-info"  value="${raw_order_num }">발주 취소</button>
	</div>
</div>
</div>	
</body>
</html>