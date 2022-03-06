<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 
										prefix="c" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<%-- model : ${memberList.size() } 
	<!-- 데이터 값 출력 --> --%>
	
	<c:import url = "../default/header.jsp"/>
	<div class="wrap content">
		<table border="1" class="table table-hover">
			<tr>
				<th> 아이디  </th> <th> 비번 </th> <th> 주소 </th>
			</tr>
			
			<c:forEach var = "dto" items ="${memberList }">
				<tr>
					<td>
						<a href="${contextPath }/member/info?id=${dto.getId() }">
							${dto.getId() }
						</a>
					</td>
					<td>${dto.getPw() }</td>
					<td>${dto.getAddr() }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>