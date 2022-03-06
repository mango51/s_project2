package com.care.root.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.care.root.board.dto.BoardRepDTO;
import com.care.root.board.service.BoardService;
import com.care.root.session_name.MemberSessionName;

@RestController
@RequestMapping("board")
public class BoardRepController implements MemberSessionName {
	@Autowired BoardService bs;
	
	@PostMapping(value="addReply", produces="application/json;charset=utf8")
	public void addReply(
			@RequestBody Map<String, Object> map, HttpSession session) {
		BoardRepDTO dto = new BoardRepDTO();
		dto.setId((String)session.getAttribute(LOGIN));
		// implements MemberSessionName을 통해 LOGIN (아이디) 상속 받을 수 있음
		dto.setWrite_group(Integer.parseInt((String)map.get("write_no")));
		// 가져온 데이터 map에서 게시글 번호 write_no 꺼내서 정수형 만든 후 dto에  write_group에 셋팅하기 >> 답글 달 때 해당 게시글인거 보여주기 위함
		// 답글 저장하는 데이터 dto에서 답글 달 수 있는 해당 게시글 번호 map을 통해 가져와 참조키를 외래키 write_group으로 저장
		dto.setTitle((String)map.get("title"));
		dto.setContent((String)map.get("content"));
		
		bs.addReply(dto);
	}
	@GetMapping(value="replyData/{write_group}", produces="application/json;charset=utf8")
	//replyData/{write_group} : 들어오는 write_group값 가변적이기 때문에 {} 안에 넣어서 표시 >> replyData로 넘어올 때 뒤에 write_group 값도 같이 딸려 들어옴 >> 하지만 값 가변적이라 {} 사용
	public List<BoardRepDTO> replyData(@PathVariable int write_group){ // 해당 게시글의 답글 불러오는 거니까
		return bs.getRepList(write_group); //List<BoardRepDTO> 타입으로 반환 >> 답글 모은 데이터 boardservice > mapper통해 boardmapper에 가서 getRepList()통해 결과값 가져옴 >> 해당 데이터 반환
	}
}
