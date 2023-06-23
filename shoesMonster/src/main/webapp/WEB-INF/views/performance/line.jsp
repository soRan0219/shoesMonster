<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2>라인관리</h2>

	<form action="" method="get">
		
		<label>라인코드</label>
			<input type="text" name="line_code"  placeholder="검색어를 입력해주세요">
		
		<label>사용여부</label>
			<select name="line_use" >
				<option selected value="3">전 체</option>
				<option value="1">Y</option>
				<option value="2">N</option>
			</select>
		
		<br>
		
		<label>라인명</label>
		<input type="text" name="line_name" placeholder="검색어를 입력해주세요">
		
		<!-- 이것도 옵션으로 바꿀까 생각해보기 -->
		<label>작업장</label>
		<input type="text" name="line_place" placeholder="검색어를 입력해주세요">
			

		<input type="submit" value="검색">
	</form>


	
	<table border="1">
		<thead>
		<tr>	
			<td></td>
			<td>라인코드</td>
			<td>라인명</td>
			<td>작업장</td>
			<td>사용여부</td>
			<td>등록자</td>
			<td>등록일</td>
			<td>비고</td>
		</tr>
		</thead>
		
		<c:forEach var="vo" items="${boardList }" varStatus="i">
			<c:if test="${vo.line_use == 1 }">
				<tr>
					<td>${i.count}</td>
					<td>${vo.line_code}</td>
					<td>${vo.line_name}</td>
					<td>${vo.line_place}</td>
					<td>Y</td>
					<td>${vo.emp_id}</td>
					<td>${vo.insert_date}</td>
					<td>${vo.line_note}</td>
				</tr>
			</c:if>
			
			<c:if test="${vo.line_use == 2 }">
				<tr>
					<td>${i.count}</td>
					<td>${vo.line_code}</td>
					<td>${vo.line_name}</td>
					<td>${vo.line_place}</td>
					<td>N</td>
					<td>${vo.emp_id}</td>
					<td>${vo.insert_date}</td>
					<td>${vo.line_note}</td>
				</tr>
			</c:if>
			
		</c:forEach>
	</table>
	
	<div>
<%-- 	${lwpm} --%>
		<c:if test="${lwpm.prev }">
			<a href="/performance/line?page=${lwpm.startPage-1 }">이 전</a>
		</c:if>
		
		<c:forEach begin="${lwpm.startPage }" 
				   end="${lwpm.endPage }" step="1"
				   varStatus="i">
			
				<a href="/performance/line?page=${i.count }">${i.count }</a>
				   
		</c:forEach>	   
				
		<c:if test="${lwpm.next && lwpm.endPage>0 }">   
			<a href="/performance/line?page=${lwpm.endPage+1 }">다 음</a>
		</c:if>
		
	</div>