<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2>창고관리</h2>

	<form action="" method="get">
		
		<label>창고코드</label>
			<input type="text" name="wh_code"  placeholder="검색어를 입력해주세요">
		
		<label>품번</label>
			<input type="text" name="" placeholder="검색어를 입력해주세요">
		
		<br>
		
		<label>창고명</label>
		<input type="text" name="wh_name" placeholder="검색어를 입력해주세요">
				
		<label>지역</label>
			<select name="wh_addr" >
				<option selected value="3">전 체</option>
				<option value="1">부산</option>
				<option value="2">창원</option>
			</select>
		
		<label>사용여부</label>
			<select name="wh_use" >
				<option selected value="3">전 체</option>
				<option value="1">Y</option>
				<option value="2">N</option>
			</select>
			
		<input type="submit" value="검색">
	</form>
	
	<table border="1">
		<tr>
			<td>창고코드</td>
			<td>창고명</td>
			<td>창고유형</td>
			<td>품번</td>
			<td>품명</td>
			<td>지역</td>
			<td>전화번호</td>
			<td>사용여부</td>
			<td>비고</td>
		</tr>
		
		<c:forEach var="ww" items="${whList }">
			<tr>
				<td>${ww.wh_code}</td>
				<td>${ww.wh_name}</td>
				<td>${ww.wh_dv}</td>
				
        <td><c:choose>
            <c:when test="${empty ww.prod_code && !empty ww.raw_code}">
                <c:set var="itemName" value="${ww.raw.raw_name}" />
            </c:when>

            <c:when test="${empty ww.raw_code && !empty ww.prod_code}">
                <c:set var="itemName" value="${ww.prod.prod_name}" />
            </c:when>
            
            <c:otherwise>
                <c:set var="itemName" value="" />
            </c:otherwise>
        </c:choose></td>
				
				
				<td>${ww.wh_addr}</td>
				<td>${ww.wh_tel}</td>
				<td>${ww.wh_use}</td>
				<td>${ww.wh_note}</td>
			</tr>
		</c:forEach>
	</table>
${whList}