<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:import url="../default/header.jsp" />
	<div class="wrap content">
		<table border="1" style="width:300px; margin: auto;">
			<tr>
				<th>아이디</th>
				<th>${info.getId() }</th>
			</tr>
			<tr>
				<th>비밀번호</th>
				<th>${info.pw}</th>
			</tr>
			<tr>
				<th>주소</th>
				<th>${info.addr}</th>
				<!-- info.addr이거나 info.getAddr()나 상관없음 -->
			</tr>
		</table>
	</div>
</body>
</html>