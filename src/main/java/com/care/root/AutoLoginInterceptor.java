package com.care.root;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.care.root.member.dto.MemberDTO;
import com.care.root.member.service.MemberService;
import com.care.root.session_name.MemberSessionName;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter implements MemberSessionName{
	
	@Autowired
	MemberService ms;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// index 파일(만) 실행되기 전에 먼저 실행하기
		
		Cookie loginCookie=WebUtils.getCookie(request, "loginCookie");
		// Cookie[] cok = request.getCookies(); 이것도 가능 (다양한 값일 경우)
		
		if(loginCookie != null) {
			//자동로그인한다는 반응(값) 있다면
			MemberDTO dto = ms.getUserSession(loginCookie.getValue());
			if(dto!=null) {
				HttpSession session = request.getSession();
				session.setAttribute(LOGIN, dto.getId());
			}
		}
		System.out.println("===== test ===== ");
		return true;
	}
	
}
