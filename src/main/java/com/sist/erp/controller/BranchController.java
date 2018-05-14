package com.sist.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.sist.erp.dao.BranchDAO;
import com.sist.erp.util.BranchExcelDown;
import com.sist.erp.vo.BranchVO;

@Controller
@RequestMapping("/branch")
public class BranchController 
{
	@Autowired
	private BranchDAO branchDAO;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String branchHome(Model model, String page)
	{
		List<BranchVO> blist = branchDAO.getBranches();
		
		if(page!=null)
		{
			model.addAttribute("page", page);
		}
		
		model.addAttribute("blist",blist);
		
		return "branch/main";
	}
	
	@RequestMapping("/new")
	public String addBranch() {
		
		return "branch/addBranch";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public String editBranch(Model model, String bseq, String page) {
		 
		BranchVO b = branchDAO.getBranch(bseq);
		
		model.addAttribute("page", page);
		model.addAttribute("branch", b);
		
		return "branch/editBranch";
	}
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public String addBranch(@ModelAttribute BranchVO b, Model model)
	{
		branchDAO.addBranch(b);
		
		model.addAttribute("flag", "1");
		
		return "branch/addBranch";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public String editBranch(@ModelAttribute BranchVO b, String page, Model model) {
		
		branchDAO.updateBranch(b);
		
		model.addAttribute("flag", "1");
		model.addAttribute("page", page);
		
		return "branch/editBranch";
	}
	
	@ResponseBody
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
	}
	
	@RequestMapping(value="/searchManager", method=RequestMethod.GET)
	public String searchBranch()
	{
		return "branch/searchManager";
	}
	
	@ResponseBody
	@RequestMapping(value="/searchBranch", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchBranch(String key)
	{
		Gson gson = new Gson();
		
		List<BranchVO> blist = branchDAO.searchBranches(key);
		
		String blistJson = gson.toJson(blist);
		
		return blistJson;
	}
	
	@RequestMapping("/excel")
	public View excelDownload(Model model)
	{
		List<BranchVO> blist = branchDAO.getBranches();
		
		model.addAttribute("blist", blist);
		
		return new BranchExcelDown();
	}
}
