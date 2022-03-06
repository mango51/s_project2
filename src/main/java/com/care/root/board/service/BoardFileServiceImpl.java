package com.care.root.board.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

@Service
public class BoardFileServiceImpl implements BoardFileService{
	public String getMessage(HttpServletRequest request,String msg,String url) {
		// request 입력한 글 내용, msg 알림창에 띄울 내용, url 이동할 경로
		String message=null;
		String path=request.getContextPath();
		message="<script> alert('"+msg+"');";
		message+="location.href='"+path+url+"'; </script>";
		
		return message;
	}
	
	public String saveFile(MultipartFile file) {
		// 오버라이딩
		// 파일명 설정 + 저장할 경로도 설정해줌!
		SimpleDateFormat fo = new SimpleDateFormat("yyyyMMddHHmmss-");
		Calendar ca = Calendar.getInstance();
		String sysFileName = fo.format(ca.getTime()); // 현재 날짜시간 ca를  fo 형태로 format하기
		sysFileName += file.getOriginalFilename(); // format한 현재시간을 파일명에 붙이기 >> 파일명은 현재 날짜로 입력됨
		
		File saveFile = new File(IMAGE_REPO+"/"+sysFileName); // 파일 객체 생성하여 저장할 경로 설정
		try {
			file.transferTo(saveFile); //첨부파일을 저장할 경로로 이동시키기
		}catch(Exception e) {
			e.printStackTrace();
		}
		return sysFileName; // 저장할 파일명 반환하기
	}
	public void deleteImage(String originalFileName) {
		
		//파일 삭제 기능
		File file=  new File(IMAGE_REPO+"/"+originalFileName); //저장할 경로와 해당 파일 객체 생성
		file.delete(); //File클래스에서 제공되는 delete() 기능
	}
	

}
