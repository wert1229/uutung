package com.sist.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sist.erp.dao.MemberDAO;
import com.sist.erp.vo.MemberVO;

@Controller
public class MemberController
{
	@Autowired
	MemberDAO memberDAO;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		
		return "login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam String email) {
		MemberVO m = memberDAO.getMember(email);
		
		return "home";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		
		return "join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute MemberVO m, MultipartFile imageFile) {
		
		
		
		return "home";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.GET) 
	public String edit() {
		
		return "edit";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.POST) 
	public String edit(@ModelAttribute MemberVO m) {
		
		return "edit";
	}
	
}
