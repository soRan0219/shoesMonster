<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">
	
	// ==================================== 버튼 =================================================
	// 추가
	//날짜 + 시간 + 분 + 초 ==> 코드
    function codeCreation() {
		
    	Date.prototype.getYearYY = function(){
            var a = this.getYear();
            return a >= 100 ? a-100 : a;
          }
		
        var date = new Date();
        var YY_year = date.getYearYY();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        var time = ("0" + date.getHours()).slice(-2);
        var minute = ("0" + date.getMinutes()).slice(-2);
        var second = ("0" + date.getSeconds()).slice(-2);

        return YY_year + month + minute + second;
    }
	
	$(document).ready(function(){
		
	$('#addButton').click(function() {
// 			alert("제발");
			$('#updateButton').attr("disabled", true);
			$('#deleteButton').attr("disabled", true);

			if ($(this).hasClass('true')) {

				var tbl = "<tr>";
				// 번호
				tbl += " <td>";
				tbl += " </td>";
				// 거래처 코드
				tbl += " <td>";
				tbl += "  <input type='text' name='client_code'' id='client_code' readonly>";
				tbl += " </td>";
				// 거래처명
				tbl += " <td>";
				tbl += "  <input type='text' name='client_actname' id='client_actname' required>";
				tbl += " </td>";
				// 거래처 구분
				tbl += " <td>";
				tbl += "  <select name='client_type' id='client_type'>";
				tbl += "   <option>선택</option>";
				tbl += "   <option>수주처</option>";
				tbl += "   <option>발주처</option>";
				tbl += "  </select>"
				tbl += " </td>";
				// 사업자 번호
				tbl += " <td>";
				tbl += "  <input type='text' name='client_number' id='client_number' required>";
				tbl += " </td>";
				// 업태
				tbl += " <td>";
				tbl += "  <input type='text' name='client_sort' id='client_sort' required>";
				tbl += " </td>";
				// 대표자
				tbl += " <td>";
				tbl += "  <input type='text' name='client_ceo' id='client_ceo' required>";
				tbl += " </td>";
				// 담당자
				tbl += " <td>";
				tbl += "  <input type='text' name='client_name' id='client_name' required>";
				tbl += " </td>";
				// 주소
				tbl += " <td>";
				tbl += "  <input type='text' name='client_addr' id='client_addr' required>";
				tbl += " </td>";
				// 상세주소
				tbl += " <td>";
				tbl += "  <input type='text' name='client_addr2' id='client_addr2' required>";
				tbl += " </td>";
				// 전화번호
				tbl += " <td>";
				tbl += "  <input type='text' name='client_tel' id='client_tel' required>";
				tbl += " </td>";
				// 휴대폰번호
				tbl += " <td>";
				tbl += "  <input type='text' name='client_phone' id='client_phone' required>";
				tbl += " </td>";
				// 팩스번호
				tbl += " <td>";
				tbl += "  <input type='text' name='client_fax' id='client_fax' required>";
				tbl += " </td>";
				// email
				tbl += " <td>";
				tbl += "  <input type='text' name='client_email' id='client_email' required>";
				tbl += " </td>";
				// 비고
				tbl += " <td>";
				tbl += "  <input type='text' name='client_note' id='client_note' required>";
				tbl += " </td>";
				tbl += "</tr>";

				$('table').append(tbl);
				
				
				$("#client_type").on("change", function(){
				if($("#client_type option:selected").val() === '수주처' ){
					$('input[name="client_code"]').val('OR'+codeCreation());
				} else if($("#client_type option:selected").val() === '발주처' ){
					$('input[name="client_code"]').val('CL'+codeCreation());
				}
				
				});
				
				$(this).removeClass('true');
			} // true 클래스 있을 때

			// 저장 -> form 제출하고 저장함
			$('#saveButton').click(function() {

				var client_code = $('#client_code').val();
				var client_actname = $('#client_actname').val();
				var client_type = $('#client_type').val();
				var client_number = $('#client_number').val();
				var client_sort = $('#client_sort').val();
				var client_ceo = $('#client_ceo').val();
				var client_name = $('#client_name').val();
				var client_addr = $('#client_addr').val();
				var client_addr2 = $('#client_addr2').val();
				var client_tel = $('#client_tel').val();
				var client_phone = $('#client_phone').val();
				var client_fax = $('#client_fax').val();
				var client_email = $('#client_email').val();
				var client_note = $('#client_note').val();

// 				if (client_code == "" || client_actname == "" || client_type == "" || client_number == "" || client_sort == "" 
// 						|| client_ceo == "" || client_name == "" || client_addr == "" || client_addr2 == "" || client_tel == "" 
// 						|| client_phone == "" || client_fax == "" || client_email == "" || client_note == "") {
// 					alert("항목을 모두 입력하세요");
// 				} else {
					$('#fr').attr("action", "/person/addClient");
					$('#fr').attr("method", "post");
					$('#fr').submit();
// 				}

			}); //save

			//취소버튼 -> 리셋
			$('#cancelButton').click(function() {
				$('#fr').each(function() {
					this.reset();
				});
			}); // cancle click

		}); // add click

		
		var isExecuted = false;
	
	// ==================================== 버튼 =================================================
	
	
	}); // JQuery
