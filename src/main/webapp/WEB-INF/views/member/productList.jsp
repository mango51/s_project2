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
				<th> 상품번호  </th> <th> 상품명 </th><th> 상품가격 </th>
			</tr>
			
			<c:forEach var = "dto" items ="${productList }">
				<tr>
					<td>
						
							${dto.getId() }
						
					</td>
					<td>${dto.getName() }</td>
					<td>${dto.getPrice() }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>