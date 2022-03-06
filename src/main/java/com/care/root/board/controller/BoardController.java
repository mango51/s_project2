package com.care.root.board.controller;

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

@Controller 
@RequestMapping("board")
public class BoardController {
	@Autowired BoardService bs;
	@GetMapping("boardAllList") //header.jsp의 boardAllList와 연결
	public String boardAllList(Model model, @RequestParam(value="num",required=false, defaultValue="1") int num) { 
		//requestmapping으로 board(BoardMapper.xml)에서 실행된 결과값 가져온 model
		//required=false 이면 num값이 없더라도 0으로 처리함 >> 처음에 들어갈 때는 start 페이지 제공 X ==num값 없음
		//하지만 defaultValue="1"로 디폴트로 num=1로 함
		// 값이 없으면 처음 페이지에 들어감 >> 
		bs.boardAllList(model,num); // DB에서 가져온 결과값 model(board 실행값) 들고 boardservice로 이동해서 해당 메소드 실행
		// num은 페이지 번호 >> 넘기기
		return "board/boardAllList"; //BoardService에서 완성된 bs 결과값을 반영하여 다시 보내기 (요청했던 header.jsp로)
	}
	@GetMapping("writeForm") //board/writeForm를 통해 writeForm.jsp로 이동
	public String writeForm() {
		return "board/writeForm";
	}
	@PostMapping("writeSave")
	public void writeSave(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request) throws IOException{
		String message = bs.writeSave(mul, request); //첨부파일 mul, 입력내용 request
		// bs.writeSave(mul,request)로 boardservice에서 boardfileserviceimpl에서 끝낸 결과값 반환하여 message에 넣기
		PrintWriter out= response.getWriter();
		response.setContentType("text/html; charset=utf-8");
		out.print(message);
	}
	@GetMapping("contentView")
	public String contentView(@RequestParam int writeNo, Model model) {
		bs.contentView(writeNo,model); // 우선 boardservice 로 이동해서 contentView() 실행 하기 >>  보여줄 데이터 (클릭한 해당 게시글 내용) data에 저장됨 완료! 
		return "board/contentView";
	}
	
	@GetMapping("download")
	public void download(
		@RequestParam String imageFileName, HttpServletResponse response) throws Exception{
		response.addHeader("Content-disposition", "attachment; fileName="+imageFileName);
		File file = new File(BoardFileService.IMAGE_REPO+"/"+imageFileName);
		FileInputStream in = new FileInputStream(file);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
	}
	
	@GetMapping("modify_form")
	public String modify_form(@RequestParam int writeNo, Model model) {
		
		bs.contentView(writeNo, model); // boardservice > mapper통해 boardmapper.java에서 boardmapper.xml가서 쿼리문 실행해가지고 옴
		
		return "board/modify_form";
	}
	
	@PostMapping("modify")
	public void modify(MultipartHttpServletRequest mul, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String message = bs.modify(mul,request); //첨부파일 mul과 함께 보내는 내용 request >> boardservice의 modify() 실행 후 결과값 message에 대입
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out= response.getWriter();
		out.print(message);
	}
	
	@GetMapping("delete")
	public void delete(@RequestParam int writeNo, @RequestParam String imageFileName, HttpServletRequest request, HttpServletResponse response) throws Exception{
		// request는 경로 만들어주기 위해서 가져오는 값, response는 결과값 보내기 위함
		String message= bs.boardDelete(writeNo, imageFileName, request);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
}
