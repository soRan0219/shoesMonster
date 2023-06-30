<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

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
	// 제이쿼리
	$(function() {
		//테이블 항목들 인덱스 부여
		$('#managementTable tr').each(function(index) {
			$(this).find('td:first').text(index);
		});
		
		//버튼구현
	   	//수정
		$('#modify').click(function() {
			
			// td 요소 중 뒤에서 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
			$('#managementTable tr').each(function() {
				var code = $(this).find('td:nth-last-child(2)').text();
	
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
					checked.push($(this).val());
				});
	
				// 	alert(checked);
	
				if (checked.length > 0) {
	
					$.ajax({
						url : "/workorder/delete",
						type : "post",
						data : {checked : checked},
						dataType : "text",
						success : function() {
							alert("*** 아작스 성공 ***");
							location.reload();
						},
						error : function() {
							alert("아작스실패~~");
						}
					}); //ajax
				} //체크된거 있을대
				else {
					alert("선택된 항목이 없습니다.");
				} //체크된거 없을때
			}); //save
			
			//취소 -> 리셋
			$('#cancle').click(function() {
				$('input:checkbox').prop('checked', false);
			});
		});
	});
</script>

<!-- page content -->
<div class="right_col" role="main">
	<div style="margin: 5% 0% 0% 12%; width: 88%;">
		<h1>권한 관리</h1>
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

	<div>
		<div>
			<div style="float: left; margin: 5% 12% 0% 12%; width: 25%;">
				<h6>사원</h6>
				<table border="1" id="employeesTable">
					<tr>
						<th></th>
						<th>사원번호</th>
						<th>사원명</th>
						<th>부서</th>
						<th></th>
					</tr>
					<c:forEach var="vo" items="${empList }" varStatus="i">
						<tr>
							<td>${i.count }</td>
							<td>${vo.emp_id}</td>
							<td>${vo.emp_name}</td>
							<td>${vo.emp_department}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

		<div style="float: left; margin: 5% 12% 0% 12%; width: 25%">
			<div>
				<button id="modify">수정</button>
				<button type="reset" id="cancle">취소</button>
				<button type="submit" id="save">저장</button>
			</div>
			<h6>화면 권한</h6>
			<table border="1" id="managementTable">
				<tr>
					<th></th>
					<th>대메뉴명</th>
					<th>프로그램명</th>
					<th>화면 권한</th>
					<th></th>
				</tr>
				<c:forEach var="vo" items="${manageList }" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<td>${vo.title}</td>
						<td>${vo.programName}</td>
						<td></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<!-- 페이징 -->
	<div id="pagination" style="display: block; text-align: center; float: left; width: 50%; margin: 0% 25% 0% 25%">
		<c:if test="${pm.prev }">
			<a href="/person/management?page=${pm.startPage - 1 }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">이전 </a>
		</c:if>

		<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }"
			step="1">
			<a href="/person/management?page=${page }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">${page }</a>
		</c:forEach>

		<c:if test="${pm.next }">
			<a href="/person/management?page=${pm.endPage + 1 }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">다음 </a>
		</c:if>
	</div>
	<!-- 페이징 -->


</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>

