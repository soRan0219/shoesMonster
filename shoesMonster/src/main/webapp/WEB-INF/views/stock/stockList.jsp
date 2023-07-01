<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%@ include file="../include/header.jsp"%>

<!-- page content -->
<div class="right_col" role="main">

	<h1> 재고 관리 </h1>
	
	<input type="button" value="전체" onclick=""></input>
	<input type="button" value="원자재" onclick=""></input>
	<input type="button" value="완제품" onclick=""></input>
	
	<hr>

		<form action="" method="get">
		제품코드 <input type="text" placeholder="제품코드를 입력하세요"> 
		제품명 <input type="text" placeholder="제품명을 입력하세요"> 
		창고 코드 <input type="text" name="wh_code" placeholder="창고코드를 입력하세요">
		<button type="submit">검색</button>
		</form>


	<table border="1">
    <tr>
 		<th>유형</th>
 		<th>제품 코드</th>
 		<th>제품명</th>
 		<th>재고 수량</th>
 		<th>실제 수량</th>
 		<th>창고 코드</th>
 		<th>담당자</th>
 		<th>수정 버튼</th>
 	</tr>
 	<tr>
 		<th></th>
 		<th></th>
 		<th></th>
 		<th></th>
 		<th></th>
 		<th></th>
 		<th></th>
 	</tr>
<%--         <c:forEach var="s" items="${stockList }"> --%>
        
<%--         <c:if test="${s.wh_dv  == '완제품'}"> --%>
<!--             <tr> -->
<%--                 <td>${s.product.prod_code}</td> --%>
<%--         		<td>${s.product.prod_name}</td> --%>
<%--         		<td>${s.stock_raw_count}</td> --%>
<!--                 <td><input type="text"></td> -->
<%--                 <td>${s.wh_dv}</td> --%>
<%--         		<td>${s.wh_code}</td> --%>
<%--         		<td>${s.wh_name}</td> --%>
<!--         		<td><input type="button"></td> -->
<!--             </tr> -->
<%--             </c:if> --%>
            
<%--             <c:if test="${s.wh_dv  == '원자재'}"> --%>
<!--             <tr> -->
<%--                 <td>${s.raw_mat.raw_code}</td> --%>
<%--         		<td>${s.raw_mat.raw_name}</td> --%>
<%--         		<td>${s.stock_raw_count}</td> --%>
<%--                 <td>${s.wh_name}</td> --%>
<!--                 <td><input type="text"></td> -->
<%--                 <td>${s.wh_dv}</td> --%>
<%--         		<td>${s.wh_name}</td> --%>
<%--         		<td>${s.wh_code}</td> --%>
<!--         		<td><input type="button"></td> -->
<!--             </tr> -->
<%--             </c:if> --%>
<%--         </c:forEach> --%>
    </table>
   
           		
<div>
    <c:if test="${count3 > 0 }">
    	<c:if test="${startPage > pageBlock }">
    		<span><a href="/stock/stockList?num=${startPage - pageBlock}">이전</a></span>
    	</c:if>
	
		<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
			<a href="/stock/stockList?num=${i }">${i }</a>
		</c:forEach>
		
		<c:if test="${endPage < count3 }">
			<a href="/stock/stockList?num=${startPage + pageBlock}">다음</a>
		</c:if>
    </c:if>
</div>

</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>