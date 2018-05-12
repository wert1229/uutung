package com.sist.erp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.sist.erp.dao.BranchDAO;
import com.sist.erp.util.ExcelDown;
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
		
		return "branch/main";
	}
	
	@RequestMapping("/branch/new")
	public String addBranch() {
		
		return "branch/addBranch";
	}
	
	@RequestMapping(value="/branch", method=RequestMethod.POST)
	public String addBranch(@ModelAttribute BranchVO b, HttpServletRequest request)
	{
		branchDAO.addBranch(b);
		
		request.setAttribute("flag", "1");
		
		return "branch/addBranch";
	}
	
	@RequestMapping(value="/searchBranch", method=RequestMethod.GET)
	public String searchBranch()
	{
		return "searchBranch";
	}
	
	@ResponseBody
	@RequestMapping(value="/searchBranch", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchBranch(@RequestParam String key)
	{
		Gson gson = new Gson();
		
		List<BranchVO> blist = branchDAO.searchBranches(key);
		
		String blistJson = gson.toJson(blist);
		
		return blistJson;
	}
	
	@RequestMapping("/excelDownload")
	public View excelDownload(Model model)
	{
		List<BranchVO> blist = branchDAO.getBranches();
		
		model.addAttribute("blist", blist);
		
		return new ExcelDown();
	}
}
