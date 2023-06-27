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
			<input type="text" name="prod_code" placeholder="검색어를 입력해주세요">
			<!-- /////수정필요////////////////////////////////////////// -->
		
		<br>

		<label>지역</label>
			<select name="wh_addr" >
				<option selected value="3">전 체</option>
				
					<c:forEach var="addr" items="${whList }">
						<option>${addr.wh_addr.substring(0, 2)}</option>
					</c:forEach>
					<!-- 중복 처리 해야하는뎁 쩝 -->
<!-- 				<option value="1">부산</option> -->
<!-- 				<option value="2">창원</option> -->
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
		<c:if test="${lwpm.prev }">
			<a href="/performance/warehouse?page=${lwpm.startPage-1 }">이 전</a>
		</c:if>
		
		<c:forEach begin="${lwpm.startPage }" 
				   end="${lwpm.endPage }" step="1"
				   varStatus="i">
			
				<a href="/performance/warehouse?page=${i.count }">${i.count }</a>
				   
		</c:forEach>	   
				
		<c:if test="${lwpm.next && lwpm.endPage>0 }">   
			<a href="/performance/warehouse?page=${lwpm.endPage+1 }">다 음</a>
		</c:if>
		
	</div>
	
<%-- ${whList} --%>


</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>

