<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var counter = 0;

            // 추가 버튼 클릭 시 row 생성
            function addRow() {
                var row = '<tr>' +
                    '<td><input type="text" name="products[' + counter + '].prod_code" required></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_name"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_category"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_unit"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_size"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_color"></td>' +
                    '<td><input type="text" name="products[' + counter + '].client_code" required></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_price"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_note"></td>' +
                    '</tr>';

                $('#productTable').append(row);
                counter++;
                
            	 // 테이블이 많이 생성되면 스크롤바 생성
                var table = document.getElementById('productTable');
                table.scrollTop = table.scrollHeight;
            }

            // 버튼 클릭시 addRow() 기능 불러오기
            $('#addButton').click(function() {
                addRow();
            });
            
            
            // 필터링 기능
            $('#filterButton').click(function(event) {
            	 
            	event.preventDefault(); // 페이지 이동 막기
            	 
                var searchCode = $('#searchCode').val().toLowerCase();
                var searchName = $('#searchName').val().toLowerCase();
                var searchCategory = $('#searchCategory').val().toLowerCase();
                var searchUnit = $('#searchUnit').val().toLowerCase();
                
                $('#productTable tr').each(function() {
                    var code = $(this).find('td:nth-child(1)').text().toLowerCase();
                    var name = $(this).find('td:nth-child(2)').text().toLowerCase();
                    var category = $(this).find('td:nth-child(3)').text().toLowerCase();
                    var unit = $(this).find('td:nth-child(4)').text().toLowerCase();
                    
                    if (code.includes(searchCode) 
                    	&& name.includes(searchName) 
                    	&& category.includes(searchCategory) 
                    	&& unit.includes(searchUnit)){
                    	
                        $(this).show();
                        
                    } else {
                    	
                        $(this).hide();
                        
                    }
                });
            });
            
            // 저장 버튼 클릭 시 페이지 이동
            $('form').submit(function() {
               return true;
            });
            
        });
    </script>

</head>
<body>

	<h1>product</h1>
	
	<form action="" method="get">
		<fieldset>
       		<label>품번:</label>
        	<input type="text" name="prod_code" value="">
        	<label>품명:</label>
        	<input type="text" name="prod_name" value="">
        	<br>
        	<label>카테고리:</label>
        	<input type="text" name="prod_category" value=""> 
        	<label>품목 단위:</label>
        	<input type="text" name="prod_unit" value="">
        	<input type="submit" value="검색">
		</fieldset>
	</form>
	
	
	<form action="" method="post" onsubmit="return false">
		<button id="addButton">추가</button>
		<input type="submit" value="저장">
		
	
		
	
		<table border="1" id="productTable">
				<tr>
					<th>품번</th>
					<th>품명</th>
					<th>카테고리</th>
					<th>품목 단위</th>
					<th>컬러</th>
					<th>규격</th>
					<th>거래처코드</th>
					<th>매출단가</th>
					<th>비고</th>
				</tr>
			<c:forEach var="vo" items="${prodList}">
					<tr>
						<td>${vo.prod_code }</td>
						<td>${vo.prod_name }</td>
						<td>${vo.prod_category }</td>
						<td>${vo.prod_unit }</td>
						<td>${vo.prod_color }</td>
						<td>${vo.prod_size }</td>
						<td>${vo.client_code }</td>
						<td>${vo.prod_price }</td>
						<td>${vo.prod_note }</td>
					</tr>
			</c:forEach>

		</table>
		
	</form>
	
	<div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/performance/product?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&prod_unit=${vo.prod_unit }">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/performance/product?nowPage=${p }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&prod_unit=${vo.prod_unit }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/performance/product?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&prod_unit=${vo.prod_unit }">&gt;</a>
		</c:if>
	</div>



</body>
</html>