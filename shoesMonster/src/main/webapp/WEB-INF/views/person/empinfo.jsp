<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style type="text/css">
.selected {
	background-color: #ccc;
}
</style>

<script type="text/javascript">
//제이쿼리
$(function() {
	//테이블 항목들 인덱스 부여
	$('table tr').each(function(index) {
		$(this).find('td:first').text(index);
	});
		
	//버튼구현
	//추가
	$('#add').click(function() {

		$('#modify').attr("disabled", true);
		$('#delete').attr("disabled", true);

		//작업지시코드 부여(임시로 그냥 1 증가로 해놓음)
		let wCodeNum = Number($('table tr:last').find('td:nth-child(2)').text().substring(2));
		wCodeNum++;

		//오늘 날짜 -> 등록일, 실적일, ...DB에 now()로 넣을 값
		let today = getToday();

		if ($(this).hasClass('true')) {

			var tbl = "<tr>";
			// 번호
			tbl += " <td>";
			tbl += " </td>";
			// 작업지시코드
			tbl += " <td>";
			tbl += "  <input type='text' name='work_code' id='work_code' readonly value='";
			tbl += "WO" + wCodeNum;
			tbl += "'>";
			tbl += " </td>";
			// 라인코드
			tbl += " <td>";
			tbl += "  <input type='text' name='line_code' id='line_code' required>";
			tbl += " </td>";
			// 품번
			tbl += " <td>";
			tbl += "  <input type='text' name='prod_code' id='prod_code' required>";
			tbl += " </td>";
			// 수주코드
			tbl += " <td>";
			tbl += "  <input type='text' name='order_code' id='order_code' required>";
			tbl += " </td>";
			// 지시상태
			tbl += " <td>";
			tbl += "  <select name='work_state' id='work_state'>";
			tbl += "   <option>지시</option>";
			tbl += "   <option>진행</option>";
			tbl += "   <option>마감</option>";
			tbl += "  </select>"
			tbl += " </td>";
			// 지시일
			tbl += " <td>";
			tbl += "  <input type='text' name='work_date' id='work_date' readonly value='";
			tbl += today;
			tbl += "'>";
			tbl += " </td>";
			// 지시수량
			tbl += " <td>";
			tbl += "  <input type='text' name='work_qt' id='work_qt' required>";
			tbl += " </td>";
			tbl += "</tr>";

			$('table').append(tbl);

			//라인코드 검색
			$('#line_code').click(function() {
				openWindow("line", "line_code");
			}); //lineCode click

			//품번 검색 
			$('#prod_code').click(function() {
				openWindow("prod", "prod_code");
			}); //prodCode click

			//수주코드 검색
			$('#order_code').click(function() {
				openWindow("order", "order_code");
			}); //orderCode click

			$(this).removeClass('true');
		} //true 클래스 있을 때

		// 저장 -> form 제출하고 저장함
		$('#save').click(function() {

			var line_code = $('#line_code').val();
			var prod_code = $('#prod_code').val();
			var order_code = $('#order_code').val();
			var work_state = $('#work_state').val();
			var work_qt = $('#work_qt').val();

			if (line_code == "" || prod_code == "" || order_code == "" || work_state == "" || work_qt == "") {
				alert("항목을 모두 입력하세요");
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
		}); //cacle click
	}); //add click
	//수정
	//삭제


</script>


<!-- page content -->
<div class="right_col" role="main">
	<div style="margin: 5% 0% 0% 12%; width: 88%;">
		<h1>사원 관리</h1>
		<form action="" method="get">
			<fieldset>
	       		<input type="hidden" name="input" id="input" value="${input }">
	       		<label>사원번호</label>
	        		<input type="text" name="search_empid" id="search_empid">
	        	<label>사원명</label>
	        		<input type="text" name="search_empname" id="search_empname">
	        	<label>부서</label>
	        		<input type="text" name="search_empdepartment" id="search_empdepartment"> 
	        		<input type="submit" value="조회">
			</fieldset>
		</form>
	</div>
	
	<!-- 버튼 -->
	<button id="add" class="true">추가</button>
	<button id="modify">수정</button>
	<button id="delete" class="true">삭제</button>
	<button type="reset" id="cancle">취소</button>
	<button type="submit" id="save">저장</button>
	<!-- 버튼 -->
	
	<div style="margin: 5% 12% 0% 12%;">
		<div>
			<h6>사원</h6>
			<table border="1" id="employeesTable">
				<thead>
					<tr>
						<th></th>
						<th>사원번호</th>
						<th>사원명</th>
						<th>부서</th>
						<th>직책</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>입사일자</th>
						<th>재직구분</th>
						<th></th>
					</tr>
				</thead>
				<c:forEach var="vo" items="${empList }" varStatus="i">
					<tr>
						<td>${i.count}</td>
						<td>${vo.emp_id}</td>
						<td>${vo.emp_name}</td>
						<td>${vo.emp_department}</td>
						<td>${vo.emp_position}</td>
						<td>${vo.emp_email}</td>
						<td>${vo.emp_phone}</td>
						<td>${vo.emp_hiredate}</td>
						<td>${vo.emp_work}</td>
						<td>
							<button class="details-btn" data-id="${emp_id }">상세보기</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 페이징 -->
		<div id="pagination"
			style="display: block; text-align: center; width: 50%; margin: 0% 25% 0% 25%">
			<c:if test="${pm.prev }">
				<a
					href="/person/empinfo?page=${pm.startPage - 1 }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">이전
				</a>
			</c:if>

			<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }"
				step="1">
				<a
					href="/person/empinfo?page=${page }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">${page }</a>
			</c:forEach>

			<c:if test="${pm.next }">
				<a
					href="/person/empinfo?page=${pm.endPage + 1 }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">다음
				</a>
			</c:if>
		</div>
		<!-- 페이징 -->
	</div>

</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>

