<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>

<!-- page content -->
<div class="right_col" role="main">

<h2>창고관리</h2>

	<form action="" method="get">
		
		<label>창고코드</label>
			<input type="text" name="wh_code"  placeholder="검색어를 입력해주세요">
		
		<label>품번</label> <!-- 품번 팝업창 + 라디오버튼 완제품/원자재 구분 한번 더 -->
			<c:set var="inputcode" value="${empty prod_code? 'raw_code' : 'prod_code' }"/>
			<c:set var="inputcode" value="${empty raw_code? 'prod_code' : 'raw_code' }"/>
				<input type="text" name="${inputcode}" placeholder="검색어를 입력해주세요">
				
		<br>

		<label>지역</label>
<!-- 			<select name="wh_addr" > -->
<!-- 				<option selected>전 체</option> -->
				
<%-- 					<c:forEach var="addr" items="${whList }"> --%>
<%-- 						<option>${addr.wh_addr.substring(0, 2)}</option> --%>
<%-- 					</c:forEach> --%>
					<!-- 중복 처리 해야하는뎁 쩝 -->
<!-- 				<option >부산</option> -->
<!-- 				<option >창원</option> -->
<!-- 			</select> -->
			<input type="text" name="wh_addr"  placeholder="검색어를 입력해주세요">
		
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
			<td></td>
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
	  
		<c:forEach var="ww" items="${whList }" varStatus="i">
				<tr>	
					<td>${i.count }</td>
					<td>${ww.wh_code}</td>
					<td>${ww.wh_name}</td>
					<td>${ww.wh_dv}</td>
					
					<c:choose>
						<c:when test="${ww.wh_dv == '원자재'}">
							<td>${ww.raw_code }</td>
							<td>${ww.raw.raw_name }</td>
						</c:when>
						<c:when test="${ww.wh_dv == '완제품'}">
							<td>${ww.prod_code }</td>
							<td>${ww.prod.prod_name }</td>
						</c:when>
					</c:choose>
					
					<td>${ww.wh_addr}</td>
					<td>${ww.wh_tel}</td>
				
					<c:choose>	
						<c:when test="${ww.wh_use == 1}">
							<td>Y</td>
						</c:when>
						<c:when test="${ww.wh_use == 2}">
							<td>N</td>
						</c:when>
					</c:choose>
				
					<td>${ww.wh_note}</td>
				</tr>
		</c:forEach>
	</table>

	<div>
<%-- <c:if test="${wvo.prod_code } != null && ${wvo.prod_code } != '' "> --%>

		<c:if test="${lwpm.startPage != 1 }"> 
			<a href="/performance/warehouse?page=${lwpm.startPage-1 }&wh_code=${wvo.wh_code}&prod_code=${wvo.prod_code }&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wh_use}">이 전</a>
		</c:if>
		
		<c:forEach begin="${lwpm.startPage }" end="${lwpm.endPage }" step="1" var="page">
			<c:choose>
				<c:when test="${page == lwpm.startPage }">
					<b>${page }</b>
				</c:when>
				<c:when test="${page != lwpm.startPage }">
<%-- 					<a href="/performance/warehouse?page=${page }&wh_code=${wvo.wh_code}&prod_code=${wvo.prod_code }&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wh_use}">${page }</a> --%>
					<a href="/performance/warehouse?page=${page }&wh_code=${wvo.wh_code}&inputcode=${inputcode }&wh_addr=${wvo.wh_addr }&wh_use=${wh_use}">${page }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		
		<c:if test="${lwpm.next && lwpm.endPage>0 }">
			<a href="/performance/warehouse?page=${lwpm.endPage+1 }&wh_code=${wvo.wh_code}&prod_code=${wvo.prod_code }&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wh_use}}">다 음</a>
		</c:if>

<%-- 	<c:if test="${wvo.raw_code } != null && ${wvo.raw_code } != '' "> --%>
	
<%-- 			<c:if test="${lwpm.startPage != 1 }">  --%>
<%-- 			<a href="/performance/warehouse?page=${lwpm.startPage-1 }&wh_code=${wvo.wh_code}&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wh_use}">이 전</a> --%>
<%-- 		</c:if> --%>
		
<%-- 		<c:forEach begin="${lwpm.startPage }" end="${lwpm.endPage }" step="1" var="page"> --%>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${page == lwpm.startPage }"> --%>
<%-- 					<b>${page }</b> --%>
<%-- 				</c:when> --%>
<%-- 				<c:when test="${page != lwpm.startPage }"> --%>
<%-- 					<a href="/performance/warehouse?page=${page }&wh_code=${wvo.wh_code}&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wh_use}">${page }</a> --%>
<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
<%-- 		</c:forEach> --%>
		
<%-- 		<c:if test="${lwpm.next && lwpm.endPage>0 }"> --%>
<%-- 			<a href="/performance/warehouse?page=${lwpm.endPage+1 }&wh_code=${wvo.wh_code}&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wh_use}}">다 음</a> --%>
<%-- 		</c:if> --%>
	
	
	
	
	
<%-- 	</c:if> --%>

<%-- </c:if> --%>
	</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>