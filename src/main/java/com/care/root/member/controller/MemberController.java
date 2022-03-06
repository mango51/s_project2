package com.care.root.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.care.root.member.dto.MemberDTO;
import com.care.root.member.service.MemberService;
import com.care.root.member.service.MemberServiceImpl;
import com.care.root.session_name.MemberSessionName;

@Controller //Controller 제어 역할
@RequestMapping("member") //get과 post 방식 둘 다 받을 수 있음
public class MemberController implements MemberSessionName {

	@Autowired MemberService ms;

	@GetMapping("login")
	public String login() {
		return "member/login";
	} // login을 받아 들여서 login.jsp 파일로 이동하기

	@PostMapping("user_check") // member/user_check 내용
	public String userCheck(HttpServletRequest req, RedirectAttributes rs) {
		// ************ 반환타입 void로 해서 첨부파일 없다는 알림 오게 만들기
		// DB 접근하기 위해 서비스(service)와 연결 > 서비스 연결하여 DB 접속
		// Controller 연결용, Service 연산하기 위한 용도
		int result = ms.userCheck(req);
		if (result == 0) {
			rs.addAttribute("id", req.getParameter("id"));
			rs.addAttribute("autoLogin",req.getParameter("autoLogin")); // 요청 값에 자동로그인 설정했는지 안했는지 속성 추가
			return "redirect:successLogin";
		}
		if(result==2) {
			return "redirect:login";
		}
		return "redirect:login";
	}

	@RequestMapping("successLogin")
	public String successLogin(@RequestParam String id, HttpSession session,@RequestParam(required=false) String autoLogin, HttpServletResponse response) {
		session.setAttribute(LOGIN, id);
		if(autoLogin!=null) {
			// 자동로그인 체크했다는 뜻
			int limitTime = 60*60*24*90; //90일
			Cookie loginCookie = new Cookie("loginCookie",session.getId());
			loginCookie.setPath("/"); //패스를 최상위 경로로 두어서 다른 페이지에도 영향 가도록 함 (자동로그인 유지할 수 있겠끔)
			loginCookie.setMaxAge(limitTime);
			response.addCookie(loginCookie);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.add(Calendar.MONTH, 3);
			
			java.sql.Date limitDate = new java.sql.Date(cal.getTimeInMillis());
			
			// 시간 데이터베이스에 넘기기
			ms.keepLogin(session.getId(), limitDate, id);
			// limitDate와 id값을 session.getId()에 넘기기
		}
		return "member/successLogin";
	}
	@GetMapping("logout")
	public String logout(HttpSession session, HttpServletResponse response, @CookieValue(value="loginCookie",required=false) Cookie loginCookie) {
		
		if(loginCookie != null) {
			loginCookie.setMaxAge(0);
			response.addCookie(loginCookie);
			ms.keepLogin("nan", new java.sql.Date(System.currentTimeMillis()), (String) session.getAttribute(LOGIN));
		} // currentTimeMillis() : 현재 시간으로 바꿔줌 
		
		session.invalidate();
		return "redirect:/index";
	}
	
	@GetMapping("memberInfo")
	public String memberInfo(Model model) {
		ms.memberInfo(model);
		return "member/memberInfo";
	}
	
	@GetMapping("info")
	public String info(@RequestParam("id") String userid, Model model) {
		
		//select * from membership where id='aaa'; 이렇게 쿼리문 사용됨 (SQLDeveloper에서 확인 가능)
		
		//요청으로 넘어온 id값을 userid라고 하겠다.
		// 그냥 id라고 하고 싶으면 @RequestParam String id 라고 하면 된다
		System.out.println(userid);
		//info 파일의 id값을 출력하는 것 (info의 id값 = userid)
		ms.info(userid, model); //ms에 userid, model 넘겨주겠다
		
		return "member/info";
	}
	@GetMapping("register_form")
	public String registerForm() {
		return "member/register";
	}
	@PostMapping("register")
	public String register(MemberDTO dto) {
		int result = ms.register(dto);
		if(result==1) {
			return "redirect:login";
		}
		return "redirect:register_form";
		// 회원가입 제대로 안 되면 다시 회원가입 창으로 이동
	}
	
}