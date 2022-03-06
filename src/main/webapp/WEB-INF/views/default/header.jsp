<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- value="${pageContext.request.contextPath} => 현재 설정된  path로 변경해줌 (가변적, 동적)
		/root는 현재 실행하는 컴퓨터에서만 실행 가능 >> 다른  컴퓨터에서 실행될 때는 주소가 다름 (다른 컴퓨터에서 해당 프로젝트 가져오기 때문에 path가 다름)
	 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style type="text/css">
* {
	margin: 5;
}

.title {
	
	font-size: 15pt;
	text-align: left;
	
	font-weight : bold;
	color: gray;
	font-family: 맑은 고딕;
	border-bottom: none;
	float:left;
	margin-top:10px;
}

.content {
	margin-top: 50px;
}

.wrap {
	width: 1000px;
	margin: auto;
}

.header {
	width: 1000px;
}

.navdiv {
	width: 100%;
	border-bottom : 1px solid #1E90FF;
	padding-top : 20px;
	
}
.setting{
	 margin-left: 30px;
     margin-right: 30px;
     }

nav {

	width: 1000px;
	height : 50px;
}

nav ul {
	list-style: none;
	display: flex;
	justify-content: center;
}

nav ul li {
	padding: 10px;
	
}

nav ul li a {
	text-decoration: none;
	color: black;
}

nav ul li a:hover {
	color: #1E90FF;
	font-weight : bold;
	transition: all 0.15s;
	text-decoration: none;
}
</style>
<!-- .으로 시작하는 것은 클래스 선택자임!!! >> 클래스 속성 설정! 
 	*는 모두 적용하기 
	margin: auto => 중간 정렬하기 (디폴트)
	. 없으면 태그에 대한 이야기임! > nav이면 nav태그와 관련된 속성 지정! 
	list-style : none; 이면 점 빼는 것
	display: flex;이면 해당 내용들 "가로" 배치임!
	justify-content: end;는 끝으로 몰아내기! 
	nav ul li a => nav > ul > li > a태그에 대한 설정
	text-decoration: none; => a태그의 밑줄 없애기
	nav ul li a:hover => 마우스를 a태그에 가져다대면 반응
	border-bottom:2px dotted black; => 밑줄이 점선 블랙임
	transition: all 0.25s; => 0.25초 안에 모든 것을 수행해라 (조금 느려질 수도 있음)
	text-shadow:10px(양옆 : 오른쪽이면 양수) 10px(위아래 : 아래로 하려면 양수) 15px(뿌연 정도) black(그림자 색상);
	font-family: Gabriola => 폰트체 바꾸기
	.content{margin-top: 50px; => 내용 입력 시 속성 적용 (.content)
	-->
</head>
<body>

	<!--  <div class="wrap">
		<div class="header">
			<h1 class="title">횸스은행</h1>
		</div>
	</div>-->

	<div class="navdiv">
		<div class="wrap">
		<a href="${contextPath }/index"> <h1 class="title">횸인은행</h1> </a>
			<nav>
				<ul>

					<li class="setting">
						서비스
					</li>
					
					<li class="setting">
						상품
					</li>

					<li class="setting">
						<a href="${contextPath }/board/boardAllList">고객센터</a>
					</li>
					
					<li class="setting">
						<%--<c:choose>
							<c:when test="${loginUser != null}">
								<a href="${contextPath }/member/memberInfo"> MEMBER_SHIP </a>
							</c:when>
							<c:otherwise>
								<a href="${contextPath }/member/login"> MEMBER_SHIP </a>
							</c:otherwise>
						</c:choose>  --%>
						
						<a href="${contextPath }/member/memberInfo"> 마이페이지 </a>
					</li>

					<li class="setting">
						<c:choose>
							<c:when test="${loginUser != null}">
								<a href="${contextPath }/member/logout"> LOGOUT </a>
							</c:when>
							<c:otherwise>
								<a href="${contextPath }/member/login"> LOGIN </a>
							</c:otherwise>
						</c:choose>
					</li>
					<%-- ${contextPath }로 다른 컴퓨터가 접근할 때도 주소 변할 때 대응 가능 (가변적) > /root는 프로젝트 만든 해당 컴퓨터에서만 작동 가능한 주소 --%>
				</ul>
			</nav>
		</div>
	</div>
	<p></p>
</body>
</html>