package com.sist.erp.dao;

import com.sist.erp.vo.MemberVO;

public interface MemberDAO
{
	void addMember(MemberVO m);
	MemberVO getMember(String email);
}
