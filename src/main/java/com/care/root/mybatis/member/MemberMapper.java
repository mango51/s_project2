package com.care.root.mybatis.member;

import java.util.ArrayList;
import java.util.Map;

import com.care.root.member.dto.MemberDTO;
import com.care.root.member.dto.ProductDTO;

public interface MemberMapper {
	public MemberDTO getMember(String id);
	public ArrayList<MemberDTO> memberInfo();
	public int register(MemberDTO dto);
	public void keepLogin(Map<String, Object> map);
	public MemberDTO getUserSession(String sessionID);
	public ArrayList<MemberDTO> showMoney();
	public ArrayList<ProductDTO> getProduct();
}
