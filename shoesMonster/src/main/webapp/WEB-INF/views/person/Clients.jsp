<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%@ include file="../include/header.jsp"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	
	// 거래처 검색
	
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
    	
    	if(isPop!=null && isPop!="") {
    		
    		$('#addButton').hide();
        	$('#updateButton').hide();
        	$('#deleteButton').hide();
        	$('#cancelButton').hide();
        	$('#saveButton').hide();
        	
       		$('table tr:not(:first-child)').click(function(){
       			$(this).css('background', '#ccc');
        		
            		var client_code = $(this).find('#client_code').text();
            		var client_actname = $(this).find('#client_actname').text();
            		var number = isPop.match(/\d+/);
            		
         			$('#'+isPop, opener.document).val(client_code);
         			if(number !=null){
         			$('#client_actname'+number, opener.document).val(client_actname);
         			} else {
         			$('#client_actname', opener.document).val(client_actname);
         			}
        		
        		window.close();
        	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
        		
         		
    		} //if 
    		
    		else {
    			console.log("팝업아님");
    	} //if(팝업으로 열었을 때)
    		
    } //popUp()
    
    $(document).ready(function() {
		popUp();
	});
	
	
	
</script>

<!-- page content -->
<div class="right_col" role="main">
	
	<h1>거래처 정보 관리</h1>

	<form method="get">
		<input type="hidden" name="input" id="input" value="${input }">
		거래처코드
		<input type="text" name="client_code"> 
		거래처명
		<input type="text" name="client_actname">
		거래처구분
		<select name="client_type">
			<option selected value= "전체">전체</option>
			<option value= "발주처">발주처</option>
			<option value= "수주처">수주처</option>
			<option value= "협력사">협력사</option>
		</select> 
	<!-- 	사용여부 -->
	<!-- 	<select> -->
	<!-- 		<option>Y</option> -->
	<!-- 		<option>N</option> -->
	<!-- 	</select> -->
		<input type="submit" value="조회">
	</form>

	<hr>
	
	거래처 총 ${pm.totalCount } 건
	<input type="button" value="추가" id="addButton">
	<input type="button" value="수정" id="updateButton">
	<input type="button" value="삭제" id="deleteButton">
	<input type="button" value="취소" id="cancelButton">
	<input type="button" value="저장" id="saveButton">

	<table border="1" id="clientsTable">
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
		</tr>
		
		<c:forEach var="vo" items="${searchClientsList }" varStatus="i">
			<c:if test="${vo.client_type == '전체' }">
				<tr>
					<td>${i.count }</td>
					<td id="client_code">${vo.client_code}</td>
					<td id="client_actname">${vo.client_actname}</td>
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
				</tr>
			</c:if>
				
			<c:if test="${vo.client_type == '발주처' }">
				<tr>
					<td>${i.count }</td>
					<td id="client_code">${vo.client_code}</td>
					<td id="client_actname">${vo.client_actname}</td>
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
				</tr>
			</c:if>
				
			<c:if test="${vo.client_type == '수주처' }">
				<tr>
					<td>${i.count }</td>
					<td id="client_code">${vo.client_code}</td>
					<td id="client_actname">${vo.client_actname}</td>
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
				</tr>
			</c:if>
			
			<c:if test="${vo.client_type == '협력사' }">
				<tr>
					<td>${i.count }</td>
					<td id="client_code">${vo.client_code}</td>
					<td id="client_actname">${vo.client_actname}</td>
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
				</tr>
			</c:if>
		</c:forEach>
		
	</table>
<%-- 		${vo.client_useyn} 사용여부 -> 그냥 삭제용으로 쓰는 체크박스 --%>
	
	<div id="pagination">
		<c:if test="${pm.prev }">
			<a href="/person/Clients?page=${pm.startPage - 1 }&client_code=${search.client_code}&client_actname=${search.client_actname}&client_type=${search.client_type}"> ⏪ </a>
		</c:if>
		
		<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
			<a href="/person/Clients?page=${page }&client_code=${search.client_code}&client_actname=${search.client_actname}&client_type=${search.client_type}">${page }</a>
		</c:forEach>

		<c:if test="${pm.next }">
			<a href="/person/Clients?page=${pm.endPage + 1 }&client_code=${search.client_code}&client_actname=${search.client_actname}&client_type=${search.client_type}"> ⏩ </a>
		</c:if>
	</div>

	<div id="details"></div>
		
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


