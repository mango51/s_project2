package com.care.root.board.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.care.root.board.dto.BoardRepDTO;

public interface BoardService {
	public void boardAllList(Model model, int num);
	
	public String writeSave(MultipartHttpServletRequest mul, HttpServletRequest request);
	public void contentView(int writeNo, Model model);
	public String modify(MultipartHttpServletRequest mul, HttpServletRequest request);
	public String boardDelete(int writeNo, String imageFileName, HttpServletRequest request);
	public void addReply(BoardRepDTO dto); //해당 dto 데이터를 답글로 추가하기
	public List<BoardRepDTO> getRepList(int write_group);
}
