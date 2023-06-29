<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>
	
	
	
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
			<input type="text" name="raw_mat.raw_name"  placeholder="검색어를 입력해주세요">
		<label>입고번호</label>
		<input type="text"  name="in_num" placeholder="검색어를 입력해주세요">
		
		<!-- 이것도 옵션으로 바꿀까 생각해보기 -->
		<label>거래처명</label>
		<input type="text"  name="clients.client_actname" placeholder="검색어를 입력해주세요">
			
		<input type="submit" value="검색">
	</form>




	<hr>

	<script>
        document.addEventListener('DOMContentLoaded', function() {
            var buttons = document.querySelectorAll('input[type="button"]');
            for (var i = 0; i < buttons.length; i++) {
                var button = buttons[i];
                var inYNElement = button.parentNode.previousElementSibling;
                button.value = "입고처리";
                inYNElement.innerText = "미입고";
            }
        });
        function changeButtonValue(button) {
            var inYNElement = button.parentNode.previousElementSibling;
            if (button.value === "입고처리") {
                button.value = "입고취소";
                inYNElement.innerText = "입고완료";
            } else {
                button.value = "입고처리";
                inYNElement.innerText = "미입고";
            }
        }
        
      
    </script>

	<form action="" method="post">
	<table border="1">
        <tr>
            <th>입고번호</th>
            <th>발주번호</th>
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

        <c:forEach var="rvo" items="${ro_List }">
            <tr>
                <td>${rvo.in_mat.in_num }</td>
                <td>${rvo.raw_order_num }</td>
                <td>${rvo.clients.client_actname }</td>
                <td>${rvo.raw_code }</td>
                <td>${rvo.rawMaterial.raw_name }</td>
                <td>${rvo.rawMaterial.raw_color }</td>
                <td>${rvo.raw_order_count}</td>
                <td>${rvo.stock.stock_raw_count != null ? vo.stock.stock_raw_count : 0}</td>
                <td>${rvo.rawMaterial.raw_price}원</td>
                <td>${rvo.rawMaterial.raw_price*vo.raw_order_count}원</td>
                <td>${rvo.in_mat.in_date }</td>
                <td>${rvo.emp_id }</td>
				<td>${rvo.in_mat.in_YN}</td>
				<td>
					<button type="submit" name="raw_order_num" value="${rvo.raw_order_num}">입고 처리</button>
				</td>
            </tr>
        </c:forEach>
    </table>
</form>


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


