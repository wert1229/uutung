package com.sist.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.erp.dao.BranchDAO;
import com.sist.erp.dao.SampleDAO;

@Controller
public class BranchController 
{
	@Autowired
	private BranchDAO branchDAO;
	
	@RequestMapping("/sample")
	public String sample()
	{
		return "sample";
	}
}
