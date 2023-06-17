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
        });
    </script>

</head>
<body>

	<h1>product</h1>
	<form action="" method="post">
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



























</body>
</html>