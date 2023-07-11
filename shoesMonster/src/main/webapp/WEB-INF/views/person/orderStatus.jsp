<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ include file="../include/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->
<link href="../resources/build/css/custom.css" rel="stylesheet">

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/smmain/smMain" />
</c:if>

<style type="text/css">
	
	body {
		font-family: 'NexonLv2Gothic';
	}
	
	div:where(.swal2-container) button:where(.swal2-styled).swal2-deny{
		background-color: #868e96;
	}
	
	.searchBox {
		display: inline-block;
		width: 25em;
	}
	.searchBox span {
		display: inline-block;
		width: 6em;
	}
	.date {
		display: inline-block;
		width: 35em;
	}
	
	.submitBtn {
/* 		padding-left: 10em; */
		padding-left: 34%;
	}
	
	
</style>
<!-- 폰트 -->

<script type="text/javascript">
//========================================= 함수, 상수 ===================================================	
//날짜 + 시간 + 분 + 초 ==> 코드
function codeCreation() {

	Date.prototype.getYearYY = function(){
        var a = this.getYear();
        return a >= 100 ? a-100 : a;
      }

    var date = new Date();
    var YY_year = date.getYearYY();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);
    var time = ("0" + date.getHours()).slice(-2);
    var minute = ("0" + date.getMinutes()).slice(-2);
    var second = ("0" + date.getSeconds()).slice(-2);

    return YY_year + month + day + time + minute + second;
}

// input으로 바꾸기
function inputCng(obj, type, name, value) {
	var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
	obj.html(inputBox);
}// inputCng
	
	
//오늘 날짜 yyyy-mm-dd
function getToday() {
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);

	return year + "-" + month + "-" + day;
} //getToday()

// 팝업 옵션
const popupOpt = "top=60,left=140,width=777,height=677";

//검색 팝업
function openWindow(search, inputId) {
 	var url = "/workorder/search?type=" + search + "&input=" + inputId;
 	var popup = window.open(url, "", popupOpt);
} //openWindow()
   

// 거래처 검색 
function serchClient(inputId){
  	openWindow("client_p",inputId);
}

// 완제품 검색
function serchProd(inputId){
  	openWindow("prod",inputId);
}

// 담당자 검색
function serchEmp(inputId){
  	openWindow("emp",inputId);
}
	

//검색 팝업2
function openWindow2(search, inputId) {
	var url = "/person/search?type=" + search + "&input=" + inputId;
	var popup = window.open(url, "", popupOpt);
} //openWindow2()


