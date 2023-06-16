<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>product</h1>
	<form action="" method="post">
	
		<table border="1">
			<thead>
				<tr>
					<th>번호</th>
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
			</thead>
			<c:forEach var="vo" items="${prodList}">
				<tbody>
					<tr>
						<td></td>
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
			</tbody>
			<tr>
				<td></td>
				<td><input type="text" name="products[0].prod_code"></td>
				<td><input type="text" name="products[0].prod_name"></td>
				<td><input type="text" name="products[0].prod_category"></td>
				<td><input type="text" name="products[0].prod_unit"></td>
				<td><input type="text" name="products[0].prod_size"></td>
				<td><input type="text" name="products[0].prod_color"></td>
				<td><input type="text" name="products[0].client_code"></td>
				<td><input type="text" name="products[0].prod_price"></td>
				<td><input type="text" name="products[0].prod_note"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" name="products[1].prod_code"></td>
				<td><input type="text" name="products[1].prod_name"></td>
				<td><input type="text" name="products[1].prod_category"></td>
				<td><input type="text" name="products[1].prod_unit"></td>
				<td><input type="text" name="products[1].prod_size"></td>
				<td><input type="text" name="products[1].prod_color"></td>
				<td><input type="text" name="products[1].client_code"></td>
				<td><input type="text" name="products[1].prod_price"></td>
				<td><input type="text" name="products[1].prod_note"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" name="products[2].prod_code"></td>
				<td><input type="text" name="products[2].prod_name"></td>
				<td><input type="text" name="products[2].prod_category"></td>
				<td><input type="text" name="products[2].prod_unit"></td>
				<td><input type="text" name="products[2].prod_size"></td>
				<td><input type="text" name="products[2].prod_color"></td>
				<td><input type="text" name="products[2].client_code"></td>
				<td><input type="text" name="products[2].prod_price"></td>
				<td><input type="text" name="products[2].prod_note"></td>
			</tr>

		</table>
		<input type="submit" value="전송">
	</form>



























</body>
</html>