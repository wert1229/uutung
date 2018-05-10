package com.sist.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sist.erp.dao.BranchDAO;
import com.sist.erp.vo.BranchVO;

@Controller
public class BranchController 
{
	@Autowired
	private BranchDAO branchDAO;
	
	@RequestMapping(value="/branch", method=RequestMethod.GET)
	public String branchHome(Model model)
	{
		List<BranchVO> branchList = branchDAO.getBranches();
		
		model.addAttribute("branchList",branchList);
		
		return "branch/home";
	}
	
	@RequestMapping("/branch/new")
	public String addBranch() {
		
		return "branch/addBranch";
	}
	
	@RequestMapping(value="/branch", method=RequestMethod.POST)
	public String branchHome(@ModelAttribute BranchVO b)
	{
		branchDAO.addBranch(b);
		
		return "branch/home";
	}
	
	@RequestMapping(value="/searchBranch", method=RequestMethod.GET)
	public String searchBranch()
	{
		return "searchBranch";
	}
	
	@ResponseBody
	@RequestMapping(value="/searchBranch", method=RequestMethod.POST)
	public String searchBranch(@RequestParam String key)
	{
		Gson gson = new Gson();
		
		List<BranchVO> blist = branchDAO.searchBranches(key);
		
		String blistJson = gson.toJson(blist);
		
		return blistJson;
	}
	
}
