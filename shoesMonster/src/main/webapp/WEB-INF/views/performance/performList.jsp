<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>


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
				var perform_note = $('#perform_note').val();
				
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
			$('table tr:not(:first-child)').click(function() {

				//하나씩만 선택 가능
				if(!isExecuted) {
					isExecuted = true;
					
					$(this).addClass('selected');
					//작업지시 코드 저장
					let updateCode = $(this).find('#performCode').text().trim();
					console.log(updateCode);
	
					var jsonData = {
						perform_code : updateCode
					};
	
					var self = $(this);
	
					$.ajax({
						url : "/performance/detail",
						type : "post",
						contentType : "application/json; charset=UTF-8",
						dataType : "json",
						data : JSON.stringify(jsonData),
						success : function(data) {
// 							alert("*** 아작스 성공 ***");
// 							alert(getDate(data.perform_date));
	
							var preVOs = [
									data.perform_code,
									data.work_code,
									data.workOrder.line_code,
									data.workOrder.prod_code,
									getDate(data.perform_date),
									data.perform_qt,
									data.perform_fair, 
									data.perform_defect, 
									data.defect_note, 
									data.perform_note, 
									];
	
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
									"perform_note"
									];
	
							//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
							self.find('td').each(function(idx,item) {
	
								if (idx > 0) {
									inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
									
									if(idx>=6 && idx<=8) {
										inputCng($(this), "number", names[idx-1], preVOs[idx-1]);
									}
									
								} //라인코드부터 다 수정 가능하게
	
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
							
						},
						error : function(data) {
							alert("아작스 실패 ~~");
						}
					}); //ajax
	
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
		$('#search_work_code').click(function(){
			//작업지시코드 검색
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
		
	}); //jQuery
	
</script>

<!-- page content -->
<div class="right_col" role="main">

	<h1> /performance/performList </h1>
	
	<div>
		<form id="searchForm" method="get">
			<fieldset>
				<input type="hidden" name="pageSize" id="pageSize" value="${pm.lwPageVO.pageSize }">
				작업지시코드: <input type="text" id="search_work_code" name="search_work_code">
				실적일: 
				<input type="text" id="search_fromDate" name="search_fromDate"> ~ 
				<input type="text" id="search_toDate" name="search_toDate"> <br>
				라인코드: <input type="text" id="search_line_code" name="search_line_code">
				품번: <input type="text" id="search_prod_code" name="search_prod_code">
				<input type="submit" value="조회">
			</fieldset>
		</form>
	</div>
		
	<br><br><br>
	
	<div id="body">
		<button id="add" class="true">추가</button>
		<button id="modify">수정</button>
		<button id="delete" class="true">삭제</button>
		<button type="reset" id="cancle">취소</button>
		<button type="submit" id="save">저장</button>
		
		총 <span id="total">${pm.totalCount }</span>건
				
		<select id="perPage" name="perPage">
			<option value="2">2</option>
			<option value="5">5</option>
			<option value="7">7</option>
		</select>
		건씩 표시
		
		<form id="fr">
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
					<th>비고</th>
				</tr>
	
				<c:forEach var="vo" items="${perfList }">
					<tr>
						<td></td>
						<td id="performCode">${vo.perform_code }</td>
						<td>${vo.work_code }</td>
						<td>${vo.workOrder.line_code }</td>
						<td>${vo.workOrder.prod_code }</td>
						<td>${vo.perform_date }</td>
						<td>${vo.perform_qt }</td>
						<td>${vo.perform_fair }</td>
						<td>${vo.perform_defect }</td>
						<td>${vo.defect_note }</td>
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
		
		
		<br><br><br>
		
		
		<div id="pagination">
			<c:if test="${pm.prev }">
				<a href="/performance/performList?page=${pm.startPage - 1 }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}"> ⏪ </a>
			</c:if>
			
			<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
				<a href="/performance/performList?page=${page }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}">${page }</a>
			</c:forEach>
		
			<c:if test="${pm.next }">
				<a href="/performance/performList?page=${pm.endPage + 1 }&search_work_code=${search.search_work_code}&search_fromDate=${search.search_fromDate}&search_toDate=${search.search_toDate}&search_line_code=${search.search_line_code}&search_prod_code=${search.search_prod_code}"> ⏩ </a>
			</c:if>
		</div>
	</div>
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">