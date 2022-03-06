package com.care.root.board.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.board.dto.BoardDTO;
import com.care.root.board.dto.BoardRepDTO;
import com.care.root.mybatis.board.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired BoardMapper mapper; //DB와 연동되는 mapper
	@Autowired BoardFileService bfs;
	public void boardAllList(Model model, int num) { //BoardMapper.xml의 board를 통해서 가져온 DB 쿼리문 실행 값 model
		//오버라이딩
		
		int pageLetter = 5; //한 페이지에 5개의 글(객체)를 보여주겠다.
		int allCount = mapper.selectBoardcount(); //게시글 총 갯수를 가져오기 >> allCount를 통해 총 몇 페이지 필요할지 파악하기
		int repeat = allCount / pageLetter; //글이 5개 미만일 때는 1페이지 필요 >> 나머지는 나눈 몫 +1 만큼 총 페이지 필요 >이를 해결하기 위해 밑에 if문 사용
		if(allCount % pageLetter!=0)
			repeat +=1;
		// repeat는 필요한 페이지 수, num은 요청하는 페이지 
		int end = num*pageLetter;
		int start = end+1-pageLetter;
		// 현재 있는 페이지의 첫번째 글과 끝 글 번호
		
		int noNumber = num;
		
		model.addAttribute("noNumber", noNumber);
		model.addAttribute("repeat",repeat);
		model.addAttribute("allCount",allCount);
		model.addAttribute("boardList",mapper.boardAllList(start,end));
		// header.jsp > boardController.java에서 온 model(DB 값)에 boardList라는 속성 추가  + 속성값은 BoardMapper형 mapper의 boardAllList()를 통해 가져오기
		// mapper로 DB 접속하여(mapper xml파일로 이동) select문 실행
	}
	public String writeSave(MultipartHttpServletRequest mul, HttpServletRequest request) {
		BoardDTO dto = new BoardDTO();
		dto.setId(mul.getParameter("id"));
		dto.setTitle(mul.getParameter("title"));
		dto.setContent(mul.getParameter("content"));

		MultipartFile file = mul.getFile("image_file_name");
		if(file.getSize()!=0) {
			//파일이 선택되어 있을 경우 >> 데이터 내의 첨부파일 있을 경우 (파일이 존재하는 경우)
			dto.setImageFileName(bfs.saveFile(file));
			// boardserviceimpl 파일에서의 savefile() 함수 실행하기
		}else {
			dto.setImageFileName("nan");
			// 이미지 파일 없으니 파일명 nan으로 설정
		}
		int result=0;
		
		//DB 접근하는 코드는 try-catch문으로 묶는 것이 좋음
		try{
			result = mapper.writeSave(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		// 해당 데이터 dto를 가지고 boardmapper.xml에서 writesave에 저장된 쿼리문 기능 실행
		
		String msg, url;
		if(result==1) {
			//성공적으로 저장
			msg="새 글이 추가되었습니다.";
			url="/board/boardAllList";
			// boardAllList로 이동
		}else {
			// 저장 실패 (result=0)
			msg= "저장 실패";
			url="/board/writeForm";
		}
		return bfs.getMessage(request,msg,url);
	}
	public void contentView(int writeNo, Model model) {
		// 오버라이딩
		model.addAttribute("data",mapper.contentView(writeNo));
		// BoardMapper.java > BoardMapper.xml에서 쿼리문 실행 >> 나온 결과값을 data에 넣어줌 (model의 data 속성값으로 넣어줌)
		// model.addAttribute("속성",mapper.contentView(writeNo));
		// data라는 속성에 DB연동한 mapper(boardmapper.java > boardmapper.xml)의 contentView(쿼리문 실행)를 통해 
		// DB에서 가져온 객체(저장한 DTO 데이터)들 data에 저장! (model 안에 data 속성값)
		upHit(writeNo); //밑의 함수 upHit()를 통해 글 번호 넘겨주면 조회수 +1
		
		//contentView 실행 시 data에 데이터 저장하고, writeNo를 통해 upHit() 메소드도 실행
	}
	private void upHit(int writeNo) {
		mapper.upHit(writeNo);
		// DB 연동한 mapper (boardmapper.xml)에서 upHit() 함수 적용 w/ writeNo 가지고 가서 (게시물 번호 가지고 가서 조회수 증가)
	} // contentView() 안에서 실행되니 private을 사용
	
	public String modify(MultipartHttpServletRequest mul, HttpServletRequest request) {
		BoardDTO dto = new BoardDTO();
		dto.setWriteNo(Integer.parseInt(mul.getParameter("writeNo")));
		// 수정할 게시글 정보 dto에 넣기 >> dto의 게시글 번호 (writeNo)에 넣기 위해 가져온 요청값 mul의 기존 게시글 번호를 정수형으로 변환하여 dto의 게시글 번호 (writeNo)에 넣어두기
		// 밑에도 동일한 방법
		dto.setTitle(mul.getParameter("title"));
		dto.setContent(mul.getParameter("content"));
		
		MultipartFile file = mul.getFile("imageFileName"); //mul 안의 imageFileName을 통해 파일 가져오기 >> file에 넣기
		
		if(file.getSize()!=0){//파일 있으면
			dto.setImageFileName(bfs.saveFile(file));
			bfs.deleteImage(mul.getParameter("originalFileName")); //기존 파일 없애고 수정한 파일 덮어씌우기 
			// 수정 안했더라도 originalFileName은 imageFileName(최근 파일명)에 저장되어 있음
			
			// 1. 파일 있으면 >> 수정 안하고 원래 파일 있을 수도, 수정 파일 있을 수도 있음
			// 2. 수정 안한 파일도 imageFileName으로 기존 originalFileName 넣어둠
			// 3. 그래야지 originalFileName 지우고 imageFileName으로 진행할 수 있음
			
		}else {
			dto.setImageFileName(mul.getParameter("originalFileName")); //기존 파일명 (원래 있던 파일명으로 넣어줌)
		}
		
		int result = mapper.modify(dto); // 수정이 성공적으로 성공 시 1로 반환!!!
		// mapper를 통해 boardmapper의 modify() 쿼리문 실행하여 결과값을 result로 받아옴 >> 성공 시 1 결과값으로 나옴
		String msg, url; //알림 내용과 알림을 보내는 곳을 위해 변수 설정
		if(result==1) {
			msg="수정 성공";
			url="/board/boardAllList";
		}else {
			msg="수정 실패";
			url="/board/modify_form?writeNo="+dto.getWriteNo();
			// 컨트롤러를 보면 modify_form(@RequestParam int writeNo, >> 매개변수로 writeNo 받고 있음
			// 실패시 "기존의" 수정페이지로 돌아가야하니까 해당 게시글 번호의 창으로 가야하니 매개변수로 writeNo 필요
			// 그래서 실패시 페이지 이동 시 writeNo 값도 같이 넘겨줘야함
			// >> 그래서 url="/board/modify_form?writeNo="+dto.getWriteNo(); 로 dto.getWriteNo()를 통해 writeNo값 넘겨주기!!!
		}
		return bfs.getMessage(request, msg, url);
		// bfs를 통해 BoardFileServiceImpl에서 getMessage() 함수 실행
		// request : 요청한 데이터 (수정하기 위해 입력한 글 내용), msg : 수정 기능 성공 여부에 따라 달라지는 알림 내용, url : 수정 기능 성공 여부에 따라 이동하는 페이지 주소
		// 매개변수 넘기면서 request을 통해 요청 받은 곳의 주소 받아옴 >> 그래야 정보 받아올 수 있음!!!
	}
	
	public String boardDelete(int writeNo, String imageFileName, HttpServletRequest request) {
		// 오버라이딩
		int result = mapper.delete(writeNo);
		// 해당 게시글 번호 writeNo를 통해 삭제하기 >> mapper 통해 쿼리문에서 실행!
		String msg, url;
		
		if(result==1) {
			msg = "삭제 성공";
			url = "/board/boardAllList";
			bfs.deleteImage(imageFileName);
			// 성공적으로 삭제되었으면 이미지도 삭제하겠다
		}else {
			msg="삭제 실패";
			url = "/board/contentView?writeNo"+writeNo; // writeNo로 해당 게시글 정보 같이 보내기
			//contentview 할 때도 게시글 번호(writeNo) 필요함 >> 해당 게시글 내용을 보여주기 위해서는 게시글 번호 필요!
			// contentview 함수만 봐도 매개변수로 writeNo 받아옴!!!
		}
		return bfs.getMessage(request, msg, url);
	}
	
	public void addReply(BoardRepDTO dto) {
		// 답글 추가하기 기능 >> 
		mapper.addReply(dto);
	}
	public List<BoardRepDTO> getRepList(int write_group){
		return mapper.getRepList(write_group);
	}
	
}
