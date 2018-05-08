package com.sist.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.erp.dao.SampleDAO;

@Controller
public class SampleController 
{
	@Autowired
	private SampleDAO sampleDAO;
	
	@RequestMapping("/sample")
	public String sample()
	{
		return "sample";
	}
}
