package com.sist.erp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import com.sist.erp.dao.MemberDAO;
import com.sist.erp.dao.MoveDAO;
import com.sist.erp.util.MoveExcelDown;
import com.sist.erp.vo.MoveVO;

@Controller
@RequestMapping("/move")
public class MoveController
{
	@Autowired
	private MoveDAO moveDAO;
	@Autowired
	private MemberDAO memberDAO;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String moveHome(Model model, String page)
	{
		List<MoveVO> mlist = moveDAO.getMoves();
		
		if(page!=null)
		{
			model.addAttribute("page", page);
		}
		
		model.addAttribute("mlist", mlist);
		
		return "move/main";
	}
	
	@RequestMapping("/new")
	public String addBranch(Model model, HttpSession session) {
		
		String mseq = (String)session.getAttribute("loginSeq");
		
		String slaveName = memberDAO.getMemberBySeq(mseq).getName();
		
		model.addAttribute("slave", slaveName);
		
		return "move/addMove";
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public String editBranch(Model model, String mseq, String page) {
		 
		MoveVO m = moveDAO.getMove(mseq);
		
		model.addAttribute("page", page);
		model.addAttribute("branch", m);
		
		return "move/detailMove";
	}
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public String addBranch(@ModelAttribute MoveVO m, Model model)
	{
		moveDAO.addMove(m);
		
		model.addAttribute("flag", "1");
		
		return "move/addMove";
	}
	
	@RequestMapping(value="/searchBranch", method=RequestMethod.GET)
	public String searchBranch()
	{
		return "move/searchBranch";
	}
	
	@RequestMapping(value="/searchApprovers", method=RequestMethod.GET)
	public String searchApprovers()
	{
		return "move/searchApprovers";
	}
	
	@RequestMapping(value="/searchProduct", method=RequestMethod.GET)
	public String searchClient(String no, Model model)
	{
		model.addAttribute("no", no);
		
		return "move/searchProduct";
	}
	
	@RequestMapping("/excel")
	public View excelDownload(Model model)
	{
		List<MoveVO> mlist = moveDAO.getMoves();
		
		model.addAttribute("mlist", mlist);
		
		return new MoveExcelDown();
	}
}
