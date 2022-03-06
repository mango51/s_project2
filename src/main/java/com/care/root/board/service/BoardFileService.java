package com.care.root.board.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

public interface BoardFileService {
	public static String IMAGE_REPO = "c:/spring/image_repo";
	public String saveFile(MultipartFile file);
	public String getMessage(HttpServletRequest request,String msg,String url);
	public void deleteImage(String originalFileName);
}
