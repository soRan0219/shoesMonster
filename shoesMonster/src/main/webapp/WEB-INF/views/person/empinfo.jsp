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
	
	//날짜 + 시간 + 분 + 초 ==> 코드
    function codeCreation() {
    	Date.prototype.getYearYY = function(){
    		 var a = this.getYear();
    		 return a >= 100 ? a-100 : a;
   		}
        var date = new Date();
        var YY_year = date.getYearYY();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        var time = ("0" + date.getHours()).slice(-2);
        var minute = ("0" + date.getMinutes()).slice(-2);
        var second = ("0" + date.getSeconds()).slice(-2);

        return YY_year + month + minute + second;
    }
	
	//추가 버튼
	$('#add').click(function() {
		$('#modify').attr("disabled", true);
		$('#delete').attr("disabled", true);
		
		if ($(this).hasClass('true')) {
			
			var tbl = "<tr>";
			// 번호
			tbl += " <td>";
			tbl += " </td>";
			// 사원번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_id' id='emp_id' readonly>";
			tbl += " </td>";
			// 사원명
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_name' id='emp_name' required>";
			tbl += " </td>";
			// 부서
			tbl += " <td>";
			tbl += "  <select name='emp_department' id='emp_department'>";
			tbl += "   <option>부서</option>";
			tbl += "   <option>영업팀</option>";
			tbl += "   <option>생산팀</option>";
			tbl += "   <option>인사팀</option>";
			tbl += "  </select>"
			tbl += " </td>";
			// 직책
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_position' id='emp_position' required>";
			tbl += " </td>";
			// 이메일
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_email' id='emp_email' required>";
			tbl += " </td>";
			// 전화번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_phone' id='emp_phone' required>";
			tbl += " </td>";
			// 입사일자
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_hiredate' id='emp_hiredate' required>";
			tbl += " </td>";
			// 재직구분
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_work' id='emp_work' required>";
			tbl += " </td>";
			tbl += "</tr>";

			$('table').append(tbl);

			$("#emp_department").on("change", function(){
	            if($("#emp_department option:selected").val() === '영업팀' ){
	                $('input[name="emp_id"]').val('SA'+codeCreation());
	            } else if($("#emp_department option:selected").val() === '생산팀' ){
	                $('input[name="emp_id"]').val('PD'+codeCreation());
	            } else if($("#emp_department option:selected").val() === '인사팀' ){
	                $('input[name="emp_id"]').val('HR'+codeCreation());
	            }
	        });
			
			$(this).removeClass('true');
		} //true 클래스 있을 때
		
		// 저장 -> form 제출하고 저장함
		$('#save').click(function() {
			
			var emp_name = $('#emp_name').val();
			var emp_department = $('#emp_department').val();
			var emp_position = $('#emp_position').val();
			var emp_email = $('#emp_email').val();
			var emp_phone = $('#emp_phone').val();
			var emp_hiredate = $('#emp_hiredate').val();
			var emp_work = $('#emp_work').val();

			if (emp_name == "" || emp_department == "" || emp_position == "" || emp_email == "" || emp_phone == "" || emp_emp_work == "") {
				alert("항목을 모두 입력하세요");
			} else {
				$('#fr').attr("action", "/person/add");
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

});
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
	        		  <select name="search_empdepartment">           
					     <option selected value="전체">전체</option>    
					     <option value="영업팀">영업팀</option>    
					     <option value="생산팀">생산팀</option>
					     <option value="인사팀">인사팀</option>
					  </select>
				<input type="submit" value="조회"> 
			</fieldset>
		</form>
	</div>
	
	<div style="margin: 5% 12% 0% 12%;">
		<div style="text-align-last: right;">
			<button id="add" class="true">추가</button>
			<button id="modify">수정</button>
			<button id="delete" class="true">삭제</button>
			<button type="reset" id="cancle">취소</button>
			<button type="submit" id="save">저장</button>
		</div>
		<div>
			<h6>사원</h6>
			<form id = "fr">
				<table border="1" id="employeesTable" style="width: 100%">
				<colgroup>
				    <col style="width: 25px">
				    <col style="width: 100px">
				    <col style="width: 75px">
				    <col style="width: 50px">
				    <col style="width: 50px">
				    <col style="width: 150px">
				    <col style="width: 150px">
				    <col style="width: 100px">
				    <col style="width: 75px">
				    <col style="width: 75px">
				</colgroup>
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
			</form>
		</div>
		
		<!-- 페이징 -->
		<div id="pagination"
			style="display: block; text-align: center; width: 50%; margin: 0% 25% 0% 25%">
			<c:if test="${pm.prev }">
				<a
					href="/person/empinfo?page=${pm.startPage - 1 }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">이전
				</a>
			</c:if>

			<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }"	step="1">
				<a href="/person/empinfo?page=${page }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">${page }</a>
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

