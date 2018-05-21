package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.ChatUnreadVO;
import com.sist.erp.vo.ChatVO;

public interface ChatDAO
{
	void addChat(ChatVO chat);

	List<ChatVO> getLogs(String loginSeq, String receiverMseq);

	void updateCheckdate(String loginSeq, String receiverMseq);

	void updateCheckOneByOne(String cseq);

	List<ChatUnreadVO> getChatUnread(String loginSeq);
}
