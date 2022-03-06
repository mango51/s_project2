<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	<%--배경 색--%>
	<%-- display:none; 우선 안 보이게 하기 --%>
	#model_wrap{ 
		display:none;
		position : fixed; 
		background-color : rgba(0,0,0,0.4);
		top :0; left:0; right:0; 
		width : 100%; height: 100%;
		margin:auto;
		z-index:9;
	}
	<%--높으면 높을 수록 우선순위 z-index 기능--%>
	#first{
		display:none;
		position:fixed; z-index:10;
		margin:auto;
		top:30px; left:0; right:0;
		width:350px;height:450px;
		background-color:rgba(212,244,250,0.9);	
	}
	<%-- 처음에는 안 보였다가 (display:none;) 답글달기 클릭 시 팝업창처럼 뜨는 것 >> slideClick()로 실행 가능하게 만들기--%>
	<%-- z-index:10은 z-index:9보다 우선순위가 높으므로 (값이 더 크기 때문) z-index:10인 first가 z-index:9인 model_wrap보다 더 위에 있음 --%>
	
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%--위의 코드를 통해 jquery문 실행 가능하게 만듦 >> javascript를 통해 해석 가능! --%>
<script type="text/javascript">
	function slideClick(){
		$("#first").slideDown("slow") //first가 slow 천천히 내려옴 (팝업창 천천히 보여짐)
		$("#model_wrap").show() //model_wrap이 바로 show 보여짐 (배경이 딱 보여짐)
	}	
	function slide_hide(){
		$("#first").slideUp("slow") // first 팝업창 위로 빠르게 올라감
		$("#model_wrap").hide() 
		// 배경 숨김  >> first 팝업창은 model_wrap이라는 배경에 감싸져 있기 때문에 배경이 hide()하면 팝업창 first도 바로 사라짐
		// model_wrap 안에 first 있음
	}
	function rep(){
		let form={};
		let arr=$("#frm").serializeArray()
		// frm으로부터 입력 받은 내용 arr에 넣기
		for(i=0;i<arr.length;i++){
			form[arr[i].name]=arr[i].value
		}// 입력 받은 내용 가진 arr을 하나하나 빼서 form 안에 넣기
		
		$.ajax({
			url:"addReply", type:"post", contentType:"application/json; charset=utf-8",
			data:JSON.stringify(form), // 답글로 추가할 / 저장한 데이터 form을 data로 받기 >> 데이터 받아서 문자열 시키기 >> 답글로 저장/추가하기 위해서!!
			success:function(){
				alert('답글 달렸습니다')
				slide_hide() //위에 선언한 함수 사용
				replyData() // 답글 화면에 보이도록 호출
			},
			error:function(){
				alert('문제 발생')
			}
		})
	}
	function replyData(){
		$.ajax({
			url:"replyData/"+${data.writeNo},
			//get방식으로 데이터 넘겨주기 >> 컨트롤러로 넘어가 replyData() 실행하고 결과값 rep에 저장하여 가져오기
			type:"get",data:"json",
			success:function(rep){
				let html =""
				rep.forEach(function(data){ // 가져온 rep의 data 하나하나 빼기
					let date =new Date(data.write_date)
					let dateWrite=""
					dateWrite += date.getFullYear()+"년"
					dateWrite += date.getMonth()+1+"월" //월이 0부터 시작해서 +1 해야함
					dateWrite += date.getDate()+"일"
					dateWrite += date.getHours()+"시"
					dateWrite += date.getMinutes()+"분"
					dateWrite += date.getSeconds()+"초"
					html += "<div align='left'>"
					html+="<b>아이디 : </b>"+data.id+"님 <br>"
					html+="<b>작성일 : </b>"+dateWrite+"<br>"
					html+="<b>제목 : </b>"+data.title+"<br>"
					html+="<b>내용 : </b>"+data.content+"<hr></div>"
				})
				$("#reply").html(html) //#reply에다가 위에서 만든 html을 html형식으로 넣어줌
			},error:function(){
				alert('데이터 가져올 수 없음')
			}
		})
	}
