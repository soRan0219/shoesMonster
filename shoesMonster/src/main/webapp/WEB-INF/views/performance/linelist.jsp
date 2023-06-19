<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 
 <script>
 
 // 서치 기능
 $(document).ready(function () {
	
	 $('#searchButton').click(function () {
		
		 event.preventDefault(); // 페이지 이동 막기
		 
		 var searchCode = $('#searchCode').val().toLowerCase();
		 var searchUse = $('#searchUse option:selected').text();
		 var searchName = $('#searchName').val().toLowerCase();
		 var searchPlace = $('#searchPlace').val().toLowerCase();
		 
		 $('#lineTable tr').each(function () {
			
			 var code = $(this).find('td:nth-child(1)').text().toLowerCase();
			 var name = $(this).find('td:nth-child(2)').text().toLowerCase();
			 var place = $(this).find('td:nth-child(3)').text().toLowerCase();
			 var use = $(this).find('td:nth-child(4)').text().toLowerCase();
			 
			 if(code.includes(searchCode)
				 && name.includes(searchName)
				 && place.includes(searchPlace)
				 && use.includes(searchUse)){
				 
				 $(this).show();
			 
			 }else{
				$(this).hide(); 
			 }
			 
		});
		 
	});
	 
	 
	 
}); // document
 
 
 
 </script>


<h2>라인관리</h2>

	<form action="" method="get">
		<label>라인코드</label>
			<input type="text" id="searchCode" placeholder="검색어를 입력해주세요">
		
		<label>사용여부</label>
			<select name="라인사용여부" id="searchUse">
				<option selected >전 체</option>
				<option value="라인사용Y">1</option>
				<option value="라인사용N">2</option>
			</select>
		
		<br>
		
		<label>라인명</label>
		<input type="text" id="searchName" placeholder="검색어를 입력해주세요">
		
		<label>작업장</label>
		<input type="text" id="searchPlace" placeholder="검색어를 입력해주세요">
			
		<input type="button" id="searchButton" value="검색">
	</form>
	
	<table border="1" id="lineTable">
		<thead>
		<tr>
			<td>라인코드</td>
			<td>라인명</td>
			<td>작업장</td>
			<td>사용여부</td>
			<td>등록자</td>
			<td>등록일</td>
			<td>비고</td>
		</tr>
		</thead>
		
		<c:forEach var="vo" items="${boardList }">
		<tr>
			<td>${vo.line_code}</td>
			<td>${vo.line_name}</td>
			<td>${vo.line_place}</td>
			<td>${vo.line_use}</td>
			<td>${vo.emp_id}</td>
			<td>${vo.insert_date}</td>
			<td>${vo.line_note}</td>
		</tr>
		</c:forEach>
	</table>