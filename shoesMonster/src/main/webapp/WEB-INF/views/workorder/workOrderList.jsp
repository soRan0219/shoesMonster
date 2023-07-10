<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ include file="../include/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/smmain/smMain" />
</c:if>

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}

.selected {
	background-color: #ccc;
}
</style>
<!-- 폰트 -->

<script type="text/javascript">
	//========================= 함수, 상수 ==================================//

	//오늘 날짜 yyyy-mm-dd
	function getToday() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);

		return year + "-" + month + "-" + day;
	} //getToday()
	
	//날짜 + 시간 + 분 + 초 ==> 코드
	function codeCreation() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		var time = ("0" + date.getHours()).slice(-2);
		var minute = ("0" + date.getMinutes()).slice(-2);
		var second = ("0" + date.getSeconds()).slice(-2);
		
		return year + month + day + time + minute + second;
	}
	
	//input으로 바꾸기 
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
		obj.html(inputBox);
	} //inputCng

	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";

	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/workorder/search?type=" + search + "&input=" + inputId;
		var popup = window.open(url, "", popupOpt);
	} //openWindow()
	
	

	// 팝업으로 열었을 때
	function popUp() {
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		var isPop = urlParams.get("input");
		
		if(isPop==="null") {
			isPop = null;
		}
		
		$('#pagination a').each(function(){
			
	   		var prHref = $(this).attr("href");
	   			
   			var newHref = prHref + "&input=" + isPop;
   			$(this).attr("href", newHref);
				
		}); //페이징 요소	
		
		$('#input').val(isPop);
		
    	if(isPop!=null && isPop!="") {
			
        	$('#add').hide();
        	$('#modify').hide();
        	$('#delete').hide();
        	$('#save').hide();
        	$('#cancle').hide();
        	
        	//:not(:first-child)
       		$('table tr').click(function(){
       			$(this).css('background', '#ccc');
        		
       			if(isPop==="work_code") {
       				//생산실적(performList)에서 열었을 때
	        		var workCode = $(this).find('#workCode').text().substring(0,16).trim();
	        		var lineCode = $(this).find('#lineCode').text();
	        		var prodCode = $(this).find('#prodCode').text();
	        		var workQt = $(this).find('#workQt').text(); 
	        		
	        		$('#'+isPop, opener.document).val(workCode);
	        		$('#line_code', opener.document).val(lineCode);
	        		$('#prod_code', opener.document).val(prodCode);
	        		
	        		//실적수량, 양품수, 불량수 작업지시량보다 많을 수 없게 설정
	        		$("input[type='number']", opener.document).attr("max", workQt);
	        		$("input[type='number']", opener.document).attr("placeholder", workQt);
	        		
       			} else {
	        		var workCode = $(this).find('#workCode').text().substring(0,16).trim();
	        		
	        		$('#'+isPop, opener.document).val(workCode);
       			}
        		
        		window.close();
        	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
        		
         		
   		} //if 
   		
   		else {
   			console.log("팝업아님");
    	} //if(팝업으로 열었을 때)
    		
	} //popUp()
	
	

	
	//========================= 함수, 상수 ==================================//
	
	//jQuery
	$(function() {
		
		//테이블 항목들 인덱스 부여
		$('table tr').each(function(index){
			var num = "<c:out value='${pvo.page}'/>";
			var num2 = "<c:out value='${pvo.pageSize}'/>";
			$(this).find('td:first').text(((num-1)*num2) + index);
	});
		
		
		popUp();			
		

		//============================ 버튼 구현 ====================================//

		/////////////// 추가 /////////////////////////////////////
		$('#add').click(function() {

			$('#modify').attr("disabled", true);
			$('#delete').attr("disabled", true);

			let today = getToday();

			if ($(this).hasClass('true')) {

				var tbl = "<tr>";
				// 번호
				tbl += " <td>";
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' name='work_code' id='work_code' readonly value='";
				tbl += "WO" + codeCreation();
				tbl += "' class='input-fielda'>";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' name='line_code' id='line_code' required readonly class='input-fielda'>";
				tbl += " </td>";
				// 수주코드
				tbl += " <td>";
				tbl += "  <input type='text' name='order_code' id='order_code_work' required readonly class='input-fielda'>";
				tbl += " </td>";
				// 품번
				tbl += " <td>";
				tbl += "  <input type='text' name='prod_code' id='prod_code' required readonly class='input-fielda'>";
				tbl += " </td>";
				// 지시일
				tbl += " <td>";
				tbl += "  <input type='text' name='work_date' id='work_date' readonly value='";
				tbl += today;
				tbl += "' class='input-fielda'>";
				tbl += " </td>";
				// 지시수량
				tbl += " <td>";
				tbl += "  <input type='text' name='work_qt' id='work_qt' required class='input-fielda'>";
				tbl += " </td>";
				//공정
				tbl += " <td>";
				tbl += "  <input type='text' value='1차공정' readonly class='input-fielda'>";
				tbl += " </td>";
 				// 지시상태
				tbl += " <td>";
				tbl += "  <input type='text' value='1공정지시' readonly class='input-fielda'>";
				tbl += " </td>";
				tbl += "</tr>";

				$('table').append(tbl);

				//수주코드 검색
				$('#order_code_work').click(function() {
					openWindow("order", "order_code_work");
				}); //orderCode click

				$(this).removeClass('true');
			} //true 클래스 있을 때

			// 저장 -> form 제출하고 저장함
			$('#save').click(function() {

				var prod_code = $('#prod_code').val();
				var order_code = $('#order_code').val();
				var work_qt = $('#work_qt').val();

				if (prod_code == "" || order_code == "" || work_qt == "") {
// 					alert("항목을 모두 입력하세요");
					Swal.fire({
						title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
						icon: 'info',
						width: '300px',
					})
				} else {
					$('#fr').attr("action", "/workorder/add");
					$('#fr').attr("method", "post");
					$('#fr').submit();
				}

			}); //save

			//취소버튼 -> 리셋
			$('#cancle').click(function() {
				$('#fr').each(function() {
					this.reset();
				});
			}); //cancle click

		}); //add click

		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		let queryString = window.location.search;
		let urlParams = new URLSearchParams(queryString);
		var fromController = urlParams.get("woInsert");
		
// 		console.log(fromController);
		
		if(fromController==0) {
			if(confirm("재고가 부족합니다. 발주등록 페이지로 이동하시겠습니까?")) {
				location.href = "/stock/raw_order";
			} else {
				var url = new URL(window.location.href);
				var searchParams = new URLSearchParams(url.search);
				searchParams.delete("woInsert");
				var newUrl = url.origin + url.pathname;
				
				window.location.href = newUrl;
			}
		}
		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		
		
		var isExecuted = false;
		/////////////// 수정 //////////////////////////////
		//수정버튼 클릭
		$('#modify').click(function() {

			$('#add').attr("disabled", true);
			$('#delete').attr("disabled", true);

			//행 하나 클릭했을 때	
			//:not(:first-child)
			$('table tr').click(function() {

				//하나씩만 선택 가능
				if(!isExecuted) {
					isExecuted = true;
					
					$(this).addClass('selected');
					//작업지시 코드 저장
					let updateCode = $(this).find('#workCode').text().substring(0,16).trim();
					console.log(updateCode);
	
					var jsonData = {
						work_code : updateCode
					};
	
					var self = $(this);
	
					$.ajax({
						url : "/workorder/detail",
						type : "post",
						contentType : "application/json; charset=UTF-8",
						dataType : "json",
						data : JSON.stringify(jsonData),
						success : function(data) {
							// alert("*** 아작스 성공 ***");
	
							var preVOs = [
									data.work_code,
									data.line_code,
									data.order_code,
									data.prod_code,
									data.work_date,
									data.work_qt,
									data.line_place,
									data.work_state
								];
	
							var names = [
									"work_code",
									"line_code",
									"order_code",
									"prod_code",
									"work_date",
									"work_qt",
									"line_place",
									"work_state"
								];
	
							//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
							self.find('td').each(function(idx,item) {
	
								if (idx > 0) {
									inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
									
									//지시수량 제외하고 readonly 속성 부여
									$(this).find("input").each(function(){
										if($(this).attr("name") != "work_qt") {
											$(this).attr("readonly", true);
										}
									}); //readonly
									
								} //라인코드부터 다 수정 가능하게
							}); // self.find(~~)
	
						},
						error : function(data) {
							alert("아작스 실패 ~~");
						}
					}); //ajax
	
					//저장버튼 -> form 제출
					$('#save').click(function() {
	
						$('#fr').attr("action","/workorder/modify");
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

		}); //modify click

		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		queryString = window.location.search;
		urlParams = new URLSearchParams(queryString);
		var fromController = urlParams.get("woModify");
		
// 		console.log(fromController);
		
		if(fromController==0) {
			if(confirm("재고가 부족합니다. 발주등록 페이지로 이동하시겠습니까?")) {
				location.href = "/stock/raw_order";
			} else {
				var url = new URL(window.location.href);
				var searchParams = new URLSearchParams(url.search);
				searchParams.delete("woInsert");
				var newUrl = url.origin + url.pathname;
				
				window.location.href = newUrl;
			}
		}
		//재고 부족시 등록 방지, 발주페이지 이동 confirm창
		
		
		/////////////// 삭제 //////////////////////////////
		$('#delete').click(function() {

			$('#add').attr("disabled", true);
			$('#modify').attr("disabled", true);
	
			if($(this).hasClass('true')) {
				
				// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
				$('table tr').each(function() {
					var code = $(this).find('td:nth-child(2)').text().substring(0,16).trim();
	
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
	
				//저장 -> 삭제
				$('#save').click(function() {
					
					var checked = [];
	
					$('input[name=selected]:checked').each(function() {
						console.log("check => " + $(this).val());
						checked.push($(this).val());
					});
					
// 					if(confirm("총 " + checked.length + "행 선택\n정말 삭제하시겠습니까?")) {
						
// 						if (checked.length > 0) {
		
// 							$.ajax({
// 								url : "/workorder/delete",
// 								type : "post",
// 								data : {checked : checked},
// 								dataType : "text",
// 								success : function() {
// 									alert("총 " + checked.length + "건 삭제 완료");
// 									location.reload();
// 								},
// 								error : function() {
// 									console.log("아작스실패~~");
// 								}
// 							}); //ajax  
		
// 						} //체크된거 있을대
// 						else {
// 							alert("선택된 항목이 없습니다.");
// 						} //체크된거 없을때
// 					} //if(삭제확인)
	
// 				}); //save
				
// 				$(this).removeClass('true');
// 			} //if(삭제 버튼 true class 있으면)
					
	
					// alert창 꾸미기~
					if(checked.length > 0){
						
						Swal.fire({
							  title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
									  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
							  icon: 'info', // 아이콘! 느낌표 색? 표시?
							  showDenyButton: true,
							  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
							  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
							  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//	 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
							  width : '300px', // alert창 크기 조절
							  
							}).then((result) => {
						
						 /* confirm => 예 눌렀을 때  */
						  if (result.isConfirmed) {
							  
						  
							$.ajax({
		 						url: "/workorder/delete",
		 						type: "POST",
		 						data: {checked : checked},
		 						dataType: "text",	
		 						success: function () {
		 							Swal.fire({
										  title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
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
										title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
										icon : 'question',
										width: '300px',
										});
									
								}
							});//ajax
							  } else if (result.isDenied) {
									Swal.fire({
									title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
									icon : 'error',
									width: '300px',
									});
						}// if(confirm)
					});		
							
					}// 체크OOO
					else{
						Swal.fire({
							title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
							icon : 'warning',
							width: '300px',
							});
					}// 체크 XXX
		
				}); // save
				
				$(this).removeClass('true');
			}// if(삭제 버튼 true class O)

			//취소 -> 리셋
			$('#cancle').click(function() {
				$('input:checkbox').prop('checked', false);
			});

		}); //delete click

		//============================ 버튼 구현 ====================================//

		//============================ 검색 =========================================//

		//라인코드 검색 팝업
		$('#search_line').click(function() {
			openWindow("line", "search_line");
		}); //lineCode click

		//품번 검색 팝업
		$('#search_prod').click(function() {
			openWindow("prod", "search_prod");
		}); //prodCode click

		//지시일자 이날부터
		$('#search_fromDate').datepicker({
			showOn: 'focus',
			changeMonth:false,
			changeYear:false,
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			yearSuffix: '년',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			onSelect: function(date, inst) {
				$('#search_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
			}
		});
		
		//이날까지
		$('#search_toDate').datepicker({
			showOn: 'focus',
			changeMonth:false,
			changeYear:false,
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			yearSuffix: '년',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		});
		
		
		//검색 결과 없을 때
		if(Number($('#total').text())==0) {
			$('#searchCnt').html("검색 결과가 없습니다.");
		}
		
		//============================ 검색 =========================================//
		
		
		//작업지시코드 클릭시 상세조회
		$('#workCode a').click(function() {
			var obj = { work_code:$('#workCode').text().substring(0,16).trim() };
				
			$.ajax({
				url : "/workorder/detail",
				type : "post",
				contentType : "application/json; charset=UTF-8",
				dataType : "json",
				data : JSON.stringify(obj),
				success : function(data) {
					
					var tmp = "<table border='1' class='table table-striped jambo_table bulk_action' style='text-align:center;'>";
					tmp += "<tr class='headings'>";
					tmp += " <th>작업지시코드 </th>";
					tmp += "  <td>" + data.work_code + "</td>";
					tmp += " <th> 라인코드 </th>";
					tmp += "  <td>" + data.line_code + "</td>";
					tmp += " <th> 수주코드 </th>";
					tmp += "  <td>" + data.order_code + "</td>";
					tmp += " <th> 품번 </th>";
					tmp += "  <td>" + data.prod_code + "</td>";
					tmp += "</tr>";
					tmp += "<tr class='headings'>"; 
					tmp += " <th> 지시상태 </th>";
					tmp += "  <td>" + data.work_state + "</td>";
					tmp += " <th> 지시일 </th>";
					tmp += "  <td>" + data.work_date + "</td>";
					tmp += " <th> 공정 </th>";
					tmp += "  <td>" + data.line_place + "</td>";
					tmp += " <th>지시수량 </th>";
					tmp += "  <td>" + data.work_qt + "</td>";
					tmp += "</tr>";
					tmp += "<tr class='headings'>";
					tmp += " <th> 등록자 </th>";
					tmp += ((data.emp_id===""||data.emp_id==null) ? "<td>없음</td>" : "<td>"+data.emp_id+"</td>");
					tmp += " <th> 변경자 </th>";
					tmp += ((data.change_id===""||data.change_id==null) ? "<td>없음</td>" : "<td>"+data.change_id+"</td>");
					tmp += " <th> 변경일 </th>";
					tmp += ((data.change_date===""||data.change_date==null) ? "<td>없음</td>" : "<td>"+data.change_date+"</td>");
					tmp += "</tr>";
					tmp += "</table>";
					
					
					$('.modal-body').html(tmp);
					$('.modal').modal("show");
				},
				error: function() {
					console.log("아작스 실패");
				}  
			}); //ajax
				
		}); //작업지시코드 클릭
		
		
	}); //jQuery
	
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
    width: 100px; /* 원하는 입력란의 너비로 설정 */
}
.input-fieldb {
    width: 125px; /* 원하는 입력란의 너비로 설정 */
}
.input-fieldc {
    width: 150px; /* 원하는 입력란의 너비로 설정 */
}
</style>


<!-- page content -->
<div class="right_col" role="main">

	<h1 style="margin-left: 1%;">작업지시 관리</h1>
	
	<div style="margin-left: 1%;">
		<form id="searchForm" method="get">
			<fieldset>
				<input type="hidden" name="input" id="input" value="${input }">
				<input type="hidden" name="pageSize" id="pageSize" value="${pm.lwPageVO.pageSize }">
				<span>라인코드 : </span> <input type="text" name="search_line" id="search_line" class="searchInputText"> 
				<span>지시일자 : </span> 
					<input type="text" name="search_fromDate" id="search_fromDate" class="searchInputText" autocomplete="off"> ~ 
					<input type="text" name="search_toDate" id="search_toDate" class="searchInputText" autocomplete="off"> 
				<span>품번 : </span> <input type="text" name="search_prod" id="search_prod" class="searchInputText">
				<input type="submit" value="조회" class="B B-info"> 
				<br><br>
				<span>지시상태 : </span> 
					<input type="radio" name="search_place" id="search_place" class="searchRadio" value="전체" checked> 전체 
					<input type="radio" name="search_place" id="search_place" class="searchRadio" value="1차공정"> 1차공정 
					<input type="radio" name="search_place" id="search_place" class="searchRadio" value="2차공정"> 2차공정 
					<input type="radio" name="search_place" id="search_place" class="searchRadio" value="3차공정"> 3차공정 
					<input type="radio" name="search_place" id="search_place" class="searchRadio" value="마감"> 마감 
			</fieldset>
		</form>
	</div>

	<hr>
	


	<div class="col-md-12 col-sm-12">	
		<div class="x_panel">
		
				<div class="x_title">
					<h2>작업지시 관리<small>총 ${pm.totalCount } 건</small></h2>
				
					<div style="float: left;  margin-top: 1.5px;">
						<c:if test="${empty param.input }">
							<button onclick="location.href='/workorder/workOrderList'" class="B2 B2-info">↻</button>
						</c:if>
						<c:if test="${!empty param.input }">
							<button onclick="location.href='/performance/requirement?input=${param.input }'" class="B2 B2-info">↻</button>
						</c:if>
					</div>
					
				    <!-- 버튼 제어 -->
					<div style="float: right;">
						<button id="add" class="true B B-info">추가</button>
						<button id="modify"class="B B-info">수정</button>
						<button id="delete" class="true B B-info">삭제</button>
						<button type="reset" id="cancle" class="B B-info">취소</button>
						<button type="submit" id="save" class="B B-info">저장</button>
					</div>	
					<script>
					    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
					
					    if (team === "생산팀" || team === "관리자") {
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
<!-- //////////////////////////////////////////////////////////////////////// -->	

  


<!-- //////////////////////////////////////////////////////////////////////// -->			
<div class="x_content">
	<div class="table-responsive">
		<div class="table-wrapper" >

		<form id="fr">
			<input type="hidden" name="emp_id" value="${sessionScope.id.emp_id }">
			<table class="table table-striped jambo_table bulk_action" style="text-align:center;" id="data-table">
				<thead>
					<tr class="headings">
						<th></th>
						<th>작업지시코드</th>
						<th>라인코드</th>
						<th>수주코드</th>
						<th>품번</th>
						<th>지시일</th>
						<th>지시수량</th>
						<th>공정</th>
						<c:if test="${id.emp_department eq '생산팀' || id.emp_department eq '관리자'}">
							<th>마감</th>
						</c:if>
					</tr>
				</thead>
				
				<c:forEach var="w" items="${workList }">
					<tr class="even pointer">
						<td class="a-center"></td>
						<td id="workCode">${w.work_code }<a href="#" onclick="return false">&#128269;</a></td>
						<td id="lineCode">${w.line_code }</td>
						<td>${w.order_code }</td>
						<td id="prodCode">${w.prod_code }</td>
						<td>${w.work_date }</td>
						<td id="workQt">${w.work_qt }</td>
						<td id="linePlace">${w.line_place }</td>
						<c:if test="${id.emp_department eq '생산팀' || id.emp_department eq '관리자'}">
							<td><a href="/workorder/updateStatus?work_code=${w.work_code }&line_place=${w.line_place}">공정마감</a></td>
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</form>
		</div>
	</div>
</div>
	
	<button id="excelDownload" class="B B-info">엑셀 ⬇️</button>
		
	<script type="text/javascript">
		
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
				return 'workOrderList'+getToday()+'.xlsx'; //파일명
			},
			getSheetName : function() {
				return 'Work Order Sheet'; //시트명
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
		
</div>
</div>
		
		
	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
			<li class="paginate_button previous disabled">
				<c:if test="${pm.prev }">
					<a href="/workorder/workOrderList?page=${pm.startPage - 1 }&pageSize=${pm.lwPageVO.pageSize }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}"> Previous </a>
				</c:if>
			</li>
			<li class="paginate_button previous disabled">
				<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
					<a href="/workorder/workOrderList?page=${page }&pageSize=${pm.lwPageVO.pageSize }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}">${page }</a>
				</c:forEach>
			</li>
			<li class="paginate_button previous disabled">
				<c:if test="${pm.next }">
					<a href="/workorder/workOrderList?page=${pm.endPage + 1 }&pageSize=${pm.lwPageVO.pageSize }&search_line=${search.search_line}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_place=${search.search_place}&search_prod=${search.search_prod}"> Next </a>
				</c:if>
			</li>
		</ul>
	</div>

	<!-- 상세보기 모달창 -->
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">작업지시 상세</h4>
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 상세보기 모달창 -->
	
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/forTest/sm.css"> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/forTest/datepicker.css"> 
