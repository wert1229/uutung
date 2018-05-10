package com.sist.erp.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.imgscalr.Scalr;
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

import com.sist.erp.dao.MemberDAO;
import com.sist.erp.vo.MemberVO;


@Controller
public class MemberController
{
	@Autowired
	MemberDAO memberDAO;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(@CookieValue(value="remember", defaultValue="0") String email, Model model) {

		model.addAttribute("remember", email);
		
		return "login";
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
		
		return "join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute MemberVO m) {
		memberDAO.addMember(m);
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.GET) 
	public String edit() {
		
		return "edit";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.POST) 
	public String edit(@ModelAttribute MemberVO m) {
		
		return "edit";
	}
	
	@ResponseBody
	@RequestMapping("/profilePic")
	public String upload(@RequestParam("file") MultipartFile file, HttpSession session) {
		UUID uuid = UUID.randomUUID();
		String originFileName = file.getOriginalFilename();
		String saveFileName = uuid.toString()+"_"+originFileName;
		
		String uploadPath = session.getServletContext().getRealPath("/resources/uploadImg/");
		String fullPath = uploadPath +saveFileName;
		
		String ThumbnailedFilePath = uploadPath+"s_"+saveFileName;
		String formatName = originFileName.substring(originFileName.indexOf(".")+1);
		
		try
		{
			file.transferTo(new File(fullPath));
			makeThumbnail(fullPath, ThumbnailedFilePath, formatName);
		}
		catch (IllegalStateException | IOException e)
		{
			e.printStackTrace();
		}
		
		return ThumbnailedFilePath;
	}
	
	public void makeThumbnail(String filePath, String targetFilePath, String format) throws IOException {
		BufferedImage originImg = ImageIO.read(new File(filePath));
		
		int width = 150;
		int height = 180;
		
		BufferedImage resizedImg = Scalr.resize(originImg, width, height);
		
		ImageIO.write(resizedImg, format, new File(targetFilePath));
	}
}
