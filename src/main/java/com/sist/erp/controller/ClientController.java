package com.sist.erp.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sist.erp.dao.ClientDAO;
import com.sist.erp.vo.BranchVO;
import com.sist.erp.vo.ClientVO;

@Controller
@RequestMapping("/client/*")
public class ClientController {

		@Autowired
		private ClientDAO cdao;

		@RequestMapping("/main")
		public String clients(HttpServletRequest request,String pg) {

			List<ClientVO> clist = cdao.getClients();
			
			request.setAttribute("clist" ,clist);
			request.setAttribute("pg", pg);
			
			return "client/main";
		}

		
		@RequestMapping(value="/addClient", method=RequestMethod.POST)
		public String clientRegProc(ClientVO c, Model model) throws SQLException {

		    cdao.addClient(c);

			model.addAttribute("flag", "1");
			
			return "client/addClient";
		}
		

		@RequestMapping(value="/addClient", method=RequestMethod.GET)
		public String clientReg(Model model){

			return "client/addClient";
		}	
		
		@ResponseBody
		@RequestMapping(value="/delclist", method=RequestMethod.POST)
		public String delclist(String num ){

			Gson gson = new Gson();
			
			String[] numlist = gson.fromJson(num, String[].class);
			
			int delNum =0;
			for(String cseq : numlist) {
				
				ClientVO c = new ClientVO();
				c.setCseq(cseq);
				
				int aa  = cdao.deleteClient(c);
				delNum += aa;
			}
			
			if(delNum == numlist.length){
				return "ok";
			}else{
				return "no";
			}
		}
		
		@RequestMapping(value="/update", method=RequestMethod.GET)
		public String update(String num, Model model){
			
			ClientVO c =cdao.getClient(num);
			
			model.addAttribute("c", c);
			
			return "client/update";
		}
		
		@RequestMapping(value="/update", method=RequestMethod.POST)
		public String updateproc(@ModelAttribute ClientVO c, Model model, String pg){
			
			cdao.updateClient(c);
			
			model.addAttribute("pg", pg);
			model.addAttribute("flag", "1");
			
			return "client/update";
		}
		
		@ResponseBody
		@RequestMapping(value="/searchClient", method=RequestMethod.POST, produces = "application/text; charset=utf8")
		public String searchClient(String key)
		{
			Gson gson = new Gson();
			
			List<ClientVO> clist = cdao.searchClients(key);
			
			String clistJson = gson.toJson(clist);
			
			return clistJson;
		}
		
		
	}