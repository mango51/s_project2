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
</script>
</head>
<body>
 	<c:import url="../default/header.jsp"/>
 	
 	<div style="width:400px; margin:auto;">
 	<h1> 글쓰기</h1>
 	
 	<form method="post"
 	action="${contextPath }/board/writeSave"
 	enctype="multipart/form-data">
 	<!-- multipart/form-data : "파일 전송 시 필요"한 기능 -->
 	<b>작성자</b><br>
 	<input type="text" name="id" value="${loginUser }" readonly> <hr>
 	<!-- readonly : 수정 불가, 오로지 읽기만 가능 -->
 	<!-- ${loginUser } : 현재 로그인된 사용자 이름 -->
 	
 	<b>제목</b><br>
 	<input type="text" size="50" name="title"><hr>
 	
 	<b>내용</b>
 	<textarea rows="10" cols="50" name="content"></textarea> <hr>
 	<!-- textarea : 문자 입력창 기능 -->
 	
 	<b>이미지파일 첨부</b><br> <!-- multipart/form-data사용하여 파일 전송 가능! -->
 	<input type="file" name="image_file_name" onchange="readURL(this)">
 	<!-- onchange="readURL(this)" : 파일에 대한 정보 받아오기 (위의 함수 readURL() 실행) -->
 	<img id="preview" src="#" width="100" height="100" alt="선택 이미지 없음">
 	<!-- readURL() 통해 preview에 input으로 선택한 파일의 경로 preview에 넣어서 해당 이미지파일 보여주기 >> w/ width, height, alt -->
 	<hr>
 	<input type="submit" value="글 등록">
 	<input type="button" value="목록 이동" onclick="location.href='${contextPath}/board/boardAllList'">
 	
 	</form>
 	<c:import url="../default/footer.jsp"/>
</body>
</html>