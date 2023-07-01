<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1> 생산실적 현황</h1>
	
	<c:forEach var="line" items="${status.perLine }">
		라인: ${line.workOrder.line_code }
		생산수량: ${line.perform_qt }
		양품수: ${line.perform_fair }
		불량수: ${line.perform_defect }
		<br>
	</c:forEach>
	<hr>
	<c:forEach var="prod" items="${status.perProd }">
		품목: ${prod.workOrder.line_code }
		생산수량: ${prod.perform_qt }
		양품수: ${prod.perform_fair }
		불량수: ${prod.perform_defect }
		<br>
	</c:forEach>
	<hr>
	<c:forEach var="date" items="${status.perDate }">
		생산일자: ${date.workOrder.line_code }
		생산수량: ${date.perform_qt }
		양품수: ${date.perform_fair }
		불량수: ${date.perform_defect }
		<br>
	</c:forEach>
	
	
	
	
</body>
</html>