function popUp() {
	var queryString = window.location.search;
	var urlParams = new URLSearchParams(queryString);
	
	var isPop = urlParams.get("input");
	
	if(isPop==="null") {
		isPop = null;
	}
	
	// vvvvvvvvvvvvvvvvvv 페이징 완료하면 주석 풀기 ~~ vvvvvvvvvvvvvvvvvvvvv
	$('#pagination a').each(function(){
		
   		var prHref = $(this).attr("href");
   		
   		var newHref = prHref + "&input=" + isPop;
   			$(this).attr("href", newHref);
			
	}); //페이징 요소

	$('#input').val(isPop);
			
		if(isPop!=null && isPop!="") {
    		
    	$('#addButton').hide();
    	$('#modify').hide();
    	$('#delete').hide();
    	$('#save').hide();
    	
   		$('table tr').click(function(){
   			$(this).css('background', '#ccc');
    			
   			if(isPop === "order_code") {
   				
   				var orderCode = $(this).find('#l_orderCode').text();
   				var clientCode = $(this).find('#l_clientCode').text();
   				var clientName = $(this).find('#clientName').text();
   				var empName = $(this).find('#L_empName').text();
   				var prodCode = $(this).find('#l_prodCode').text();
   				
   				$('#'+isPop, opener.document).val(orderCode);
        		$('#client_code', opener.document).val(clientCode);
        		$('#client_Name', opener.document).val(clientName);
        		$('#emp_name', opener.document).val(empName);
        		
        		
   			} else {
    			var orderCode = $(this).find('#l_orderCode').text();
   				var prodCode = $(this).find('#l_prodCode').text();
    		
    			$('#'+isPop, opener.document).val(orderCode);
    			$('#prod_code', opener.document).val(prodCode);
			}
     			
     		window.close();
     	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기

	}

	else {
		console.log("팝업아님");
	} //if(팝업으로 열었을 때)
		
} //popUp()


	
// ========================================= 등록 ===================================================	
$(function(){
	
	//테이블 항목들 인덱스 부여
	$('table tr').each(function(index){
			var num = "<c:out value='${pvo.page}'/>";
			var num2 = "<c:out value='${pvo.pageSize}'/>";
			$(this).find('td:first').text(((num-1)*num2) + index);
	});
	
	popUp();
	
	//----------- 추가 버튼 ----------
	$('#add').click(function () {
		$('#modify').attr("disabled", true);
		$('#delete').attr("disabled", true);
		
		let today = getToday();
		let date = codeCreation();
		
		if($(this).hasClass('true')){

			var tbl = "<tr>";
			// 번호
			tbl += "<td style='width:75px'>";
			tbl += "</td>";
			// 수주번호
			tbl += "<td>";
			tbl += "<input type='text' name='order_code' id='order_code' readonly value='";
			tbl += 'O' + date;
			tbl += "' class='input-fieldb'>";
			tbl += "</td>";
			// 수주업체코드
			tbl += "<td>";
			tbl += '<input type="text" name="client_code" id="client_code" onclick=serchClient("client_code"); required readonly class="input-fielda">';
			tbl += "</td>";
			// 수주업체명
			tbl += "<td>";
			tbl += "<input type='text' name='client_actname' id='client_actname' onclick=serchClient('client_code'); required class='input-fielda'>";
			tbl += "</td>";
			// 수주일자
			tbl += "<td>";
			tbl += "<input type='text' name='order_date' id='order_date' autocomplete='off' required class='input-fielda'>";
			tbl += "</td>";
			// 담당자 코드 히든
			tbl += "<input type='hidden' name='emp_id' id='emp_id' value=<c:out value='${sessionScope.id.emp_id}'/> required readonly>";
			// 담당자
			tbl += "<td>";
			tbl += "<input type='text' name='emp_name' id='emp_name' value=<c:out value='${sessionScope.id.emp_name}'/> required readonly class='input-fieldb'>";
			tbl += "</td>";
			// 품번
			tbl += "<td>";
			tbl += "<input type='text' name='prod_code' id='prod_code' onclick=serchProd('prod_code'); required readonly class='input-fielda'>";
			tbl += "</td>";
			// 품명
			tbl += "<td>";
			tbl += "<input type='text' name='prod_name' id='prod_name' onclick=serchProd('prod_code'); required class='input-fielda'>";
			tbl += "</td>";
			// 단위
			tbl += "<td>";
			tbl += "<input type='text' name='prod_unit' id='prod_unit' onclick='serchEmp('prod_code')' required class='input-fielda'>";
			tbl += "</td>";
			// 납품예정일
			tbl += "<td>";
			tbl += "<input type='text' name='order_deliveryDate' id='order_deliveryDate' autocomplete='off' required class='input-fielda'>";
			tbl += "</td>";
			// 수주량
			tbl += "<td>";
			tbl += "<input type='number' name='order_count' id='order_count' required class='input-fieldb'>";
			tbl += "</td>";
			tbl += "</tr>";
			
			$('table').append(tbl);
			
			
			// 수주일자
			$('#order_date').datepicker({
				showOn: 'focus',
				changeMonth:false,
				changeYear:false,
				nextText:'다음달',
				prevText:'이전달',
				showButtonPanel:'true',
				currentText:'오늘',
				closeText:'닫기',
				dateFormat:'yy-mm-dd',
				dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
				dayNamesMin:['월','화','수','목','금','토','일'],
				monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				onSelect: function(date, inst) {
					$('#order_deliveryDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
				}
			});
			
			// 납품예정일
			$('#order_deliveryDate').datepicker({
				showOn: 'focus',
				changeMonth:false,
				changeYear:false,
				nextText:'다음달',
				prevText:'이전달',
				showButtonPanel:'true',
				currentText:'오늘',
				closeText:'닫기',
				dateFormat:'yy-mm-dd',
				dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
				dayNamesMin:['월','화','수','목','금','토','일'],
				monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			});
			
			
			$(this).removeClass('true');
		}// true 클래스 있을 때
		
		// (등록)저장
		$('#save').click(function () {
			
			var order_code = $('#order_code').val();
			var client_code = $('#client_code').val();
			var client_actname = $('#client_actname').val();
			var order_date = $('#order_date').val();
			var emp_name = $('#emp_name').val();
			var prod_code = $('#prod_code').val();
			var prod_name = $('#prod_name').val();
			var prod_unit = $('#prod_unit').val();
			var order_deliveryDate = $('#order_deliveryDate').val();
			var order_count = $('#order_count').val();
			
			if(order_code == "" || client_code == "" || order_date == "" ||
			   emp_name == "" || prod_code == "" || prod_name == "" || prod_unit == "" 
			   || order_deliveryDate== "" || order_count == "" ){
			
				Swal.fire({
					title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
					icon: 'info',
					width: '300px',
				})
			
			}else{
				$('#fr').attr("action", "/person/addOrder");
				$('#fr').attr("method", "POST");
				$('#fr').submit();
			}
		});//save.click
		
		// 취소버튼(=리셋)
		$('#cancle').click(function () {
			$('#fr').each(function () {
				this.reset();
			});
		}); // cancle click		
	});//add.click
	
	
	var isExecuted = false
	//--------- 수정 버튼 ------------//
	//수정버튼 클릭
	$('#modify').click(function() {
		
		$('#add').attr("disabled", true);
		$('#delete').attr("disabled", true);

		// 행 하나 클릭했을 때	
		$('table tr').click(function() {

			// 하나씩만 선택 가능
			if(!isExecuted) {
				isExecuted = true;
				
				$(this).addClass('selected');
				// 수주번호 저장
				let updateCode = $(this).find('#orderCode').text().trim();
				console.log(updateCode);

				var self = $(this);

				var names = [
						"order_code",
						"client_code",
						"client_actname",
						"order_date",
						"emp_id",
						"emp_name",
						"prod_code",
						"prod_name", 
						"prod_unit", 
						"order_deliveryDate", 
						"order_count",
						];

				//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
				self.find('td').each(function(idx,item) {
					if (idx > 0) {
						inputCng($(this),"text",names[idx - 1], $(this).text());
					} // 거래처 코드부터 다 수정 가능하게
				}); // self.find(~~)
				
				// readonly 속성 부여
				$(this).find("input").each(function(){
					if($(this).attr("name")=="order_code" || $(this).attr("name")=="client_code" || $(this).attr("name")=="client_actname" ||
							$(this).attr("name")=="order_date" || $(this).attr("name")=="prod_name" ||$(this).attr("name")=="prod_code"||
							$(this).attr("name")=="prod_unit" || $(this).attr("name")=="emp_name") {
						$(this).attr("readonly", true);
					}
				}); //readonly
				
				
// 				// 거래처 검색
// 				$('#client_code').click(function() {
// 					openWindow("client","client_code");
// 				}); // client_code click
// 				// 거래처 검색2
// 				$('#client_actname').click(function() {
// 					openWindow("client","client_code");
// 				}); // client_code click
				
// 				// 완제품 검색
// 				$('#prod_name').click(function() {
// 					openWindow("prod","prod_code");
// 				}); // client_code click
				
// 				// 완제품 검색2
// 				$('#prod_code').click(function() {
// 					openWindow("prod","prod_code");
// 				}); // client_code click
				
// 				// 담당자 검색
// 				$('#emp_name').click(function() {
// 					openWindow("emp","emp_id");
// 				}); // client_code click
		
				//저장버튼 -> form 제출
				$('#save').click(function() {
						
					$('#fr').attr("action","/person/updateOrder");
					$('#fr').attr("method","post");
					$('#fr').submit();
				}); //save
			} //하나씩만 선택 가능
				
			//취소버튼 -> 리셋
			$('#cancle').click(function() {
				$('#fr').each(function() {
					this.reset();
				});
			}); //cancle click
		}); //tr click
	}); // updateButton click
	
	
	//---------- 삭제 ------------- //
	$('#delete').click(function() {
		$('#add').attr("disabled", true);
		$('#modify').attr("disabled", true);

		if($(this).hasClass('true')) {
			// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 수주번호 저장
			$('table tr').each(function() {
				var code = $(this).find('td:nth-child(2)').text();
				
				var tbl = "<input type='checkbox' name='selected' value='";
				tbl += code;
				tbl += "'>";
				
				$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
				$(this).find('td:first').html(tbl);
			});
			
			//전체선택
			$('#selectAll').click(function() {
				var checkAll = $(this).is(":checked");

				if (checkAll) {
					$('input:checkbox').prop('checked', true);
				} else {
					$('input:checkbox').prop('checked', false);
				}
			});

			// 저장 -> 삭제
			$('#save').click(function() {

				var checked = [];

				$('input[name=selected]:checked').each(function() {
					console.log("check => " + $(this).val());
					checked.push($(this).val());
				});
				
// 				if(confirm("총 " + checked.length + "행 선택\n정말 삭제하시겠습니까?")) {

// 					if (checked.length > 0) {
	
// 						$.ajax({
// 							url : "/person/deleteOrder",
// 							type : "post",
// 							data : {checked : checked},
// 							dataType : "text",
// 							success : function() {
// 								alert("총 " + checked.length + "건 삭제 완료");
// 								location.reload();
// 							}, 
// 							error : function() {
// 								alert("삭제 실패했습니다");
// 							}
// 						}); //ajax
// 					} //체크된거 있을대
// 					else {
// 						alert("선택된 항목이 없습니다.");
// 					} //체크된거 없을때
// 				}
// 			}); //save
				
				// sweetalert
				if(checked.length > 0){
					
					Swal.fire({
						  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
								  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
						  icon: 'info', // 아이콘! 느낌표 색? 표시?
						  showDenyButton: true,
						  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
						  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
						  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
// 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
						  width : '300px', // alert창 크기 조절
						  
						}).then((result) => {
					
					 /* confirm => 예 눌렀을 때  */
					  if (result.isConfirmed) {
						  
					  
						$.ajax({
	 						url: "/person/deleteOrder",
	 						type: "POST",
	 						data: {checked : checked},
	 						dataType: "text",	
	 						success: function () {
	 							Swal.fire({
									  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
									  icon: 'success',
									  width : '300px',
									}).then((result) => {
									  if (result.isConfirmed) {
									    location.reload();
									  }
									});
							},
							error: function () {
								Swal.fire({
									title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
									icon : 'question',
									width: '300px',
									});
								
							}
						});//ajax
						  } else if (result.isDenied) {
								Swal.fire({
								title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
								icon : 'error',
								width: '300px',
								});
					}// if(confirm)
				});		
						
				}// 체크OOO
				else{
					Swal.fire({
						title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
						icon : 'warning',
						width: '300px',
						});
				}// 체크 XXX
	
			}); // save

			$(this).removeClass('true');
		} //if(삭제 버튼 true class 있으면)

		//취소 -> 리셋
		$('#cancle').click(function() {
			$('input:checkbox').prop('checked', false);
		});
	}); //deleteButton click

	
// ========================================= 등록 ===================================================	
	
// ========================================= 검색 ===================================================
	// 수주 일자 이날부터
	$('#order_date_fromDate').datepicker({
		showOn: 'focus',
		changeMonth:false,
		changeYear:false,
		nextText:'다음달',
		prevText:'이전달',
		showButtonPanel:'true',
		currentText:'오늘',
		closeText:'닫기',
		dateFormat:'yy-mm-dd',
		dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		onSelect: function(date, inst) {
			$('#order_date_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
		}
	});
	
	// 이날까지
	$('#order_date_toDate').datepicker({
		showOn: 'focus',
		changeMonth:false,
		changeYear:false,
		nextText:'다음달',	
		prevText:'이전달',
		showButtonPanel:'true',
		currentText:'오늘',
		closeText:'닫기',
		dateFormat:'yy-mm-dd',
		dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	});
	
	// 납품 예정일 이날부터
	$('#order_deliveryDate_fromDate').datepicker({
		showOn: 'focus',
		changeMonth:false,
		changeYear:false,
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
		showOn: 'focus',
		changeMonth:false,
		changeYear:false,
		nextText:'다음달',
		prevText:'이전달',
		showButtonPanel:'true',
		currentText:'오늘',
		closeText:'닫기',
		dateFormat:'yy-mm-dd',
		dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	});
	
// ========================================= 검색 ===================================================
});
</script>

<style>
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


<!-- page content -->
<div class="right_col" role="main">
	
	<h1 style="margin-left: 1%;">수주 관리</h1>
	
	<div style="margin: 1% 1%;">
	<hr>
		<form method="get">
			<fieldset>
				<input type="hidden" name="input" id="input" value="${input }">
				<input type="hidden" name="client_code" id="client_code9999" >
				
				<div class="searchBox">
					<span>업체</span>&nbsp;<input type="text" name="client_actname" id="client_actname9999" onclick="serchClient('client_code9999')" placeholder="업체를 선택하세요."> &nbsp;&nbsp;
				</div>
				<input type="hidden" name="emp_id" id="s_emp_id"> 
				<div class="searchBox date">
					<span>수주 일자</span>&nbsp;<input type="text" name="order_date_fromDate" id="order_date_fromDate" autocomplete="off" placeholder="기간을 선택하세요."> ~
					<input type="text" name="order_date_toDate" id="order_date_toDate" autocomplete="off" placeholder="기간을 선택하세요.">
				</div>
				
				<br><br>
				
				<div class="searchBox">
					<span>담당자</span>&nbsp;<input type="text" name="emp_name" id="s_emp_name" onclick="serchEmp('emp_id9999')" placeholder="담당자를 선택하세요."> &nbsp;&nbsp;
				</div>
				
				<input type="hidden" name="prod_code" id="prod_code9999">
				
				<div class="searchBox date">
					<span>납품 예정일</span>&nbsp;<input type="text" name="order_deliveryDate_fromDate" id="order_deliveryDate_fromDate" autocomplete="off" placeholder="기간을 선택하세요."> ~ 
							    <input type="text" name="order_deliveryDate_toDate" id="order_deliveryDate_toDate" autocomplete="off" placeholder="기간을 선택하세요."> &nbsp;&nbsp;
				</div>
				
				<br><br>
				
				<div class="searchBox">
					<span>품목</span>&nbsp;<input type="text" name="prod_name" id = "prod_name9999" onclick="serchProd('prod_code9999')" placeholder="품목을 선택하세요."> &nbsp;&nbsp;
				</div>
				
				<div class="searchBox submitBtn"><input type="submit" class="B B-info" value="조회"></div>
			</fieldset>
		</form>
		<hr>
	</div>
	
	
	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			<div class="x_title">
				<h2> 수주 목록<small>총 ${pm.totalCount } 건</small></h2>
				
				<div style="float: left;  margin-top: 1.5px;">
					<c:if test="${empty param.input }">
						<button onclick="location.href='/person/orderStatus'" class="B2 B2-info">↻</button>
					</c:if>
					<c:if test="${!empty param.input }">
						<button onclick="location.href='/person/orderStatus?input=${param.input }'" class="B2 B2-info">↻</button>
					</c:if>
				</div>
				
				<div style="float: right;">
					<button id="add" class="true B B-info">추가</button>
					<button id="modify" class="B B-info">수정</button>
					<button id="delete" class="true B B-info">삭제</button>
					<button type="reset" id="cancle" class="B B-info">취소</button>
					<button type="submit" id="save" class="B B-info">저장</button>
				</div>
				
				<!-- 버튼 제어 -->
				<script>
				    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
				
				    if (team === "영업팀" || team === "관리자") {
				        document.getElementById("add").disabled = false;
				        document.getElementById("modify").disabled = false;
				        document.getElementById("delete").disabled = false;
				        document.getElementById("cancle").disabled = false;
				        document.getElementById("save").disabled = false;
				        document.querySelector("[onclick^='location.href']").disabled = false;
				    } else {
				        document.getElementById("add").hidden = true;
				        document.getElementById("modify").hidden = true;
				        document.getElementById("delete").hidden = true;
				        document.getElementById("cancle").hidden = true;
				        document.getElementById("save").hidden = true;
				        document.querySelector("[onclick^='location.href']").hidden = true;
				    }
				</script>
				<!-- 버튼 제어 -->
				
				<div class="clearfix"></div>
			</div>
			
		<div class="x_content">
			<div class="table-responsive">
				<div class="table-wrapper" >
					<form id="fr">
						<table class="table table-striped jambo_table bulk_action" id="data-table" style="text-align-last:center;">
							<thead>
								<tr class="headings">
									<th>번호</th>
									<th>수주번호</th>
									<th>수주업체코드</th>
									<th>수주업체명</th>
									<th>수주일자</th>
									<th type='hidden' style='display: none;'>담당자id</th>
									<th>담당자</th>
									<th>품번</th>
									<th>품명</th>
									<th>단위</th>
									<th>납품예정일</th>
									<th>수주량</th>
						    	</tr>
						    </thead>
							<c:forEach var="vo" items="${searchOrderStatusList }">
								<tr>
									<td></td>
									<td id="l_orderCode">${vo.order_code}</td>
									<td id="l_clientCode">${vo.client_code}</td>
									<td>${vo.clients.client_actname}</td>
									<td>${vo.order_date}</td>
									<td type='hidden' style='display: none;'>${vo.emp_id}</td>
									<td id="L_empName">${vo.employees.emp_name}</td>
									<td id="l_prodCode">${vo.prod_code}</td>
									<td>${vo.prod.prod_name}</td>
									<td>${vo.prod.prod_unit}</td>
									<td>${vo.order_deliveryDate}</td>
									<td>${vo.order_count}</td>
								</tr>
							</c:forEach>
						</table>
					</form>
				</div>
			</div>
			
		</div>
			<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
			<li class="paginate_button previous disabled">
				<c:if test="${pm.prev }">
					<a href="/person/orderStatus?page=${pm.startPage - 1 }&client_code=${search.client_code}&order_date_fromDate=${search.order_date_fromDate}&order_date_toDate=${search.order_date_toDate}&prod_code=${search.prod_code}&emp_id=${search.emp_id}&order_deliveryDate_fromDate=${search.order_deliveryDate_fromDate}&order_deliveryDate_toDate=${search.order_deliveryDate_toDate}"> ⏪ </a>
				</c:if>
			</li>
			<li class="paginate_button previous disabled">	
				<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
					<a href="/person/orderStatus?page=${page }&client_code=${search.client_code}&order_date_fromDate=${search.order_date_fromDate}&order_date_toDate=${search.order_date_toDate}&prod_code=${search.prod_code}&emp_id=${search.emp_id}&order_deliveryDate_fromDate=${search.order_deliveryDate_fromDate}&order_deliveryDate_toDate=${search.order_deliveryDate_toDate}">${page }</a>
				</c:forEach>
			</li>
			<li class="paginate_button previous disabled">
				<c:if test="${pm.next }">
					<a href="/person/orderStatus?page=${pm.endPage + 1 }&client_code=${search.client_code}&order_date_fromDate=${search.order_date_fromDate}&order_date_toDate=${search.order_date_toDate}&prod_code=${search.prod_code}&emp_id=${search.emp_id}&order_deliveryDate_fromDate=${search.order_deliveryDate_fromDate}&order_deliveryDate_toDate=${search.order_deliveryDate_toDate}"> ⏩ </a>
				</c:if>
			</li>
		</ul>
	</div>
	
			<div style="float:left;">
				<!-- 엑셀 - 시작 -->
				<button id="excelDownload" class="B B-info">엑셀 ⬇️</button>
				
				<script type="text/javascript">
				function getToday() {
					var date = new Date();
					
					var year = date.getFullYear();
					var month = ("0" + (1 + date.getMonth())).slice(-2);
					var day = ("0" + date.getDate()).slice(-2);
					
					return year + "-" + month + "-" + day;
				} //getToday()
				
				
			        //엑셀
			        const excelDownload = document.querySelector('#excelDownload');
			        
			        document.addEventListener('DOMContentLoaded', ()=> {
			            excelDownload.addEventListener('click', exportExcel);
			        });
			        
			        function exportExcel() {
			            //1. workbook 생성
			            var wb = XLSX.utils.book_new();
			            
			            //2. 시트 만들기
			            var newWorksheet = excelHandler.getWorksheet();
			            
			            //3. workbook에 새로 만든 워크시트에 이름을 주고 붙이기
			            XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
			            
			            //4. 엑셀 파일 만들기
			            var wbout = XLSX.write(wb, {bookType:'xlsx', type:'binary'});
			            
			            //5. 엑셀 파일 내보내기
			            saveAs(new Blob([s2ab(wbout)], {type:"application/octet-stream"}), excelHandler.getExcelFileName());
			            
			        } //exportExcel()
			        
			        var excelHandler = {
			            getExcelFileName : function() {
			                return 'performanceList'+getToday()+'.xlsx'; //파일명
			            },
			            getSheetName : function() {
			                return 'Performance Sheet'; //시트명
			            },
			            getExcelData : function() {
			                return document.getElementById('data-table'); //table id
			            },
			            getWorksheet : function() {
			                return XLSX.utils.table_to_sheet(this.getExcelData());
			            }
			        } //excelHandler
			        
			        function s2ab(s) {
			            var buf = new ArrayBuffer(s.length);  // s -> arrayBuffer
			            var view = new Uint8Array(buf);  
			            for(var i=0; i<s.length; i++) {
			                view[i] = s.charCodeAt(i) & 0xFF;
			            }
			            return buf;
			        } //s2ab(s)
			    </script>
		    	<!-- 엑셀 - 끝 -->	
	    	</div>	
		</div>
	</div>
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/forTest/datepicker.css"> 