</script>

<!-- page content -->
<div class="right_col" role="main">
	
	<h1>거래처 정보 관리</h1>

	<form method="get">
		거래처코드
		<input type="text" name="search_client_code" id="search_client_code"> 
		거래처명
		<input type="text" name="search_client_actname" id="search_client_actname">
		거래처구분
		<select name="search_client_type">
			<option selected value= "전체">전체</option>
			<option value= "발주처">발주처</option>
			<option value= "수주처">수주처</option>
		</select> 
		<input type="submit" value="조회">
	</form>

	<hr>
	
	거래처 총 ${pm.totalCount } 건
	<input type="button" value="추가" id="addButton" class="true">
	<input type="button" value="수정" id="updateButton">
	<input type="button" value="삭제" id="deleteButton">
	<input type="button" value="취소" id="cancelButton">
	<input type="button" value="저장" id="saveButton">
	
<!-- 	<button id="addButton" class="true">추가</button> -->
<!-- 	<button id="updateButton">수정</button> -->
<!-- 	<button id="deleteButton" class="true">삭제</button> -->
<!-- 	<button type="reset" id="cancelButton">취소</button> -->
<!-- 	<button type="submit" id="saveButton">저장</button> -->

	<form id = "fr">
		<table border="1" id="clientsTable">
			<tr>
				<th>번호</th>
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
						<td>${vo.client_code}</td>
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
					</tr>
				</c:if>
					
				<c:if test="${vo.client_type == '발주처' }">
					<tr>
						<td>${i.count }</td>
						<td>${vo.client_code}</td>
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
					</tr>
				</c:if>
					
				<c:if test="${vo.client_type == '수주처' }">
					<tr>
						<td>${i.count }</td>
						<td>${vo.client_code}</td>
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
					</tr>
				</c:if>
				
			</c:forEach>
			
		</table>
	</form>
	
	search : ${search }

	<div id="pagination">
		<c:if test="${pm.prev }">
			<a href="/person/Clients?page=${pm.startPage - 1 }&search_client_code=${search.search_client_code}&search_client_actname=${search.search_client_actname}&search_client_type=${search.search_client_type}"> ⏪ </a>
		</c:if>
		
		<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
			<a href="/person/Clients?page=${page }&search_client_code=${search.search_client_code}&search_client_actname=${search.search_client_actname}&search_client_type=${search.search_client_type}">${page }</a>
		</c:forEach>

		<c:if test="${pm.next }">
			<a href="/person/Clients?page=${pm.endPage + 1 }&search_client_code=${search.search_client_code}&search_client_actname=${search.search_client_actname}&search_client_type=${search.search_client_type}"> ⏩ </a>
		</c:if>
	</div>

<%-- 		<c:if test="${pm.startPage != 1 }"> <!-- pageSize 없는 버전 --> --%>
<%-- 			<a href="/person/Clients?page=${pm.startPage-1 }&search_client_code=${search.client_code}&search_client_actname=${search.client_actname}&search_client_type=${search.client_type}"> ⏪ </a> --%>
<%-- 		</c:if> --%>
		
<%-- 		<c:forEach begin="${pm.startPage }" end="${pm.endPage }" step="1" var="page"> --%>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${page == pm.startPage }"> --%>
<%-- 					<b>${page }</b> --%>
<%-- 				</c:when> --%>
<%-- 				<c:when test="${page != pm.startPage }"> --%>
<%-- 					<a href="/person/Clients?page=${page }&search_client_code=${search.client_code}&search_client_actname=${search.client_actname}&search_client_type=${search.client_type}">${page }</a> --%>
<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
<%-- 		</c:forEach> --%>
		
<%-- 		<c:if test="${pm.next && pm.endPage>0 }"> --%>
<%-- 			<a href="/person/Clients?page=${pm.endPage+1 }&search_client_code=${search.client_code}&search_client_actname=${search.client_actname}&search_client_type=${search.client_type}"> ⏩ </a> --%>
<%-- 		</c:if> --%>

	<div id="details"></div>
		
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


