package com.sist.erp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sist.erp.dao.ChatDAO;
import com.sist.erp.dao.MemberDAO;
import com.sist.erp.vo.ChatUnreadVO;
import com.sist.erp.vo.ChatVO;
import com.sist.erp.vo.MemberVO;

@Controller
@RequestMapping("/chat")
public class ChatController
{
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private ChatDAO chatDAO;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String chatPage(Model model, HttpSession session, String mseq)
	{
		Gson gson = new Gson();
		
		String loginSeq = (String)session.getAttribute("loginSeq");
		
		MemberVO m = memberDAO.getMemberBySeq(loginSeq);
		List<MemberVO> mlist = memberDAO.getMembersExceptMe(loginSeq);
		List<ChatUnreadVO> culist = chatDAO.getChatUnread(loginSeq);
		
		model.addAttribute("me", m);
		model.addAttribute("mlist", mlist);
		model.addAttribute("culist", gson.toJson(culist));
		model.addAttribute("selectedMseq", mseq);
		
		return "chat/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/getlog", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String getlog(String receiverMseq, HttpSession session)
	{
		Gson gson = new Gson();
		
		String loginSeq = (String)session.getAttribute("loginSeq");
		
		List<ChatVO> clist = chatDAO.getLogs(loginSeq, receiverMseq);
		
		chatDAO.updateCheckdate(loginSeq, receiverMseq);
		
		String logs = gson.toJson(clist);
		
		return logs;
	}
	
	@ResponseBody
	@RequestMapping("/updateCheck")
	public boolean update(String cseq)
	{
		chatDAO.updateCheckOneByOne(cseq);
		
		return true;
	}
	
	@ResponseBody
	@RequestMapping(value="/getUnreads", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String getUnreads(String loginSeq)
	{
		Gson gson = new Gson();
		
		List<ChatUnreadVO> urlist = chatDAO.getChatUnread(loginSeq);
		
		String jsonUrlist = gson.toJson(urlist);
		
		return jsonUrlist;
	}
}
