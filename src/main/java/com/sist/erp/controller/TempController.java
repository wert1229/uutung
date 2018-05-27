package com.sist.erp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sist.erp.dao.BranchDAO;
import com.sist.erp.dao.TempDAO;
import com.sist.erp.vo.temp.BalanceVO;
import com.sist.erp.vo.temp.HistoryVO;

@Controller
public class TempController
{
	@Autowired
	TempDAO tempDAO;
	@Autowired
	BranchDAO branchDAO;
	
	@RequestMapping("/inven")
	public String showInven(Model model)
	{
		//지점 물건별로 현재 밸런스를 뽑아옴
		List<BalanceVO> balanceList = tempDAO.getBalances();
		
		model.addAttribute("balanceList", balanceList);
		
		return "inven";
	}
	
	@ResponseBody
	@RequestMapping(value="/history", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String showHistory(String bseq, String pseq)
	{
		Gson gson = new Gson();
		
		List<HistoryVO> historyList = tempDAO.getHistory(bseq, pseq);
		String bname = branchDAO.getBranch(bseq).getName();
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("hlist", historyList);
		map.put("bname", bname);
		
		return gson.toJson(map);
	}
	
}
