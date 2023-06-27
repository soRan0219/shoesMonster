<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
	// 저장 버튼 클릭 시 페이지 이동
	$('form').submit(function() {
		return true;
	});

	//취소버튼 -> 리셋
	$('#cancle').click(function() {
		$('#fr').each(function() {
			this.reset();
		});
	}); //cacle click
</script>

<!-- page content -->
<div class="right_col" role="main">
	
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
	
	<div>
		<div>
			<h6>사원</h6>
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
						<td>${vo.emp_id}</td>
						<td>${vo.emp_name}</td>
						<td>${vo.emp_department}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<form action="" method="post" onsubmit="return false" id="fr">
		<button type="reset" id="cancle">취소</button>
		<input type="submit" value="저장" id="save">
	
		<div>
			<h6>화면 권한</h6>
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
	</form>
	
	<div id="pagination" style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/person/management?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&emp_id=${vo.emp_id }&emp_name=${vo.emp_name }&emp_department=${vo.emp_department }">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/person/management?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&emp_id=${vo.emp_id }&emp_name=${vo.emp_name }&emp_department=${vo.emp_department }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/person/management?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&emp_id=${vo.emp_id }&emp_name=${vo.emp_name }&emp_department=${vo.emp_department }">&gt;</a>
		</c:if>
	</div>

</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>

