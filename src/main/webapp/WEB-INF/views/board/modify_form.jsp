<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function readURL(input){
	var file = input.files[0]	//파일에 대한 정보를 가지고 옴
	console.log(file)
	if(file != ""){ //파일이 비어있지 않다면
		var reader = new FileReader()
		reader.readAsDataURL(file) //파일 reader로 가지고와 불러들이기
		reader.onload = function(e){ //해당 파일 로드하기
		$("#preview").attr("src",e.target.result)
		// preview라는 아이디에다가 가져온 파일 e의 taget의 result(파일의 위치 정보)를 속성으로 지정
		// == preview에 파일 위치 정보 속성으로 지정해주기
	}
	}
}
</script> <%--해당 스크립트 태그는 사진 보여주기 기능 --%>
</head>
<body>
	<%-- 수정하기 클릭한 게시물 정보 가져옴 (controller > boardservice > mapper통해 boardmapper에서 쿼리문 실행하여 가져옴 --%>
	<c:import url ="../default/header.jsp"/>
	<div style="width:300px; margin:auto;">
	<form action = "${contextPath }/board/modify" enctype="multipart/form-data" method="post">
		<input type="hidden" name="writeNo" value="${data.writeNo }">
		<input type="hidden" name="originalFileName" value="${data.imageFileName }">
		<%-- ${data.imageFileName }, ${data.writeNo }처럼 가져온 data 불러옴 --%>
		제목 <input type="text" value="${data.title }" name="title"><hr>
		내용 <textarea rows="5" cols="30" name="content"> ${data.content }</textarea> <hr>
		
		
		<img alt="현재 이미지가 없습니다" src="${contextPath }/board/download?imageFileName=${data.imageFileName}"width="200px"height="100px"id="preview"> 
		<%-- 현재 가지고 있는 해당 이미지 보여주기
		alt="현재 이미지가 없습니다" : 현재 이미지가 없으면 alt값으로 대체할 수 있음 >> 이미지 없으면 "현재 이미지가 없습니다" 나옴(alt값)--%>
		<%--src="다운로드 경로" : 기존 파일명을 통해 이미지 다운로드 경로 (이미지 있는 주소) 가져오기 --%>
		
		<input type="file" name="imageFileName" onchange="readURL(this)"><hr>
		<%--변경할 파일 선택하고 onchange()를 통해 해당 주소값 가져오기 
		수정 안했어도 기존의 파일 가져와서  imageFileName에 넣기--%>
		<input type="submit" value="수정하기">
		<input type="button" onclick="history.back()" value="이전으로 돌아가기"> <%--onclick="history.back()" : 뒤로가기 (contentview로 돌아가기) --%>
	</form>
	</div>
</body>
</html>