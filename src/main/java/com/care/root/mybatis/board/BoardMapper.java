package com.care.root.mybatis.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.care.root.board.dto.BoardDTO;
import com.care.root.board.dto.BoardRepDTO;

public interface BoardMapper {
	public List<BoardDTO> boardAllList(@Param("s") int start,@Param("e") int end);
	// mybatis에서는 start를 s로 사용하겠다 (닉네임처럼), end를 e로 사용하겠다 (닉네임처럼)
	
	public int writeSave(BoardDTO dto);
	public BoardDTO contentView(int writeNo);
	public void upHit(int writeNo);
	public int modify(BoardDTO dto); //결과 실행 결과 성공 시 1반환
	public int delete(int writeNo);//결과 실행 결과 성공 시 1반환
	public void addReply(BoardRepDTO dto); //답글 추가
	public List<BoardRepDTO> getRepList(int write_group);
	public int selectBoardcount();
}
