package com.sist.erp.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO
{
	@Autowired
	SqlSession session;
	
	@Override
	public void addMember(MemberVO m)
	{
		session.getMapper(MemberDAO.class).addMember(m);
	}
	
	@Override
	public MemberVO getMember(String email)
	{
		return session.getMapper(MemberDAO.class).getMember(email);
	}
}
