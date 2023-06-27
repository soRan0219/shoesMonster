<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	// 팝업으로 열었을 때
	function popUp() {
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		
		var isPop = urlParams.get("input");
		
		if(isPop==="null") {
			isPop = null;
		}
			
		$('#pagination a').each(function(){
			
	   		var prHref = $(this).attr("href");
	   			
				var newHref = prHref + "&input=" + isPop;
				$(this).attr("href", newHref);
				
		}); //페이징 요소	
		
		$('#input').val(isPop);
				
		if(isPop) {
	    	
// 	    	$('#add').hide();
// 	    	$('#modify').hide();
// 	    	$('#delete').hide();
// 	    	$('#save').hide();
	    	
	   		$('table tr:not(:first-child)').click(function(){
	   			
	   			$(this).css('background', '#ccc');
	    			
	    		var lineCode = $(this).find('#lineCode').text();
	    			
	    		$('#'+isPop, opener.document).val(lineCode);
	    			
	    		window.close();
	    	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
	    		
	     		
			} else {
				console.log("팝업아님");
		} //if(팝업으로 열었을 때)
			
	} //popUp()
	
	$(function() {
		popUp();
	});
</script>




<!-- page content -->
<div class="right_col" role="main">

	<h2>라인관리</h2>

	<form action="" method="get">
		
		<input type="hidden" name="input" id="input" value="${input}">
		
		<label>라인코드</label>
			<input type="text" name="line_code"  placeholder="검색어를 입력해주세요" >
			
		<label>라인명</label>
			<input type="text" name="line_name" placeholder="검색어를 입력해주세요">
		
		<br>
		
		<label>사용여부</label>
			<select name="line_use" >
				<option selected value="3">전 체</option>
				<option value="1">Y</option>
				<option value="2">N</option>
			</select>
		
		<label>작업장</label>
			<input type="text" name="line_place" placeholder="검색어를 입력해주세요">
				

		 <input type="submit" value="검색">
	</form>



	<table border="1">
		<tr>	
			<th></th>
			<th>라인코드</th>
			<th>라인명</th>
			<th>작업장</th>
			<th>사용여부</th>
			<th>등록자</th>
			<th>등록일</th>
			<th>비고</th>
		</tr>
		
		<c:forEach var="vo" items="${boardList }" varStatus="i">
				<tr>
					<td>${i.count}</td>
					<td id="lineCode">${vo.line_code}</td>
					<td>${vo.line_name}</td>
					<td>${vo.line_place}</td>
					
					<c:choose>
						<c:when test="${vo.line_use == 1 }">
							<td>Y</td>
						</c:when>
						<c:when test="${vo.line_use == 2 }">
							<td>N</td>
						</c:when>
					</c:choose>
					
					<td>${vo.emp_id}</td>
					<td>${vo.insert_date}</td>
					<td>${vo.line_note}</td>
				</tr>
		</c:forEach>
	</table>
	
	<div id="pagination">
		
		<c:if test="${lwpm.startPage != 1 }"> <!-- pageSize 없는 버전 -->
			<a href="/performance/line?page=${lwpm.startPage-1 }&line_code=${lvo.line_code }&line_name=${lvo.line_name }&line_use=${lvo.line_use }&line_place=${lvo.line_place}">이 전</a>
		</c:if>
		
		<c:forEach begin="${lwpm.startPage }" end="${lwpm.endPage }" step="1" var="page">
			<c:choose>
				<c:when test="${page == lwpm.startPage }">
					<b>${page }</b>
				</c:when>
				<c:when test="${page != lwpm.startPage }">
					<a href="/performance/line?page=${page }&line_code=${lvo.line_code }&line_name=${lvo.line_name }&line_use=${lvo.line_use }&line_place=${lvo.line_place}">${page }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		
		<c:if test="${lwpm.next && lwpm.endPage>0 }">
			<a href="/performance/line?page=${lwpm.endPage+1 }&line_code=${lvo.line_code }&line_name=${lvo.line_name }&line_use=${lvo.line_use }&line_place=${lvo.line_place}">다 음</a>
		</c:if>
		
	</div>



</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>