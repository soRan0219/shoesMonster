<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>
	
	<script type="text/javascript">
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";
	
	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/stock/In_material?type="+search;
		var popup = window.open(url, "", popupOpt);
		
		popup.onload = function() {
// 			popup.postMessage(value, '*');
			popup.postMessage({inputId:inputId}, '*');
		};
	} //openWindow()
	
	
	
		//라인코드 검색 팝업
		$('#search_in_num').click(function(){
			openWindow("in_num", "search_in_num");
		}); //lineCode click
		
		//품번 검색 팝업
		$('#search_raw_name').click(function(){
			openWindow("raw_name", "search_raw_name");
		}); //prodCode click

		//발주 번호 검색 팝업
		$('#search_raw_order_num').click(function(){
			openWindow("raw_order_num", "search_raw_order_num");
		}); //raw_order_num click
		
		//조회버튼	
		$('#search').click(function(){
		
			let search = {
					in_num:$('#search_in_num').val(),
					raw_name:$('#search_raw_name)').val(),
					to_date:$('#search_toDate').val(),
					work_state:$('#search_state:checked').val(),
					prod_code:$('#search_prod').val()
			};
			
// 			console.log(search);
			
			$.ajax({
				url:"/stock/search",
				type: "post",
				contentType: "application/json; charset=UTF-8",
				dataType: "json",
				data: JSON.stringify(search),
				success: function(data) {
					
					//data => List 객체
					if(data.length != 0) {
						//검색 결과 있을 때
						for(var i=0; i<data.length; i++) {
							console.log(data[i].in_material);
							
							//th 밑에 있던 줄 모두 제거하고 검색결과 append
							var tbl = "<tr>";
							tbl += " <td>" + data[i].in_num + "</td>";
							tbl += " <td>" + data[i].client_actname + "</td>";
							tbl += " <td>" + data[i].raw_code + "</td>";
							tbl += " <td>" + data[i].raw_color + "</td>";
							tbl += " <td>" + data[i].raw_order_count + "</td>";
							tbl += " <td>" + data[i].stock_raw_count + "</td>";
							tbl += " <td>" + data[i].raw_price + "</td>";
							tbl += " <td>" + data[i].raw_price*raw_order_count + "</td>";
							tbl += " <td>" + data[i].in_date + "</td>";
							tbl += " <td>" + data[i].emp_id + "</td>";
							tbl += " <td>" + data[i].in_YN + "</td>";
							tbl += "</tr>";
							
							if(i==0) {
								$('table tr:gt(0)').remove();
								$('table').append(tbl);
							} else {
								$('table').append(tbl);
							}
							
						} //for
					} else {
						//검색 결과 없을 때
						$('#body').html("검색 결과가 없습니다.");
					} //if(검색결과 있없)
					
				},
				error: function() {
					alert("조회 실패~~");
				}
			}); //ajax
			
		}); //search click
	</script>
	
<!-- page content -->
<div class="right_col" role="main">
	
	<h1>입고 관리</h1>

	<button type="submit">전체</button>
	<button type="submit">미입고</button>
	<button type="submit">입고 완료</button>

	
	
	<hr>
	
<!-- 	입고 번호 <input type="text" valeu="in_num" placeholder="입고 번호를 입력하세요."> -->
<!-- 	거래처명 <input type="text"  valeu="clien_name" placeholder="거래처명을 입력하세요."> -->
<!-- 	품명 <input type="text" valeu="raw_name" placeholder="품명을 입력하세요."> -->
<!-- 	입고 날짜 <input type="date"> ~ <input type="date"> -->
<!-- 	<button type="submit">검색</button> -->

<form action="" method="get">
		
		<label>품명</label>
			<input type="text" name="raw_name"  placeholder="검색어를 입력해주세요">
		
		
		<label>입고번호</label>
		<input type="text"  name="in_num" placeholder="검색어를 입력해주세요">
		
		<!-- 이것도 옵션으로 바꿀까 생각해보기 -->
		<label>발주번호</label>
		<input type="text"  name="raw_order_num" placeholder="검색어를 입력해주세요">
			
		<input type="submit" id="searchButton" value="검색">
	</form>




	<hr>

	<table border="1">
		<tr>
			<th>입고번호</th>
			<th>거래처명</th>
			<th>품번</th>
			<th>품명</th>
			<th>색상</th>
			<th>발주 수량</th>
			<th>재고 수량</th>
			<th>단가</th>
			<th>총액</th>
			<th>입고일</th>
			<th>담당자</th>
			<th>입고 버튼</th>
		</tr>

		<c:forEach var="in" items="${In_materialList }">

			<tr>
				<td>${in.in_num }</td>
				<td>${in.clients.client_actname }</td>
				<td>${in.rawOrder.raw_code }</td>
				<td>${in.raw_mat.raw_name }</td>
				<td>${in.raw_mat.raw_color }</td>
				<td>${in.rawOrder.raw_order_count }</td>
				<td>${in.stock.stock_raw_count }</td>
				<td>${in.raw_mat.raw_price}원</td>
        		<td>${in.raw_mat.raw_price*in.rawOrder.raw_order_count}원</td>
				<td>${in.in_date }</td>
				<td>${in.rawOrder.emp_id }</td>
				<td><button type="submit">${in.in_YN }</button></td>
			</tr>
		</c:forEach>
	</table>

	<div>
    <c:if test="${count > 0 }">
        <c:if test="${startPage > pageBlock }">
            <span><a href="/stock/In_material?num=${startPage - pageBlock}">이전</a></span>
        </c:if>
    
        <c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
            <a href="/stock/In_material?num=${i }">${i }</a>
        </c:forEach>
        
        <c:if test="${endPage < count }">
            <a href="/stock/In_material?num=${startPage + pageBlock}">다음</a>
        </c:if>
    </c:if>
    
</div>


</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


