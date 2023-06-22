<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>



<script>
 
 // 서치 기능
 $(document).ready(function () {
	
	 $('#searchButton').click(function(event) {
		
		 event.preventDefault(); // 페이지 이동 막기
		 
		 var searchCode = $('#searchCode').val().toLowerCase();
		 var searchName = $('#searchName').val().toLowerCase();
		 var searchdepartment = $('#searchdepartment').val().toLowerCase();
		 
		 $('#EmployeesTable tr').each(function () {
			
			 var code = $(this).find('td:nth-child(2)').text().toLowerCase();
			 var name = $(this).find('td:nth-child(3)').text().toLowerCase();
			 var department = $(this).find('td:nth-child(4)').text().toLowerCase();
			 
			 if(code.includes(searchCode)
				 && name.includes(searchName)
				 && place.includes(searchdepartment)
				 ){
				 $(this).show();
				 
			 }else{
				$(this).hide(); 
			 }
		});
	});
	 
}); // document
 
 
</script>


<h2>사원 관리</h2>


<label>사원 번호</label>
	<input type="text" id="searchCode" placeholder=" ( 10자리 )">
<label>사원 명</label>
	<input type="text" id="searchName" placeholder="">
<label>부서</label>
	<input type="text" id="searchdepartment" placeholder="">

<input type="button" id="searchButton" value="조회">

<br><br>

<table border="1" id="lineTable">
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

<br><br>

<div id="employees-details">
	
</div>

<script>
	$(document).ready(function() {
		$('.details-btn').click(function() {
			var employeeId = $(this).data('id');
			$.ajax({
				url : '/employee/' + employeeId,
				type : 'GET',
				success : function(response) {
					$('#employee-details').html(response);
				}
			});
		});
	});
</script>
