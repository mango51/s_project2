<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.login-container{
    margin-top: 5%;
    margin-bottom: 5%;
    content-align:center;
    border: 1px solid #646464;
}
.login-form-1{
    padding: 5%;
}
.login-form-1 h3{
    text-align: center;
    color: #646464;
}
.login-form-2{
    padding: 5%;
    
}
.login-form-2 h3{
    text-align: center;
    color: #646464;
}
.login-container form{
    padding: 10%;
}
.btnSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    border: none;
    cursor: pointer;
}
.login-form-1 .btnSubmit{
    font-weight: 600;
    color: #fff;
    background-color: #0062cc;
}
.login-form-2 .btnSubmit{
    font-weight: 600;
    color: #fff;
    background-color: #646464;
    text-align:center;
}
.login-form-2 .ForgetPwd{
    color: #646464;
    font-weight: 600;
    text-decoration: none;
}
.login-form-1 .ForgetPwd{
    color: #646464;
    font-weight: 600;
    text-decoration: none;
}


.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border:none;
    width: 78%;
    color: #999999;
}
.filebox label {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #999999;
    cursor: pointer;
    height: 40px;
    margin-left: 10px;
}
.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
.login-form-2 input::file-selector-button{
	display: none;
}
</style>
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
<c:import url="../default/header.jsp" />
<div class="container login-container">
	<form action="${contextPath }/member/user_check" method="post">
            <div class="wrap row">
            
                <div class="login-form-2">
                            <label class="btnSubmit" for="input-file" onchange="readURL(this)">
                            	금융인증서 확인
                            </label>
    						<input type="file" id="input-file" name="file"/>	
    						
                    
                </div>
                <div class="login-form-1">
                   
                    
                    
                        <div class="form-group">
                            <input type="text" class="form-control" name="id" placeholder="아이디" />
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" name="pw"  placeholder="비밀번호" />
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btnSubmit" value="로그인" />
                        </div>
                        <div class="form-group">
                            <a href="#" class="ForgetPwd">Forget Password?</a>
                        </div><br>
                        <a href="${contextPath }/member/register_form"> 회원가입 </a>
                        <br> <input type="checkbox"name="autoLogin"> 자동로그인 
                    
                </div>
            </div>
           </form>
        </div>
        </body>
        </html>