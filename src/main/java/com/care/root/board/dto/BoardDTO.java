package com.care.root.board.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardDTO {
	//DTO 순수한 데이터 객체 (getter와 setter로 데이터 지정 및 호출 가능)
	private int writeNo;
	private String title;
	private String content;
	
	private String saveDate;
	private int hit;
	private String imageFileName;
	private String id;
	

	
	public int getWriteNo() {
		return writeNo;
	}
	public void setWriteNo(int writeNo) {
		this.writeNo = writeNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSaveDate() {
		return saveDate;
	}
	
	public void setSaveDate(Timestamp saveDate) {
		SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		// 현재 시간 saveDate로 받아와서 simpledateformat(간단한 정해진 틀로 만들기)
		this.saveDate =fo.format(saveDate);
		//현재 받아온 saveDate 데이터를 fo형식으로 포맷(틀에 넣기)하하기
	} 
	/*
	public void setSaveDate(String saveDate) {
		this.saveDate = saveDate;
	} */
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
