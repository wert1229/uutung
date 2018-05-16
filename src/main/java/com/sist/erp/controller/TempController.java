package com.sist.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sist.erp.dao.TempDAO;
import com.sist.erp.vo.TempVO;

@Controller
public class TempController
{
	@Autowired
	private TempDAO tempDAO;
	
	@ResponseBody
	@RequestMapping(value="/searchProduct", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchClient(String key)
	{
		Gson gson = new Gson();
		
		List<TempVO> plist = tempDAO.searchProduct(key);
		
		String plistJson = gson.toJson(plist);
		
		return plistJson;
	}
}
