<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 정보 관리</title>
</head>
<body>
	

	<h1>거래처 정보 관리</h1>

	거래처코드
	<input type="text"> 거래처명
	<input type="text"> 거래처구분
	<select>
		<option>협력사</option>
		<option>고객사</option>
<!-- 	</select> 사용여부 -->
<!-- 	<select> -->
		<option>Y</option>
		<option>N</option>
	</select>
	<input type="button" value="조회">

	<hr>

	거래처 총 0 건
	<input type="button" value="추가">
	<input type="button" value="수정">
	<input type="button" value="삭제">
	<input type="button" value="취소">
	<input type="button" value="저장">

	<table border="1">
		<tr>
			<th></th>
			<th>거래처코드</th>
			<th>거래처명</th>
			<th>거래처구분</th>
			<th>사업자번호</th>
			<th>업태</th>
			<th>대표자</th>
			<th>담당자</th>
			<th>주소</th>
			<th>상세주소</th>
			<th>전화번호</th>
			<th>휴대폰번호</th>
			<th>팩스번호</th>
			<th>email</th>
			<th>비고</th>
			<th></th>
		</tr>
		
		
		<c:forEach var="vo" items="${clientsList }" varStatus="i">
			<tr>
				<td>${i.count }</td>
				<td>${vo.client_code}"</td>
				<td>${vo.client_actname}</td>
				<td>${vo.client_type}</td>
				<td>${vo.client_number}</td>
				<td>${vo.client_sort}</td>
				<td>${vo.client_ceo}</td>
				<td>${vo.client_name}</td>
				<td>${vo.client_addr}</td>
				<td>${vo.client_addr2}</td>
				<td>${vo.client_tel}</td>
				<td>${vo.client_phone}</td>
				<td>${vo.client_fax}</td>
				<td>${vo.client_email}</td>
				<td>${vo.client_note}</td>
				<td><input type="checkbox"></td>
			</tr>
		</c:forEach>
		
	</table>
<%-- 		${vo.client_useyn} 사용여부 -> 그냥 삭제용으로 쓰는 체크박스 --%>
		
	<!-- 페이징 처리 해야함 -->
	
</body>
</html>