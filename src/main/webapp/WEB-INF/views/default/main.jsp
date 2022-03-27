<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page session="false" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<style>

.carousel-item{
    min-height: 280px;
}
.wrapping{
	width : 500px;
	height : 350px;
}
.button {
	width : 130px;
	height : 90px;
  background-color: #3C5A91;
  border: none;
  color: white;
  padding: 20px;
  text-align: bottom;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: auto;
  border-radius: 10px;
  font-weight : bold;
  position: relative; 
  left: 1030px; 
  top: -290px;
  outline:0;
}
.button2 {
	width : 130px;
	height : 90px;
  background-color: #6e6e6e	;
  border: none;
  color: white;
  padding: 20px;
  text-align: bottom;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: auto;
  border-radius: 10px;
  font-weight : bold;
  position: relative; 
  left: 1040px; 
  top: -290px;
  outline:0;
}
button a:hover {
	transition: all 0.15s;
	text-decoration: none;
	color: white;
}
.hoverButton:hover{
	box-shadow: 0px 0px 10px #dcdcdc;
}
button a {
	text-decoration: none;
	color: white;
}
.total{
 	margin-top:-16px;
	width: 100%;
	background-color: rgba( 192, 192, 192, 0.1 );
	
}
</style>
</head>
<body>


      
   	<!-- <img src="${pageContext.request.contextPath}/resources/fin2.jpg" />   -->
 	<!-- 현재 파일의 위치 (상대경로) : pageContext(현 페이지).request(요청하여).contextPath(경로 받음) -->
	
	<div class="total">
<div id="carouselExampleFade" class="carousel slide carousel-fade wrapping" data-bs-ride="carousel" style="position: relative; left: 470px; top:40px;">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="${pageContext.request.contextPath}/resources/fin1.png" class="d-block w-100 wrapping" alt="...">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/resources/fin2.jpg" class="d-block w-100 wrapping" alt="...">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/resources/fin3.jpg" class="d-block w-100 wrapping" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

	
	<a href="${contextPath }/money/sendMoney">
		<button class="button hoverButton" style="color: white;">
			이체
		</button>
	</a>
	
	<a href="${contextPath }/money/showMoney">
		<button class="button2 hoverButton" style="color: white;">
			조회
		</button>
	</a>
	</div>
	
	
</body>
</html>