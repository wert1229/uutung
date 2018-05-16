package com.sist.erp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.erp.dao.ApproveDAO;
import com.sist.erp.dao.MemberDAO;
import com.sist.erp.vo.ApproveFromMeVO;
import com.sist.erp.vo.ApproveToMeVO;

@Controller
@RequestMapping("/aprv")
public class ApproveController
{
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	ApproveDAO approveDAO;
	
	@RequestMapping(value="/fromme", method=RequestMethod.GET)
	public String fromMe(Model model, HttpSession session)
	{
		String loginSeq = (String) session.getAttribute("loginSeq");
		
		List<ApproveFromMeVO> afmlist = approveDAO.getApprovesFromMe(loginSeq);
		
		model.addAttribute("afmlist",afmlist);
		
		return "/aprv/fromMe";
	}
	
	@RequestMapping(value="/tome", method=RequestMethod.GET)
	public String toMe(Model model, HttpSession session)
	{
		String loginSeq = (String) session.getAttribute("loginSeq");
		
		List<ApproveToMeVO> atmlist = approveDAO.getApprovesToMe(loginSeq);
		
		model.addAttribute("atmlist",atmlist);
		
		return "/aprv/toMe";
	}
}
