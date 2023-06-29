<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style type="text/css">
.selected {
	background-color: #ccc;
}
</style>
<!-- page content -->
<div class="right_col" role="main">

<script type="text/javascript">

	//input으로 바꾸기 
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
		obj.html(inputBox);
	} //inputCng
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";
	
	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/performance/whsearch?type=" + search + "&input=" + inputId;
		var popup = window.open(url, "", popupOpt);
	} //openWindow()



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
		
    	$('#add').hide();
    	$('#modify').hide();
    	$('#delete').hide();
    	$('#save').hide();
    	
   		$('table tr:not(:first-child)').click(function(){
   			$(this).css('background', '#ccc');
    		
   			if(isPop==="wh_code") {
        		var rawCode = $(this).find('#rawCode').text();
        		var prodCode = $(this).find('#prodCode').text();
        		
        		$('#'+isPop, opener.document).val(whCode);
        		$('#raw_code', opener.document).val(rawCode);
        		$('#prod_code', opener.document).val(prodCode);
        		
   			} else {
        		var whCode = $(this).find('#whCode').text();
        		
        		$('#'+isPop, opener.document).val(whCode);
   			}
    		
    		window.close();
    	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
    		
     		
		} //if 
		
		else {
			console.log("팝업아님");
	} //if(팝업으로 열었을 때)
		
} //popUp()


//===========검색==========================
	
	$(function () {
		
	
		//품번 검색 팝업(prod)
		$('#search_prod').click(function() {
			openWindow("prod", "search_prod");
		}); //prodCode click
		
		//품번 검색 팝업(raw)
		$('#search_raw').click(function() {
			openWindow("raw", "search_raw");
		}); //rawCode click

	});
</script>


<!-- /////////////////////////////////////////////////////////////////////////////////// -->
<h2>창고관리</h2>

	<form method="get">
		<fieldset>
			<input type="hidden" name="input" id="input" value="${input }">
			
			<label>창고코드</label>
				<input type="text" name="wh_code"  placeholder="검색어를 입력해주세요">
			
			<label>품번</label> <!-- 품번 팝업창 + 라디오버튼 완제품/원자재 구분 한번 더 -->
					<input type="text" name="prod_code" id="search_prod" placeholder="prod">
					<input type="text" name="raw_code" id="search_raw" placeholder="raw">
			<br>
	
			<label>지역</label>
				<input type="text" name="wh_addr"  placeholder="검색어를 입력해주세요">
			
			<label>사용여부</label>
				<select name="wh_use" >
					<option selected value="3">전 체</option>
					<option value="1">Y</option>
					<option value="2">N</option>
				</select>
				
			<input type="submit" value="검색">
		</fieldset>
	</form>
<!-- /////////////////////////////////////////////////////////////////////////////////// -->
	
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
					<td id="whCode">${ww.wh_code}</td>
					<td>${ww.wh_name}</td>
					<td>${ww.wh_dv}</td>
					
					<c:choose>
						<c:when test="${ww.wh_dv == '원자재'}">
							<td id="rawCode">${ww.raw_code }</td>
							<td>${ww.raw.raw_name }</td>
						</c:when>
						<c:when test="${ww.wh_dv == '완제품'}">
							<td id="prodCode">${ww.prod_code }</td>
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
</form>
	<div>

<!-- /////////////////////////////////////////////////////////////////////////////////// -->
	
	<div id="pagination">
		<c:if test="${lwpm.prev  }"> 
			<a href="/performance/warehouse?page=${lwpm.startPage-1 }&wh_code=${wvo.wh_code}&prod_code=${wvo.prod_code }&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wvo.wh_use}">이 전</a>
		</c:if>
		
		<c:forEach var="page" begin="${lwpm.startPage }" end="${lwpm.endPage }" step="1">
			<a href="/performance/warehouse?page=${page }&wh_code=${wvo.wh_code}&prod_code=${wvo.prod_code }&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wvo.wh_use}">${page }</a>
		</c:forEach>
		
		<c:if test="${lwpm.next }">
			<a href="/performance/warehouse?page=${lwpm.endPage+1 }&wh_code=${wvo.wh_code}&prod_code=${wvo.prod_code }&raw_code=${wvo.raw_code }&wh_addr=${wvo.wh_addr }&wh_use=${wvo.wh_use}">다 음</a>
		</c:if>

	</div>
</div>
<!-- /////////////////////////////////////////////////////////////////////////////////// -->

<!-- /page content -->
<%@ include file="../include/footer.jsp"%>