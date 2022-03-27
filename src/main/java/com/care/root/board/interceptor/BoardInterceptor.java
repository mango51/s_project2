package com.care.root.board.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.care.root.session_name.MemberSessionName;

public class BoardInterceptor extends HandlerInterceptorAdapter implements MemberSessionName{
	//extends HandlerInterceptorAdapter : interceptor 구현하기 위함
	//implements MemberSessionName : 로그인 성공했는지 확인용

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		System.out.println("인터셉터");
		if(session.getAttribute(LOGIN)==null) {
			System.out.println("로그인 안되어있음");
			//로그인하지 않았을 경우
			response.setContentType("text/html;charset=utf-8"); //사용자에게 html 문자열 형태로 응답할 것임
			PrintWriter out = response.getWriter(); //응답할 내용(보낼 내용) getWriter()사용하여 출력 가능한 형태로 만들기 >> 변수 out에 대입
			out.print("<script> alert('로그인 먼저 진행해주세요'); location.href='"+request.getContextPath()+"/member/login';</script>"); 
			//script 태그로 보내서 브라우저에서 html 해석해서 출력하기
			//location.href='이동할 경로' >> 경로 변경하기 위한 코드
			//request.getContextPath() : 상대경로
			///member/login : 절대경로
			return false; //로그인 안된 경우 false 리턴하기 (writeForm.jsp로 연결해주지 않음)
		}
		return true;
	}
	
	
}
