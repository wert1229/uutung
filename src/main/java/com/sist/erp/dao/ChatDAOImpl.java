package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.ChatUnreadVO;
import com.sist.erp.vo.ChatVO;

@Repository
public class ChatDAOImpl implements ChatDAO
{
	@Autowired
	SqlSession session;
	
	@Override
	public void addChat(ChatVO chat)
	{
		session.getMapper(ChatDAO.class).addChat(chat);
	}

	@Override
	public List<ChatVO> getLogs(String loginSeq, String receiverMseq)
	{
		return session.getMapper(ChatDAO.class).getLogs(loginSeq, receiverMseq);
	}

	@Override
	public void updateCheckdate(String loginSeq, String receiverMseq)
	{
		session.getMapper(ChatDAO.class).updateCheckdate(loginSeq, receiverMseq);
	}

	@Override
	public void updateCheckOneByOne(String cseq)
	{
		session.getMapper(ChatDAO.class).updateCheckOneByOne(cseq);
	}

	@Override
	public List<ChatUnreadVO> getChatUnread(String loginSeq)
	{
		return session.getMapper(ChatDAO.class).getChatUnread(loginSeq);
	}

}
