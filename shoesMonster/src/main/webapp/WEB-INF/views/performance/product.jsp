<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>product</h1>
	
	<table>
		<tr>
		<th>번호<th>
		<th>품번<th>
		<th>품명<th>
		<th>카테고리<th>
		<th>품목 단위<th>
		<th>컬러<th>
		<th>규격<th>
		<th>거래처코드<th>
		<th>매출단가<th>
		<th>비고<th>
		</tr>
		
		<tr>
		<td></td>		
		<td></td>		
		<td></td>		
		<td></td>		
		<td></td>		
		<td></td>		
		<td></td>		
		<td></td>		
		<td></td>		
		</tr>
		
			
	</table>
	
	
	<form action="" method="post">
	품번 : <input type="text" name="prod_code"><br>
	품명 : <input type="text" name="prod_name"><br>
	category : <input type="text" name="prod_category"><br>
	unit : <input type="text" name="prod_unit"><br>
	size : <input type="text" name="prod_size"><br>
	color : <input type="text" name="prod_color"><br>
	담당자 : <input type="text" name="client_code"><br>
	가격 : <input type="text" name="prod_price"><br>
	비고 : <input type="text" name="prod_note"><br>
	
	<input type="submit" value="전송">
	</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	
	
	
	
</body>
</html>