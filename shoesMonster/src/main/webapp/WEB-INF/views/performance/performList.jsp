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
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";
	
	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/performance/search?type="+search + "&input=" + inputId;
		var popup = window.open(url, "", popupOpt);
	} //openWindow()
	
	
	
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
			
			//생산실적코드 부여(임시로 그냥 1 증가로 해놓음)
			let pCodeNum = Number($('table tr:last').find('td:nth-child(2)').text().substring(2));
			pCodeNum++;
			
			let today = getToday();
			
			if($(this).hasClass('true')) {
				
				var tbl = "<tr>";
				// 번호
				tbl += " <td>"; 
				tbl += " </td>";
				// 생산실적코드
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_code' id='perform_code' readonly value='";
				tbl += "PF" + pCodeNum;
				tbl += "'>";
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' name='work_code' id='work_code' required>";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' name='line_code' id='line_code' required>";
				tbl += " </td>";
				// 품번
				tbl += " <td>";
				tbl += "  <input type='text' name='prod_code' id='prod_code' required>";
				tbl += " </td>";
				// 실적일
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_date' id='perform_date' readonly value='";
				tbl += today;
				tbl += "'>";
				tbl += " </td>";
				// 실적수량
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_qt' id='perform_qt' required>";
				tbl += " </td>";
				// 양품수
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_fair' id='perform_fair' required>";
				tbl += " </td>";
				// 불량수
				tbl += " <td>";
				tbl += "  <input type='text' name='perform_defect' id='perform_defect' required>";
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
		
		
		
		
		
		
		
		
		
		/////////////// 삭제 //////////////////////////////
		$('#delete').click(function(){
			
			$('#add').attr("disabled", true);
			$('#modify').attr("disabled", true);
			
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
				
// 				alert(checked);
				
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
					alert("선택된 글이 없습니다.");
				} //체크된거 없을때
				
			}); //save
			
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
		
		
	}); //jQuery
	
</script>

<!-- page content -->
<div class="right_col" role="main">

	<h1> /performance/performList </h1>
	
	<div>
		<fieldset>
			작업지시코드: <input type="text" id="search_work_code" name="search_work_code">
		</fieldset>
	</div>
		
	<br><br><br>
	
	<button id="add" class="true">추가</button>
	<button id="modify">수정</button>
	<button id="delete">삭제</button>
	<button type="reset" id="cancle">취소</button>
	<button type="submit" id="save">저장</button>
	
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
					<td>${vo.perform_code }</td>
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
	
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>
