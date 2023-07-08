<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ include file="../include/header.jsp"%>

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
			$(this).find('td:first').text(index);
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
				tbl += " <td>"; 
				tbl += " </td>";
				// 생산실적코드
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_code' id='perform_code' readonly value='";
				tbl += "PF" + codeCreation();
				tbl += "'>";
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' name='work_code' id='work_code' required>";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' name='line_code' id='line_code' required readonly>";
				tbl += " </td>";
				// 품번
				tbl += " <td>";
				tbl += "  <input type='text' name='prod_code' id='prod_code' required readonly>";
				tbl += " </td>";
				// 실적일
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_date' id='perform_date' readonly value='";
				tbl += today;
				tbl += "'>";
				tbl += " </td>";
				// 실적수량
				tbl += " <td>";
				tbl += "  <input type='number' name='perform_qt' id='perform_qt' required>";
				tbl += " </td>";
				// 양품수
				tbl += " <td>";
				tbl += "  <input type='number' name='perform_fair' id='perform_fair' required>";
				tbl += " </td>";
				// 불량수
				tbl += " <td>";
				tbl += "  <input type='number' name='perform_defect' id='perform_defect' required>";
				tbl += " </td>";
				// 불량사유
				tbl += " <td>";
				tbl += "  <input type='text' name='defect_note' id='defect_note' required>";
				tbl += " </td>";
				// 현황
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_status' id='perform_status' value='진행' readonly>";
				tbl += " </td>";
				// 비고
				tbl += " <td>";
				tbl += "  <textarea name='perform_note' id='perform_note'></textarea>";
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
						alert("작업지시 수량보다 더 큰 수를 입력할 수 없습니다.");
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
					alert("항목을 모두 입력하세요");
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
					let updateCode = $(this).find('#performCode').text().trim();
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
							alert("작업지시 수량보다 더 큰 수를 입력할 수 없습니다.");
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
					var code = $(this).find('td:nth-child(2)').text();
					
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
				$('#save').click(function() {
					
					var checked = [];
					
					$('input[name=selected]:checked').each(function(){
						checked.push($(this).val());
					});
					
					if(checked.length > 0) {
						
						$.ajax({
							url: "/performance/deletePerform",
							type: "post",
							data: {checked:checked},
							dataType: "text",
							success: function() {
								alert("*** 아작스 성공 ***");
								location.reload();
							},
							error: function() {
								alert("아작스실패~~");
							}
						}); //ajax
						
					} //체크된거 있을대
					else {
						alert("선택된 항목이 없습니다.");
					} //체크된거 없을때
					
				}); //save
			
				$(this).removeClass('true');
			
			} //if(true class 있을 때)
			
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
				$('#search_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
			}
		});
		//이날까지
		$('#search_toDate').datepicker({
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
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		});
		
		//검색 결과 없을 때 표, 버튼 다 숨기기
		if(Number($('#total').text())==0) {
			$('#body').html("검색 결과가 없습니다.");
		}
		
		//======================= 검색 ===============================//
		
		
		
		//n건씩 표시
		$('#perPage').on('change', function() {
			var pageSize = $(this).val();
			
			$('#pageSize').val(pageSize);
			$('#searchForm').submit();
		});
		
		$('#perPage').find('option').each(function(){
			if($(this).val()===$('#pageSize').val()) {
				$(this).prop("selected", true);
			}
		});
		//n건씩 표시
		
		
		//생산실적코드 클릭시 상세조회
		$('#performCode a').click(function() {
			var obj = { perform_code:$(this).text().trim() };
				
			$.ajax({
				url: "/performance/detail",
				type: "post",
				data: JSON.stringify(obj),
				contentType : "application/json; charset=UTF-8",
				dataType : "json",
				success: function(data) {
					console.log(data);
					
					var tmp = "생산실적코드: ";
					tmp += data.perform_code;
					tmp += " 작업지시코드: ";
					tmp += data.work_code;
					tmp += " 라인코드: ";
					tmp += data.workOrder.line_code;
					tmp += " 품번: ";
					tmp += ((data.prod_code===""||data.prod_code==null) ? "없음" : data.prod_code);
					tmp += "<br>실적일: ";
					tmp += getDate(data.perform_date);
					tmp += " 실적수량: ";
					tmp += data.perform_qt;
					tmp += " 양품수: ";
					tmp += data.perform_fair;
					tmp += " 불량수: ";
					tmp += data.perform_defect;
					tmp += "<br>불량사유: ";
					tmp += ((data.defect_note===""||data.defect_note==null) ? "없음" : data.defect_note);
					tmp += " 현황: ";
					tmp += data.perform_status;
					tmp += " 등록자: ";
					tmp += ((data.emp_id===""||data.emp_id==null) ? "없음" : data.emp_id);
					tmp += " 변경자: ";
					tmp += ((data.change_id===""||data.change_id==null) ? "없음" : data.change_id);
					tmp += " 변경일: ";
					tmp += ((data.change_date===""||data.change_date==null) ? "없음" : getDate(data.change_date));
					tmp += " 비고: ";
					tmp += ((data.perform_note===""||data.perform_note==null) ? "없음" : data.perform_note);
					
					$('#detail').html(tmp);
				},
				error: function() {
					alert("아작스 실패");
				}
			}); //ajax
				
		}); //생산실적코드 클릭
		
		
	}); //jQuery
	
