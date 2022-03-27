package com.care.root.money.controller;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.board.dto.BoardRepDTO;
import com.care.root.board.service.BoardFileService;
import com.care.root.board.service.BoardService;
import com.care.root.member.service.MemberService;


@Controller 
@RequestMapping("money")
public class MoneyController {
	@Autowired MemberService ms;
	@GetMapping("sendMoney") 
	public String sendMoney() { 
		
		return "money/sendMoney"; 
	}
	
	@GetMapping("showMoney") 
	public String showMoney(Model model) { 
		ms.showMoney(model);
		return "money/showMoney"; 
	}
	
	
}
