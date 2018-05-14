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
		
		return "move/addMove2";
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
	
	/*@RequestMapping(value="/edit", method=RequestMethod.POST)
	public String editBranch(@ModelAttribute BranchVO b, String page, Model model) {
		
		branchDAO.updateBranch(b);
		
		model.addAttribute("flag", "1");
		model.addAttribute("page", page);
		
		return "branch/editBranch";
	}*/
	
	/*@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public boolean delBranch(@RequestBody String checkList)
	{
		System.out.println(checkList);
		
		Gson gson = new Gson();
		
		String[] list = gson.fromJson(checkList, String[].class);
		
		for(String bseq : list)
		{
			branchDAO.delBranch(bseq);
		}
		
		return true;
	}*/
	
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
	
	/*@ResponseBody
	@RequestMapping(value="/searchBranch", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchBranch(String key)
	{
		Gson gson = new Gson();
		
		List<BranchVO> blist = branchDAO.searchBranches(key);
		
		String blistJson = gson.toJson(blist);
		
		return blistJson;
	}*/
	
	@RequestMapping("/excel")
	public View excelDownload(Model model)
	{
		List<MoveVO> mlist = moveDAO.getMoves();
		
		model.addAttribute("mlist", mlist);
		
		return new MoveExcelDown();
	}
}
