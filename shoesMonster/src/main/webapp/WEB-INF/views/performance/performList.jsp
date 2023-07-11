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
div:where(.swal2-container) button:where(.swal2-styled).swal2-deny{
	background-color: #868e96;
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
	
	//unix시간 -> 날짜형식 변환
	function getDate(unixTime) {
		var date = new Date(unixTime);
		
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		
		return year + "-" + month + "-" + day;
	} //getDate()
	
	
	//input으로 바꾸기 
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
		obj.html(inputBox);
	} //inputCng
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";
	
	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/performance/search?type="+search + "&input=" + inputId;
		var popup = window.open(url, "", popupOpt);
	} //openWindow()
	
	
	//========================= 함수, 상수 ==================================//
	
	
	
	//jQuery
	$(document).ready(function(){
		
		//테이블 항목들 인덱스 부여
		$('table tr').each(function(index){
			var num = "<c:out value='${pvo.page}'/>";
			var num2 = "<c:out value='${pvo.pageSize}'/>";
			$(this).find('td:first').text(((num-1)*num2) + index);
		});
		
		
		
		
		//============================ 버튼 구현 ====================================//
		/////////////// 추가 /////////////////////////////////////
		$('#add').click(function() {
			
			$('#modify').attr("disabled", true);
			$('#delete').attr("disabled", true);
			
			let today = getToday();
			
			if($(this).hasClass('true')) {
				
				var tbl = "<tr>";
				// 번호
				tbl += " <td style='width: 75px'>"; 
				tbl += " </td>";
				// 생산실적코드
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_code' id='perform_code' readonly value='";
				tbl += "PF" + codeCreation();
				tbl += "' class='input-fieldb'>";
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' name='work_code' id='work_code' required class='input-fielda'>";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' name='line_code' id='line_code' required readonly class='input-fieldb'>";
				tbl += " </td>";
				// 품번
				tbl += " <td>";
				tbl += "  <input type='text' name='prod_code' id='prod_code' required readonly class='input-fieldb'>";
				tbl += " </td>";
				// 실적일
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_date' id='perform_date' readonly value='";
				tbl += today;
				tbl += "' class='input-fieldb'>";
				tbl += " </td>";
				// 실적수량
				tbl += " <td>";
				tbl += "  <input type='number' name='perform_qt' id='perform_qt' required class='input-fieldb'>";
				tbl += " </td>";
				// 양품수
				tbl += " <td>";
				tbl += "  <input type='number' name='perform_fair' id='perform_fair' requiredclass='input-fieldb'>";
				tbl += " </td>";
				// 불량수
				tbl += " <td>";
				tbl += "  <input type='number' name='perform_defect' id='perform_defect' required class='input-fieldb'>";
				tbl += " </td>";
				// 불량사유
				tbl += " <td>";
				tbl += "  <input type='text' name='defect_note' id='defect_note' required class='input-fielda'>";
				tbl += " </td>";
				// 현황
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_status' id='perform_status' value='진행' readonly class='input-fieldb'>";
				tbl += " </td>";
				// 비고
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_note' id='perform_note' required class='input-fieldb'>";
				tbl += " </td>";
				tbl += "</tr>";
				
				$('table').append(tbl);
				
				//작업지시코드 검색
				$('#work_code').click(function(){
					openWindow("work", "work_code");
				}); //work_code click
				
				//실적수량, 양품수, 불량수 작업지시 수량보다 적게
				$("input[type='number']").on('change', function() {
					var inserted = Number($(this).val());
					var maxVal = Number($(this).attr("max"));
					
					if(inserted > maxVal) {
// 						alert("작업지시 수량보다 더 큰 수를 입력할 수 없습니다.");
						Swal.fire({
							title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "작업지시 수량보다 더 큰 수를 입력할 수 없습니다"+ "</div>",
							icon: 'info',
							width: '300px',
						})
						
						$(this).val("");
					}
					
				}); //input type=number onchange
				
				
				$(this).removeClass('true');
			} //true 클래스 있을 때
			
			// 저장 -> form 제출하고 저장함
			$('#save').click(function(){
				
				var perform_code = $('#perform_code').val();
				var work_code = $('#work_code').val();
				var line_code = $('#line_code').val();
				var prod_code = $('#prod_code').val();
				var perform_date = $('#perform_date').val();
				var perform_qt = $('#perform_qt').val();
				var perform_fair = $('#perform_fair').val();
				var perform_defect = $('#perform_defect').val();
				var defect_note = $('#defect_note').val();
				
				if(perform_code=="" || work_code=="" || line_code=="" || prod_code=="" || 
						perform_date=="" || perform_qt=="" || perform_qt=="" || 
						perform_fair=="" || perform_defect=="") {
// 					alert("항목을 모두 입력하세요");
					Swal.fire({
						title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
						icon: 'info',
						width: '300px',
					})
					
				} else {
					$('#fr').attr("action", "/performance/add");
					$('#fr').attr("method", "post");
					$('#fr').submit();
				}
				
				
			}); //save
			
			//취소버튼 -> 리셋
			$('#cancle').click(function(){
				$('#fr').each(function(){
					this.reset();
				});
			}); //cacle click
			
		}); //add click
		
		
		
		
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
					let updateCode = $(this).find('#performCode').text().substring(0,16).trim();
					console.log(updateCode);
	
					var self = $(this);
							
					var names = [
							"perform_code",
							"work_code",
							"line_code",
							"prod_code",
							"perform_date",
							"perform_qt", 
							"perform_fair",
							"perform_defect",
							"defect_note",
							"perform_status",
							"perform_note"
							];

					//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
					self.find('td').each(function(idx,item) {

						if (idx > 0) {
							inputCng($(this),"text",names[idx - 1], $(this).text());
							
							if(idx==1) {
								inputCng($(this),"text",names[idx - 1], updateCode);
							}
							
							//생산수량, 양품수, 불량수 타입 number
							if(idx>=6 && idx<=8) {
								var num = $(this).find("input");
								num.attr("type", "number");
								inputCng($(this), "number", names[idx-1], num.val());
							} //생산수량, 양품수, 불량수
							
							//생산현황 select로 바꿈(수동마감 해야할 수도 있음)
							if(idx==10) {
								var origin = $(this).find("input").val();
								
								var dropDown = "<select id='perform_status' name='perform_status'>";
								dropDown += "<option value='진행'>진행</option>";
								dropDown += "<option value='마감'>마감</option>";
								dropDown += "</select>";
								$(this).html(dropDown);
								//기존값이랑 일치하는 항목 선택된 상태
								$(this).find('option').each(function() {
									if (origin === $(this).text()) {
										$(this).attr("selected",true);
									} //if(일치하는 값 선택 상태로)
								}); //option 하나씩 탐색
							} //생산현황
							
							// readonly 속성 부여
							$(this).find("input").each(function(){
								if($(this).attr("name")=="perform_code" || $(this).attr("name")=="work_code" ||
										$(this).attr("name")=="line_code" ||$(this).attr("name")=="prod_code"||
										$(this).attr("name")=="work_date") {
									$(this).attr("readonly", true);
								}
							}); //readonly
							
						} //작업지시코드부터 다 수정 가능하게

					}); // self.find(~~)

					
					//작업지시코드 검색
					$('#work_code').click(function(){
						openWindow("work", "work_code");
					}); //work_code click
					
					//실적수량, 양품수, 불량수 작업지시 수량보다 적게
					$("input[type='number']").on('change', function() {
						var inserted = Number($(this).val());
						var maxVal = Number($(this).attr("max"));
						
						if(inserted > maxVal) {
// 							alert("작업지시 수량보다 더 큰 수를 입력할 수 없습니다.");
							Swal.fire({
								title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "작업지시 수량보다 더 큰 수를 입력할 수 없습니다"+ "</div>",
								icon: 'info',
								width: '300px',
							})
							$(this).val("");
						}
						
					}); //input type=number onchange
							
	
					//저장버튼 -> form 제출
					$('#save').click(function() {
	
						$('#fr').attr("action","/performance/modify");
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

		
		
		
		
		
		/////////////// 삭제 //////////////////////////////
		$('#delete').click(function(){
			
			$('#add').attr("disabled", true);
			$('#modify').attr("disabled", true);
			
			if($(this).hasClass('true')) {
				
				// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
				$('table tr').each(function(){
					var code = $(this).find('td:nth-child(2)').text().substring(0,16).trim();
					
					var tbl = "<input type='checkbox' name='selected' value='";
					tbl += code;
					tbl += "'>";
					
					$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
					$(this).find('td:first').html(tbl);
				});
				
				$('#selectAll').click(function() {
					var checkAll = $(this).is(":checked");
					
					if(checkAll) {
						$('input:checkbox').prop('checked', true);
					} else {
						$('input:checkbox').prop('checked', false);
					}
				});
				
				
				//저장 -> 삭제
// 				$('#save').click(function() {
					
// 					var checked = [];
					
// 					$('input[name=selected]:checked').each(function(){
// 						checked.push($(this).val());
// 					});
					
// 					if(confirm("총 " + checked.length + "행 선택\n정말 삭제하시겠습니까?")) {
						
// 						if(checked.length > 0) {
							
// 							$.ajax({
// 								url: "/performance/deletePerform",
// 								type: "post",
// 								data: {checked:checked},
// 								dataType: "text",
// 								success: function() {
// 									alert("총 " + checked.length + "건 삭제 완료");
// 									location.reload();
// 								},
// 								error: function() {
// 									alert("아작스실패~~");
// 								}
// 							}); //ajax  
							
// 						} //체크된거 있을대
// 						else {
// 							alert("선택된 항목이 없습니다.");
// 						} //체크된거 없을때
// 					} //삭제확인
					
// 				}); //save
			
// 				$(this).removeClass('true');
			
// 			} //if(true class 있을 때)
				
				//저장 -> 삭제(sweetalert)
				$('#save').click(function () {
					
					var checked = [];
					
					$('input[name=selected]:checked').each(function () {
						checked.push($(this).val());
					});
					
					if(checked.length > 0){
						
						
						Swal.fire({
							  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
						
									  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
							  icon: 'info', // 아이콘! 느낌표 색? 표시?
							  showDenyButton: true,
							  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
							  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
							  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//	 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
							  width : '300px', // alert창 크기 조절
							  
							}).then((result) => {
						
						 /* confirm => 예 눌렀을 때  */
						  if (result.isConfirmed) {
							  
						  
							$.ajax({
		 						url: "/performance/deletePerform",
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
			}// if(삭제 버튼 true class O)
			
			//취소 -> 리셋
			$('#cancle').click(function(){
				$('input:checkbox').prop('checked', false);
			});
			
		}); //delete click
		
		
		//======================= 검색 ===============================//
		//작업지시코드 검색 팝업
		$('#search_work_code').click(function(){
			openWindow("work", "search_work_code");
		}); //search_work_code click
		
		//라인코드 검색 팝업
		$('#search_line_code').click(function() {
			openWindow("line", "search_line_code");
		}); //lineCode click

		//품번 검색 팝업
		$('#search_prod_code').click(function() {
			openWindow("prod", "search_prod_code");
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
		
		//검색 결과 없을 때 표, 버튼 다 숨기기
		if(Number($('#total').text())==0) {
			$('#searchCnt').html("검색 결과가 없습니다.");
		}
		
		//======================= 검색 ===============================//
		
		
		
		//생산실적코드 클릭시 상세조회
		$('#performCode a').click(function() {
			var obj = { perform_code:$('#performCode').text().substring(0,16).trim() };
				
			$.ajax({
				url: "/performance/detail",
				type: "post",
				data: JSON.stringify(obj),
				contentType : "application/json; charset=UTF-8",
				dataType : "json",
				success: function(data) {
					console.log(data);
					
					var tmp = "<table border='1' class='table table-striped jambo_table bulk_action' style='text-align:center;'>";
					tmp += "<tr class='headings'>";
					tmp += " <th>생산실적코드</th>";
					tmp += "  <td>" + data.perform_code + "</td>";
					tmp += " <th>작업지시코드</th>";
					tmp += "  <td>" + data.work_code + "</td>";
					tmp += " <th>라인코드</th>";
					tmp += "  <td>" + data.workOrder.line_code + "</td>";
					tmp += " <th>품번</th>";
					tmp += ((data.prod_code===""||data.prod_code==null) ? "<td>없음</td>" : "<td>" + data.prod_code + "</td>");
					tmp += "</tr>";
					tmp += "<tr class='headings'>";
					tmp += " <th>실적일</th>";
					tmp += "  <td>" + getDate(data.perform_date) + "</td>";
					tmp += " <th>실적수량</th>";
					tmp += "  <td>" + data.perform_qt + "</td>";
					tmp += " <th>양품수</th>";
					tmp += "  <td>" + data.perform_fair + "</td>";
					tmp += " <th>불량수</th>";
					tmp += "  <td>" + data.perform_defect + "</td>";
					tmp += "</tr>";
					tmp += "<tr class='headings'>";
					tmp += " <th>불량사유</th>";
					tmp += ((data.defect_note===""||data.defect_note==null) ? "<td>없음</td>" : "<td>" + data.defect_note + "</td>");
					tmp += " <th>현황</th>";
					tmp += "  <td>" + data.perform_status + "</td>";
					tmp += " <th>등록자</th>";
					tmp += ((data.emp_id===""||data.emp_id==null) ? "<td>없음</td>" : "<td>" + data.emp_id + "</td>");
					tmp += " <th>변경자</th>";
					tmp += ((data.change_id===""||data.change_id==null) ? "<td>없음</td>" : "<td>" + data.change_id + "</td>");
					tmp += "</tr>";
					tmp += "<tr class='headings'>";
					tmp += " <th>변경일</th>";
					tmp += ((data.change_date===""||data.change_date==null) ? "<td>없음</td>" : "<td>" + getDate(data.change_date) + "</td>");
					tmp += " <th>비고</th>";
					tmp += ((data.perform_note===""||data.perform_note==null) ? "<td>없음</td>" : "<td>" + data.perform_note + "</td>");
					tmp += "</tr>";
					tmp += "</table>";
					
					$('.modal-body').html(tmp);
					$('.modal').modal("show");
				},
				error: function() {
					alert("아작스 실패");
				}
			}); //ajax
				
		}); //생산실적코드 클릭
		
		
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

	<h1 style="margin-left: 1%;"> 생산실적 관리 </h1>
	
	<div style="margin: 1% 1%;">
		<hr>
		<form id="searchForm" method="get">
			<fieldset>
				<input type="hidden" name="pageSize" id="pageSize" value="${pm.lwPageVO.pageSize }">

				작업지시코드&nbsp;<input type="text" id="search_work_code" name="search_work_code" placeholder="작업지시코드를 선택하세요."> &nbsp;&nbsp;
				실적일&nbsp;
				<input type="text" id="search_fromDate" name="search_fromDate" autocomplete="off" placeholder="기간을 선택하세요."> ~ 
				<input type="text" id="search_toDate" name="search_toDate" autocomplete="off" placeholder="기간을 선택하세요">
				<br><br>
				라인코드&nbsp;<input type="text" id="search_line_code" name="search_line_code" placeholder="라인코드를 선택하세요."> &nbsp;&nbsp;
				품목코드&nbsp;<input type="text" id="search_prod_code" name="search_prod_code" placeholder="품목코드를 선택하세요"> &nbsp;&nbsp;

				<input type="submit" class="B B-info" value="조회">
				<br><br>
				<div>
					현황&nbsp;&nbsp;<input type="radio" id="search_perform_status" name="search_perform_status" value="전체" checked>전체
						 &nbsp;<input type="radio" id="search_perform_status" name="search_perform_status" value="진행">진행
						  &nbsp;<input type="radio" id="search_perform_status" name="search_perform_status" value="마감">마감
				</div>
			</fieldset>
		</form>
		<hr>
	</div>
		
		
	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
		
			<div class="x_title">
				<div id="searchCnt">
					<h2>생산 실적 목록 총 <small id="total">${pm.totalCount }</small>건</h2>
				</div>
				
			<div style="float: left;  margin-top: 1.5px;">
				<c:if test="${empty param.input }">
					<button onclick="location.href='/performance/performList'" class="B2 B2-info">↻</button>
				</c:if>
				<c:if test="${!empty param.input }">
					<button onclick="location.href='/performance/performList?input=${param.input }'" class="B2 B-info">↻</button>
				</c:if>
			</div>
				
			<div style="float: right;">
				<button id="add" class="true B B-info">추가</button>
				<button id="modify" class="B B-info">수정</button>
				<button id="delete" class="true B B-info">삭제</button>
				<button type="reset" id="cancle" class="B B-info">취소</button>
				<button type="submit" id="save" class="B B-info">저장</button>
			</div>
			
			<div class="clearfix"></div>
			</div>
			
			<!-- 버튼 제어 -->
		<form id="fr">
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
		
		
	
	<div class="x_content">
		<div class="table-responsive">
			<div class="table-wrapper" >	
			<input type="hidden" name="emp_id" value="${sessionScope.id.emp_id }">
			<table class="table table-striped jambo_table bulk_action"  id="data-table" style="text-align-last:center;">
				<thead>
					<tr class="headings">
						<th class="column-title">번호</th>
						<th class="column-title">생산실적코드</th>
						<th class="column-title">작업지시코드</th>
						<th class="column-title">라인코드</th>
						<th class="column-title">품번</th>
						<th class="column-title">실적일</th>
						<th class="column-title">실적수량</th>
						<th class="column-title">양품수</th>
						<th class="column-title">불량수</th>
						<th class="column-title">불량사유</th>
						<th class="column-title">현황</th>
						<th class="column-title">비고</th>
					</tr>
				</thead>
	
				<c:forEach var="vo" items="${perfList }">
					<tr class="even pointer">
						<td class="a-center"></td>
						<td id="performCode">${vo.perform_code }<a href="#" onclick="return false" class="t">&#128269;</a></td>
						<td>${vo.work_code }</td>
						<td>${vo.workOrder.line_code }</td>
						<td>${vo.prod_code }</td>
						<td>${vo.perform_date }</td>
						<td>${vo.perform_qt }</td>
						<td>${vo.perform_fair }</td>
						<td>${vo.perform_defect }</td>
						<td>${vo.defect_note }</td>
						<td>${vo.perform_status }</td>
						<c:choose>
							<c:when test="${empty vo.perform_note }">
								<td>없음</td>
							</c:when>
							<c:otherwise>
								<td>${vo.perform_note }</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</table>
			</div>
			</div>
		</div>
	</form>
	
	<div style="float:left;">
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
	</div>
	
	<div id="pagination" class="dataTables_paginate paging_simple_numbers">
	<ul class="pagination">
		<li class="paginate_button previous disabled">
			<c:if test="${pm.prev }">
				<a href="/performance/performList?page=${pm.startPage - 1 }&pageSize=${pm.lwPageVO.pageSize }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}&search_perform_status=${search.search_perform_status}"> Previous </a>
			</c:if>
		</li>
		<li class="paginate_button previous disabled">
		<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
			<a href="/performance/performList?page=${page }&pageSize=${pm.lwPageVO.pageSize }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}&search_perform_status=${search.search_perform_status}">${page }</a>
		</c:forEach>
		</li>
		<li class="paginate_button previous disabled">
			<c:if test="${pm.next }">
				<a href="/performance/performList?page=${pm.endPage + 1 }&pageSize=${pm.lwPageVO.pageSize }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}&search_perform_status=${search.search_perform_status}"> Next </a>
			</c:if>
		</li>
	</ul>
</div>
	
	
	
	
	</div>
</div>
		
	
	<!-- 상세보기 모달창 -->
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">생산실적 상세</h4>
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
	
	
	<script type="text/javascript">
	
		$(function(){
			
			let perLineArr = [ ['라인명', '생산수량', '양품', '불량'] ];
			let perProdArr = [ ['품목명', '생산수량', '양품', '불량'] ];
			let perDateArr = [ ['생산일자', '생산수량', '양품', '불량'] ];
			
			$.ajax({
				url: "/performance/status",
				type: "post",
				success: function(data) {
					var line = data.perLine;
					var prod = data.perProd;
					var date = data.perDate;
					
					for(var i=0; i<line.length; i++) {
						var arr = [
							line[i].workOrder.line_code,
							line[i].perform_qt,
							line[i].perform_fair,
							line[i].perform_defect
						];
						perLineArr.push(arr);
					}
					for(var i=0; i<prod.length; i++) {
						var arr = [
							prod[i].prod_code,
							prod[i].perform_qt,
							prod[i].perform_fair,
							prod[i].perform_defect
						];
						perProdArr.push(arr);
					}
					for(var i=0; i<date.length; i++) {
						var arr = [
							getDate(date[i].perform_date),
							date[i].perform_qt,
							date[i].perform_fair,
							date[i].perform_defect
						];
						perDateArr.push(arr);
					}
					
					console.log("라인별: " + perLineArr);
					console.log("품목별: " + perProdArr);
					console.log("일자별: " + perDateArr);
					
					drawGoogleChart("라인", perLineArr, 'chart_line');
					drawGoogleChart("품목", perProdArr, 'chart_prod');
					drawGoogleChart("생산일자", perDateArr, 'chart_date');
					
				},
				error: function() {
					alert("실패실패실패");
				}
			}); //ajax
			
			function drawGoogleChart(name, array, id) {
				
				// Load the Vis ualization API and the piechart package.
				google.charts.load('current', {'packages':['bar']});
				
				// Set a callback to run when the Google Visualization API is loaded.
				google.charts.setOnLoadCallback(drawChart);
				
				// Callback that creates and populates a data table, 
				// instantiates the pie chart, passes in the data and draws it.
				function drawChart() {
					
					// Create the data table.
					var data = new google.visualization.arrayToDataTable(array);
					
					// Set chart options
					var options = {
							width: 1000,
							height: 500,
// 							width: '80%',
// 							height: '100%',
							padding: {
								top: 20,
								bottom: 10,
							},
							//차트 제목
							title: name + '별 생산실적 현황',
							titlePosition: 'in',
							titleTextStyle: {
								fontSize: 25,
								bold: true
							},
							//차트옵션
							chartArea: {
								backgroundColor: '#F7F7F7',
								left: '10%',
								width: '90%',
								height: '80%'
							},
							//배경색
							backgroundColor: '#F7F7F7',
							//차트 막대 색
							colors: ['#1ABB9C', 'rgb(173, 218, 209)', 'rgb(56, 170, 145)'],
							//줌인 뭐 이런 기능인데 적용 안되는듯
// 							explorer: {
// 								axis: 'horizontal',
// 								actions: ['dragToZoom', 'rightClickToReset']
// 							},
							//폰트
							fontSize: 20,
							fontName: 'NexonLv2Gothic',
							//가로축
							hAxis: {
								title: name,
								titleTextStyle: {
									color: 'gray',
									fontName: 'NexonLv2Gothic',
									fontSize: 20
								},
								textStyle: {
									color: '#000',
									fontName: 'NexonLv2Gothic',
									fontSize: 17
								},
								format: '#,###'
							},
							//세로축
							vAxis: {
								titleTextStyle: {
									fontSize: 20
								},
								//세로축 선(=> 가로선)
								gridlines: {
// 									color: 'red',
// 									minSpacing: 2
								},
								textStyle: {
									color: '#000',
									fontName: 'NexonLv2Gothic',
									fontSize: 13
								},
								format: '#,###'
							},
							//차트 범례 설정
							legend: {
								position: 'top',
								textStyle: {
									color: 'gray',
									fontSize: 16,
									fontName: 'NexonLv2Gothic',
									bold: true,
									italic: true
								},
								alignment: 'center'
							},
// 							bars: 'horizontal'  //가로차트 옵션
					};
					
					console.log(options);
					
					// Instantiate and draw our chart, passing in some options.
					var chart = new google.charts.Bar(document.getElementById(id));
					chart.draw(data, google.charts.Bar.convertOptions(options));
				} //drawChart()
				
			} //drawGoogleChart()
			
			
			$('ul.tabs li').click(function() {
				var tab_id = $(this).attr('data-tab');
				
				$('ul.tabs li').removeClass('current');
				$('.tab-content').removeClass('current');
				
				$(this).addClass('current');
				$('#'+tab_id).addClass('current');
			});
			
		}); //jQuery
	</script>
	
	<div class="tabContainer" style="margin-top: 20%;">
	
		<h2><b>생산실적 현황</b></h2>
		
		<br>
		
		<ul class="tabs">
			<li class="tab-link current" data-tab="chart_line">라인별 생산현황</li>
			<li class="tab-link" data-tab="chart_prod">품목별 생산현황</li>
			<li class="tab-link" data-tab="chart_date">일자별 생산현황</li>
		</ul>
		
		<div id="chart_line" class="tab-content current"></div>
		<div id="chart_prod"  class="tab-content"></div>
		<div id="chart_date"  class="tab-content"></div>
	</div>
	
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="/resources/forTest/sm.css">
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/forTest/performStatus.css"> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/forTest/datepicker.css"> 