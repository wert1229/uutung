package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.MemberVO;

public interface MemberDAO
{
	void addMember(MemberVO m);
	
	MemberVO getMember(String email);

	List<MemberVO> searchMembers(String key);
}
