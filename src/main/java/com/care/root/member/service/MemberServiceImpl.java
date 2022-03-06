package com.care.root.member.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.care.root.board.service.BoardFileService;
import com.care.root.member.dto.MemberDTO;
import com.care.root.mybatis.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	// 여기는 인터페이스를 오버라이딩 하는 곳!
	@Autowired MemberMapper mapper;
	// 쿼리문 select * from member where id=id;
	
	BCryptPasswordEncoder en = new BCryptPasswordEncoder();

	public int userCheck(HttpServletRequest req) {
		int a = req.getParameter("file").length();
		if(a!=0) {
		MemberDTO dto = mapper.getMember(req.getParameter("id"));
//		System.out.println(dto);
//		System.out.println(dto.getId());
		if(dto!= null) {
			//if(dto.getPw().equals(req.getParameter("pw"))) >> 비번 인코딩 안 된 평문으로 된 비번 확인
			//if(en.matches(rawPassword, encodedPassword)) >> "인수 위치" 기억~! >> 인코딩 된 비번 확인
			if(en.matches(req.getParameter("pw"), dto.getPw()) || dto.getPw().equals(req.getParameter("pw")))
				return 0; // 0이면 성공
		}
		}
		else if(a==0) {
			return 1;
		}
		return 1;
	}
	
	
	public void memberInfo(Model model) {
		model.addAttribute("memberList", mapper.memberInfo());
	}
	public void info(String userid, Model model) {
		//오버라이딩하기
		MemberDTO dto = mapper.getMember(userid);
		System.out.println(dto.getId());
		System.out.println(dto.getPw());
		System.out.println(dto.getAddr());
		model.addAttribute("info", dto);
		// 데이터 dto를 model을 통해  info에 전달
	}
	public int register(MemberDTO dto){ // 오버라이딩!
		System.out.println("암호화 전 : "+dto.getPw());
		
		String securePw = en.encode(dto.getPw());
		
		System.out.println("암호화 후 : "+securePw);
		
		dto.setPw(securePw);
		dto.setSessionId("nan");
		
		try {
			return mapper.register(dto);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public void keepLogin(String sessionId, java.sql.Date limitDate, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sessionId", sessionId);
		map.put("limitDate", limitDate);
		map.put("id",id);
		
		mapper.keepLogin(map);
	}
	
	public MemberDTO getUserSession(String sessionId) {
		return mapper.getUserSession(sessionId);
	}
}





