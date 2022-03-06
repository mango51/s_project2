package com.care.root.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.root.member.dto.MemberDTO;

public interface MemberService{
	public int userCheck(HttpServletRequest req);
	public void memberInfo(Model model);
	public void info(String userid, Model model); //리턴값이 없으니까 void로 변경함
	public int register(MemberDTO dto);
	public void keepLogin(String sessionId, java.sql.Date limitDate, String id);
	public MemberDTO getUserSession(String sessionID);
}