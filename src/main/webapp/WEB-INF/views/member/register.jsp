<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- jQuery 사용하겠다 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js">
	

</script>


<!-- 다음 우편주소 API 코드 복사해서 가지고 오기 (https://postcode.map.daum.net/guide)-->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function daumPost() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
				// 예제를 참고하여 다양한 활용법을 확인해 보세요.
				
				
				console.log("선택 : "+ data.userSelectedType);
				console.log("로드 : "+data.roadAddress);
				console.log("지번 : " +data.jibunAddress);
				console.log("우편번호 : " +data.zonecode);
				// console창에다가 확인해봄
				
				var addr=""
				
				if(data.userSelectedType=='R'){ // (선택 시 R로 표시) 선택한게 맞다면
					addr = data.roadAddress
				} else{
					addr = data.jibunAddress
				}
				document.getElementById("addr1").value = data.zonecode;
				//현재 페이지(document)에서 html 태그(getElement) 가져오겠다 > id를 가져올 것(byID)
				$("#addr2").val(addr) //addr과 같은 데이터 안에 있는 다른 속성(addr2) 가져오기
				$("#addr3").focus() // 상세 주소(addr3) 입력하라고 그 상자(addr3) 안에 들어가 있음
				// #은 아이디 불러올 때($) 사용
			}
		}).open();
	}
	
	function register(){
		var id = $("#id").val()
		var name=$('#name').val()
		if(id==""){
			alert("아이디는 필수 항목입니다!")
			$("#id").focus()
		}
		if(name==""){
			alert("이름은 필수 항목입니다!")
			$("#name").focus()
		}
		else{
			var addr = $("#addr1").val()+"/"+$("#addr2").val()+"/"+$("#addr3").val()
			// "/"를 통해 주소 구분하기
			$("#addr1").val(addr)
			fo.submit()
			// 해당 form태그 데이터 submit 작동함
		}
		
	}
	
	function pwdChk(){
		var pw1 = $("#pw1").val()
		var pw2 = $("#pw2").val()
		if(pw1==pw2){
			$("#label").html("일치합니다.")
			// html : html 코드 자체를 넣어주겠다는 뜻
		}else{
			$("#pw1").val("")
			$("#pw2").val("") // 작성한 비번 지워짐
			$("#pw1").focus() // 비번 첫번째 칸으로 이동
			document.getElementById("label").innerHTML="<span style='color:red;'>불일치합니다.</span>"
			// innerHTML : html 코드 자체를 넣어주겠다는 뜻
		}
	}
	
</script> <!-- 여기는 javascript임 -->

<!-- 언어 jquery는 javascript과 비슷하지만 처리가 더 빠르다. -->

<!-- SQLDeveloper에 
	alter table membership add 
  	session_id varchar2(100) default 'nan' not null;
	alter table membership add limit_time date; 
해당 코드 입력 후 실행 (자동 로그인을 위함)
 -->

</head>
<body>
	<c:import url="../default/header.jsp" />
	<div class="wrap content">
		<form action="register" id="fo" method="post">
			<table border="1">
				<tr>
					<td><input type="text" name="id" id='id' placeholder="아이디">(*필수항목)<br>
					<input type="text" name="name" id='name' placeholder="이름">(*필수항목)<br>
						<input type="text" name="pw" id="pw1" placeholder="비밀번호"><br>
						<input type="text" id="pw2" placeholder="비밀번호 재입력" onchange="pwdChk()">
						<!-- onchange : 커서가 인풋 박스에서 "벗어나면" pwdChk() 함수 실행해라 -->
						<label id="label"> </label>
						<br>
						<input type="text" name="addr" id="addr1" readonly="readonly">
						<!-- 수정 안되고 읽기만 가능 (읽기 전용) --> 
						<input type="text" id="addr2">
						<input type="text" id="addr3"> 
						<br> 
						<!-- id는 현재 페이지에서 구분하기 위함, name은 다른 파일로 데이터 전송하기 위함 -->
						<button type="button" onClick="daumPost()">주소찾기</button> <!-- MemberDTO에 같은 name 있으면 거기에 저장됨!!! -->
						<hr> <input type="button" value="register" onclick="register()"><br>
						<!-- button은 submit으로 동작할 수 없음 > 데이터 전송 불가 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>