</script>
</head>
<body onload="replyData()">
<!-- 페이지 업로드하면 replyData() 같이 호출됨 >> 답글 데이터가 페이지 새로고침해도 같이 딸려 나옴 >> 해당 페이지 실행과 동시에 같이 body에 replyData() 호출됨!!! -->
<c:import url="../default/header.jsp"/>
<div class="wrap">
	<table border="1">
		<tr>
			<th width="100">글 번호</th>
			<th width="200">${data.writeNo }</th>
			
			<th width="100">작성자</th>
			<th width="200">${data.id }</th>
		</tr>
		<tr>
			<th>제목</th>	<td>${data.title }</td>
			<th>등록일자</th>	<td>${data.saveDate }</td>
		</tr>
		<tr>
			<th> 내용 </th> <td>${data.content }</td>
			<td colspan="2">
				<c:if test="${data.imageFileName=='nan' }">
					<b>이미지가 없습니다</b>
				</c:if>
				<c:if test="${data.imageFileName!='nan' }">
					<img width="200px" height="100px" src ="${contextPath }/board/download?imageFileName=${data.imageFileName}">
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<c:if test="${data.id == loginUser }">
					<%--로그인 되어 있는 사용자와 게시글 작성자와 같은 사람인지 확인 --%>
					<input type="button" onclick="location.href='${contextPath }/board/modify_form?writeNo=${data.writeNo }'" value="수정하기">
					<input type="button" onclick="location.href='${contextPath }/board/delete?writeNo=${data.writeNo }&imageFileName=${data.imageFileName }'" value="삭제하기">
					<%--delete?writeNo=${data.writeNo }&imageFileName=${data.imageFileName } : 삭제할 데이터 (writeNo)와 해당 첨부파일(imageFileName) 함께 삭제하기
					>> 버튼 클릭 시 delete함수로 이동하는데 매개변수로 들고갈 값은 writeNo, imageFileName임 
					>> 해당 공간으로 이동할 때 ?를 통해 뒤에 writeNo, imageFileName 값 가지고 간다!!! ***  --%>
					<%--게시글 작성자와 로그인되어 있는 사용자가 같다면 수정/삭제 권한 주어짐 --%>
				</c:if>
				<input type="button" onclick="slideClick()" value="답글 달기"> <%--페이지 이동 없이 현페이지에서 나오는 팝업창 같은 존재 slideClick() --%>
				<input type="button" value="리스트로 이동" onclick = "location.href='${contextPath }/board/boardAllList'">
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<div id="reply">답글이 없습니다.</div>
			</td>
		</tr>
	</table>
	<div id="model_wrap"> <%--전체 화면 만들기 위해 있음 --%>
	<div id="first">  <%--입력 받기 위해 만든 공간 --%>
		<div style="width:250px; margin:auto; padding-top:20px;">
			<form id="frm">
				<b>글번호 : </b><input type="text" name="write_no" value="${data.writeNo }" readonly> <hr>
				<%--읽기 전용으로 해당 게시글 번호 표시 >> 해당 글에 대한 답글을 달기 위해 표시 --%>
				
				<b>작성자 : </b>${loginUser }<hr>
				
				<b>제목</b><br>
				<input type="text" id="title"name="title" size="30"><hr>
				
				<b>내용</b><br>
				<textarea name="content" id="content" rows="5" cols="30">
				</textarea>
				
				<hr>
				
				<button type="button" onclick="rep()"> 답글 </button>
				<%--상단에 선언한 rep()을 통해  BoardRepController에서 데이터 set하고 > BoardService가서 mapper를 통해 boardmapper 접근하여 addReply 쿼리문 적용 후 결과값 가져와 알림창 띄움 (+답글 저장) --%>
				<button type="button" onclick="slide_hide()"> 취소 </button>
				
				
			</form>
		</div>
	</div>
<div>
	
</div>
</body>
</html>