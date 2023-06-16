<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>라인관리</h2>

	<form action="" method="get">
		라인코드
		<input type="text" placeholder="검색어를 입력해주세요">
		
		사용여부
			<select name="라인사용여부">
				<option selected >전 체</option>
				<option value="라인사용Y">Y</option>
				<option value="라인사용N">N</option>
			</select>
		<br>
		라인명
		<input type="text" placeholder="검색어를 입력해주세요">
		작업장
		<input type="text" placeholder="검색어를 입력해주세요">
			
		<input type="button" value="검색">
	</form>
	
	<table border="1">
		<tr>
			<td>라인코드</td>
			<td>라인명</td>
			<td>작업장</td>
			<td>사용여부</td>
			<td>등록자</td>
			<td>등록일</td>
			<td>비고</td>
		</tr>
		
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