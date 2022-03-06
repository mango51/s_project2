<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="../default/header.jsp"/> <!-- 위의 헤더 가지고 오기 -->
<div class="wrap" align="center">
	<!-- header.jsp에 있는 css 지정 형식의 wrap 사용하기 -->
	<table border="1">
		<tr>
			<th>순서</th>
			<th>번호</th>
			<th>id</th>
			<th>제목</th>
			<th>날짜</th>
			<th>조회수</th>
			<th>파일이름</th>
		</tr>
		<c:if test="${boardList.size()==0 }">
		<tr><th colspan="6"> 등록된 글 없음 </th></tr>
		</c:if>
		
		<c:set var="noNumber" value="${noNumber}" />
		<c:set var ="noNumb" value="${(noNumber-1)*5+1 }"/>
		<c:forEach items="${boardList }" var="dto">
		
			<tr>
			
				<td>
				 
					<c:out value="${noNumb}"/>
					<c:set var ="noNumb" value="${noNumb+1 }"/>

					
				</td> 
				<td>
					${dto.writeNo }
				</td>
				<td>
					${dto.id }
				</td>
				<td>
					<a href="${contextPath }/board/contentView?writeNo=${dto.writeNo}"> 
					<%-- 제목 클릭 시 contentView.jsp로 이동 >> controller에서 설정하기
					 ?writeNo=#{dto.writeNo} : 이동 시 url에 해당 주소도 함께 입력되어 이동 >> 게시물 번호 같이 주소로 넘어감--> --%>
					 <%-- ***html이 아니라서 주석처리는 %로 해야함 --%>
						${dto.title }
					</a>
				</td>
				<td>
					${dto.saveDate }
				</td>
				<td>
					${dto.hit }
				</td>
				<td>
					${dto.imageFileName }
				</td>
				
			</tr>
			</c:forEach>
		<tr>
			<td colspan="6">
				<c:forEach var = "num" begin="1" end="${repeat }">
					<%--시작은 1페이지로 시작하고 끝페이지는 repeat --%>
					<a href="boardAllList?num=${num }"> [${num }]</a>
				</c:forEach>
			
				<a href="${contextPath }/board/writeForm">글 작성</a>
				<%-- writeForm으로 이동할 수 있게 Controller에다가 지정하기 --%>
			</td>
		</tr>
	</table>
</div>
<c:import url="../default/footer.jsp"/>
</body>
</html>