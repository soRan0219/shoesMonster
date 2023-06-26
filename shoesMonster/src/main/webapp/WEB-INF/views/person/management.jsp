<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%@ include file="../include/header.jsp"%>

<!-- page content -->
<div class="right_col" role="main">

	<h1>권한 관리</h1>

	사원번호
	<input type="text" id=""> 
	사원명
	<input type="text" id=""> 
	부서
	<select id="">
		<option>협력사</option>
		<option>고객사</option>
		<option>수주처</option>
	</select> 
	<input type="button" value="조회" id="searchButton">
	
	<br>
	<input type="button" value="취소" id="cancelButton">
	<input type="button" value="저장" id="saveButton">

	<div>
		<div>
			<h3>사원</h3>
		</div>
		<div>
			<table border="1" id="clientsTable">
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
						<td>${vo.emp_id}"</td>
						<td>${vo.emp_name}</td>
						<td>${vo.emp_department}</td>
						<td><input type="checkbox"></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<div>
		<div>
			<h3>화면 권한</h3>
		</div>
		<div>
			<table border="1" id="clientsTable">
				<tr>
					<th></th>
					<th>대메뉴명</th>
					<th>프로그램명</th>
					<th>화면 권한</th>
					<th></th>
				</tr>
				<c:forEach var="vo" items="${management }" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<td>${vo.title}</td>
						<td>${vo.programName}</td>
						<td><input type="checkbox"></td>
						<td></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>


</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>

