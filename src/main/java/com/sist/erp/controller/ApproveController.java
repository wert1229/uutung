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
import com.sist.erp.dao.MoveDAO;
import com.sist.erp.dao.OrderDAO;
import com.sist.erp.vo.ApproveFromMeVO;
import com.sist.erp.vo.ApproveToMeVO;
import com.sist.erp.vo.MoveAprvDetailVO;
import com.sist.erp.vo.MoveDetailVO;
import com.sist.erp.vo.MoveListDetailVO;
import com.sist.erp.vo.OrderAprvDetailVO;
import com.sist.erp.vo.OrderDetailOseqVO;
import com.sist.erp.vo.OrderDetailVO;
import com.sist.erp.vo.OrderListDetailVO;

@Controller
@RequestMapping("/aprv")
public class ApproveController
{
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	ApproveDAO approveDAO;
	@Autowired
	MoveDAO moveDAO;
	@Autowired
	OrderDAO orderDAO;
	
	@RequestMapping(value="/fromme", method=RequestMethod.GET)
	public String fromMe(Model model, HttpSession session, String page)
	{
		String loginSeq = (String) session.getAttribute("loginSeq");
		
		List<ApproveFromMeVO> afmlist = approveDAO.getApprovesFromMe(loginSeq);
		
		model.addAttribute("afmlist",afmlist);
		model.addAttribute("page", page);
		
		return "aprv/fromMe";
	}
	
	@RequestMapping(value="/tome", method=RequestMethod.GET)
	public String toMe(Model model, HttpSession session)
	{
		String loginSeq = (String) session.getAttribute("loginSeq");
		
		List<ApproveToMeVO> atmlist = approveDAO.getApprovesToMe(loginSeq);
		
		model.addAttribute("atmlist",atmlist);
		
		return "aprv/toMe";
	}
	
	@RequestMapping("/moveAprvDetail")
	public String moveDetail(Model model, String mseq)
	{
		MoveDetailVO m = moveDAO.getMoveDetailByMseq(mseq);
		
		List<MoveListDetailVO> mldlist = moveDAO.getMoveListDetailByMseq(mseq);
		
		List<MoveAprvDetailVO> madlist = moveDAO.getMoveAprvByMseq(mseq);
		
		model.addAttribute("m", m);
		
		model.addAttribute("mldlist", mldlist);
		
		model.addAttribute("madlist", madlist);
		
		return "aprv/moveAprvDetail";
	}
	
	@RequestMapping("/orderAprvDetail")
	public String orderDetail(Model model, String oseq) {
		
		OrderDetailOseqVO o = orderDAO.getOrderDetailByOseq(oseq);
		
		List<OrderListDetailVO> oldlist = orderDAO.getOrderDetailListByOseq(oseq);
		
		List<OrderAprvDetailVO> oadlist = orderDAO.getOrderAprvByOseq(oseq);
		
		model.addAttribute("o", o);
		model.addAttribute("oldlist",oldlist);
		model.addAttribute("oadlist",oadlist);
		
		return "aprv/orderAprvDetail";
		
	}
	
}