</script>

<!-- page content -->
<div class="right_col" role="main">

	<h1 style="margin-left: 1%;"> 생산실적 관리 </h1>
	
	<div style="margin-left: 1%;">
		<form id="searchForm" method="get">
			<fieldset>
				<input type="hidden" name="pageSize" id="pageSize" value="${pm.lwPageVO.pageSize }">
				작업지시코드: <input type="text" id="search_work_code" name="search_work_code">
				실적일: 
				<input type="text" id="search_fromDate" name="search_fromDate"> ~ 
				<input type="text" id="search_toDate" name="search_toDate">
				<input type="submit" class="B B-info" value="조회">
				<br>
				라인코드: <input type="text" id="search_line_code" name="search_line_code">
				품번: <input type="text" id="search_prod_code" name="search_prod_code">
				<br>
				<div style="margin-top: 0.5%;">
					현황: <input type="radio" id="search_perform_status" name="search_perform_status" value="전체" checked>전체
						  <input type="radio" id="search_perform_status" name="search_perform_status" value="진행">진행
						  <input type="radio" id="search_perform_status" name="search_perform_status" value="마감">마감
				</div>
			</fieldset>
		</form>
	</div>
		
	<hr>
		
	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			<div class="x_title">
			
<!-- 			<div id="body"> -->
			<div>
				<h2>생산 실적<small>총 ${pm.totalCount } 건</small></h2>
<%-- 				총 <span id="total">${pm.totalCount }</span>건 --%>
						
<!-- 				<select id="perPage" name="perPage"> -->
<!-- 					<option value="2">2</option> -->
<!-- 					<option value="5">5</option> -->
<!-- 					<option value="7">7</option> -->
<!-- 				</select> -->
<!-- 				건씩 표시 -->
			</div>
			
			<!-- 버튼 제어 -->
			<div style="float: right;">
				<button id="add" class="true B B-info">추가</button>
				<button id="modify" class="B B-info">수정</button>
				<button id="delete" class="true B B-info">삭제</button>
				<button type="reset" id="cancle" class="B B-info">취소</button>
				<button type="submit" id="save" class="B B-info">저장</button>
				<button onclick="location.href='/performance/performList'" class="B B-info">새로고침</button>
			</div>
			
			<div class="clearfix"></div>
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
		
		
	
	<div class="table-responsive">	
		<form id="fr">
			<input type="hidden" name="emp_id" value="${sessionScope.id.emp_id }">
			<table border="1" class="table table-striped jambo_table bulk_action"  id="data-table">
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
						<td id="performCode"><a href="#" onclick="return false" class="t">${vo.perform_code }</a></td>
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
		</form>
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
</div>
		
		<div id="pagination" style="text-align: center;">
			<c:if test="${pm.prev }">
				<a class="btn btn-secondary"
				 href="/performance/performList?page=${pm.startPage - 1 }&pageSize=${pm.lwPageVO.pageSize }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}&search_perform_status=${search.search_perform_status}"> ⏪ </a>
			</c:if>
			
			<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
				<a class="btn btn-secondary"
				href="/performance/performList?page=${page }&pageSize=${pm.lwPageVO.pageSize }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}&search_perform_status=${search.search_perform_status}">${page }</a>
			</c:forEach>
		
			<c:if test="${pm.next }">
				<a class="btn btn-secondary"
				href="/performance/performList?page=${pm.endPage + 1 }&pageSize=${pm.lwPageVO.pageSize }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}&search_perform_status=${search.search_perform_status}"> ⏩ </a>
			</c:if>
		</div>
	
	<div id="detail"></div>
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">