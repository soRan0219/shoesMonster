<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style type="text/css">
.selected {
	background-color: #ccc;
}
</style>

<script type="text/javascript">
	//========================= 함수, 상수 ==================================//


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
	    	
	    	$('#add').hide();
	    	$('#modify').hide();
	    	$('#delete').hide();
	    	$('#save').hide();
	    	
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
	
	//========================= 함수, 상수 ==================================//
	
	// 제이쿼리
	$(function() {
		popUp();
		
		
		
		
	
	
	//============================ 버튼 구현 ====================================//	
	
	// 추가
	$('#add').click(function () {
		
		$('#modify').attr("disabled", true);
		$('#delete').attr("disabled", true);
		
		// 라인코드 부여
		let wCodeNum = Number($('table tr:last').find('td:nth-child(2)').text().substring(2));
		
		// 오늘날짜 -> 등록일
		let today = getToday();
		
		if($(this).hasClass('true')){
			
			var tbl = "<tr>";
			
			// 번호
			tbl += "<td>";
			tbl += "</td>";
			
			// 라인코드 
			tbl += " <td>";
// 			tbl += " <input type='text' name='wh_code' id='wh_code' readonly value='";
			tbl += " <input type='text' name='wh_code' id='wh_code'";
			tbl += "L >"; 
// 			tbl += "'>";
// 			tbl += ">";
			tbl += " </td>";
			
			// 라인명
			tbl += " <td>";
			tbl += " <input type='text' name='line_name' id='line_name' required>"
			tbl += " </td>";
			
			// 작업장
			tbl += " <td>";
			tbl += "  <input type='text' name='line_place' id='line_place' required>";
			tbl += " </td>";
			
			// 사용여부
			tbl += " <td>";
			tbl += " <select name='line_use' id='line_use'>";
			tbl += " <option>1</option>";
			tbl += " <option>2</option>";
			tbl += " </select>";
			tbl += " </td>";
			
			// 등록자			
			tbl += " <td>";
			tbl += " <input type='text' name='emp_id' id='emp_id' required>";
			tbl += " </td>";
			
			// 등록일			
			tbl += " <td>";
			tbl += " <input type='text' name='insert_date' readonly value='";
			tbl += today;
			tbl += "'>";
			tbl += " </td>";

			// 비고			
			tbl += " <td>";
			tbl += " <input type='text' name='line_note' id='line_note' required>";
			tbl += " </td>";
			tbl += " </tr>";
		
			$('table').append(tbl);
			
			// 등록자(사원) 검색
			$('#emp_id').click(function () {
				openWindow("emp", "emp_id");
			}); // #emp_id click
			
			$(this).removeClass('true');
		}// if (true 클래스 있을 때)
		
		//---------------------------------------
		// 저장
		$('save').click(function () {
			
			var line_code = $('#line_code').val();
			var line_name = $('#line_name').val();
			var line_place = $('#line_place').val();
			var line_use = $('#line_use').val();
			var emp_id = $('#emp_id').val();
			var line_note = $('#line_note').val();
			
			if(line_code == "" || line_name == "" || line_place == "" || line_use == ""
					|| emp_id == ""){
				alert("항목을 모두 입력하세요");
			}else{
				$('#fr').attr("action", "/line/add");
				$('#fr').attr("method", "post");
				$('#fr').submit();
			}
			
		}); //저장 save
		
		// 취소버튼 (=리셋)
		$('#cancle').click(function () {
			$('#fr').each(function () {
				this.reset();
			});
		}); // cancle click
		
		
	});// 추가 add click
	
	
	
	});// 제이쿼리
</script>

<!-- //////////////////////////////////////////////////////////////////////// -->
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

<!-- //////////////////////////////////////////////////////////////////////// -->	
	
	<button id="add" class="true">추가</button>
	<button id="modify" >수정</button>
	<button id="delete" class="true">삭제</button>
	<button type="reset" id="cancle" >취소</button>
	<button type="submit" id="save">저장</button>

<!-- //////////////////////////////////////////////////////////////////////// -->	

<form id="fr">
	<table border="1">
	<a>총 ${lwpm.totalCount } 건</a>
		<tr>	
			<th>번호</th>
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
</form>
<!-- //////////////////////////////////////////////////////////////////////// -->	
	
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

<!-- //////////////////////////////////////////////////////////////////////// -->

</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>