package com.sist.erp.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.sist.erp.dao.MemberDAO;
import com.sist.erp.util.IOUtil;
import com.sist.erp.vo.MemberVO;

@Controller
public class MemberController
{
	@Autowired
	MemberDAO memberDAO;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(@CookieValue(value="remember", defaultValue="0") String email, Model model) {

		model.addAttribute("remember", email);
		
		return "member/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(String email, String pwd, String remember, HttpSession session, HttpServletResponse response) {
		
		session.setAttribute("loginSeq", memberDAO.getMember(email).getMseq());

		if(remember != null) {
			Cookie cookie = new Cookie("remember", email);
			cookie.setMaxAge(60*60*24*7);
			
			response.addCookie(cookie);
		}else{
			Cookie cookie = new Cookie("remember", email);
			cookie.setMaxAge(0);
			
			response.addCookie(cookie);
		}
		
		
		if(session.getAttribute("prevPage")!=null) {
			String prev = (String)session.getAttribute("prevPage");
			
			return "redirect:"+prev;
		}else{
			return "redirect:/";
		}
	}
	
	@ResponseBody
	@RequestMapping("/login/valid")
	public boolean loginValidate(String email, String pwd)
	{
		MemberVO m = memberDAO.getMember(email);

		if(m!=null && m.getPwd().equals(pwd))
			return true;
		else
			return false;
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		
		return "member/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute MemberVO m) {
		
		memberDAO.addMember(m);
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping("/profilePic")
	public String upload(@RequestParam("file") MultipartFile file, HttpSession session) {
		
		String path = "/resources/uploadImg/";
		
		String ThumbnailedFilePath = IOUtil.fileUpload(file, session, path);
		
		return ThumbnailedFilePath;
	}
	
	@RequestMapping(value="/searchManager", method=RequestMethod.GET)
	public String searchBranch()
	{
		return "branch/searchManager";
	}
	
	@ResponseBody
	@RequestMapping(value="/searchManager", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchBranch(@RequestParam String key)
	{
		Gson gson = new Gson();
		
		List<MemberVO> mlist = memberDAO.searchMembers(key);
		
		String mlistJson = gson.toJson(mlist);

		return mlistJson;
	}
}
