package com.sist.erp.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.sist.erp.dao.EstimateDAO;
import com.sist.erp.dao.ProductDAO;
import com.sist.erp.util.EstimateExcelDown;
import com.sist.erp.vo.EstimateVO;
import com.sist.erp.vo.ProductVO;

@Controller
@RequestMapping("/estimate")
public class EstimateController {
	@Autowired
	private EstimateDAO edao;
	@Autowired
	private ProductDAO pdao;
	@Resource(name = "transactionManager")
	private DataSourceTransactionManager txManager;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String EstimateHome(Model model, String page) {
		List<ProductVO> plist = pdao.getProducts();
		
		if(page!=null) {
			model.addAttribute("page", page);
		}
		
		model.addAttribute("plist",plist);
		
		return "estimate/mainEstimate";
	}
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute EstimateVO e, Model model) {
/*List<EstimateVO> elist = edao.getDetailEstimates(pseq);
		
		if(page!=null) {
			model.addAttribute("page", page);
		}
		model.addAttribute("pseq", pseq);
		model.addAttribute("elist",elist);*/
		String pseq=e.getProductSq();
		
		edao.addEstimate(e);

		model.addAttribute("flag", "1");
		model.addAttribute("pseq", pseq);
		
		return "estimate/detailEstimate";
	}
	
	@RequestMapping("/new")
	public String addEstimate(Model model, String pseq) {
		model.addAttribute("pseq", pseq);
		return "estimate/addEstimate";
	}

	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public String editEstimate(Model model, String eseq, String page) {
		EstimateVO e = edao.getEstimate(eseq);
		
		model.addAttribute("page", page);
		model.addAttribute("estimate", e);
			
		return "estimate/editEstimate";
	}
		
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public String editEstimate(@ModelAttribute EstimateVO e, String page, Model model) {
	
		edao.updateEstimate(e);
	
		model.addAttribute("flag", "1");
		model.addAttribute("page", page);
	
		return "estimate/editEstimate";
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public String detailEstimate(Model model, String page, String pseq) {
		List<EstimateVO> elist = edao.getDetailEstimates(pseq);
		
		if(page!=null) {
			model.addAttribute("page", page);
		}
		model.addAttribute("pseq", pseq);
		model.addAttribute("elist",elist);
		return "estimate/detailEstimate";
	}
	
	@RequestMapping(value="detail", method=RequestMethod.POST)
	public String addEstimate(@ModelAttribute EstimateVO e, Model model) {
		edao.addEstimate(e);

		model.addAttribute("flag", "1");

		return "estimate/addEstimate";
	}
	
	@ResponseBody
	@RequestMapping(value="/delEstimate", method=RequestMethod.POST)
	public boolean delEstimate(@RequestBody String checkList) {
		System.out.println(checkList);
		
		Gson gson = new Gson();
	
		String[] list = gson.fromJson(checkList, String[].class);
	
		for(String eseq : list) {
			edao.delEstimate(eseq);
		}
	
		return true;
	}
	
	@ResponseBody
	@RequestMapping(value="/okEstimate", method=RequestMethod.POST)
	public boolean okEstimate(@RequestBody String checkList) {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		Gson gson = new Gson();
		
		String[] list = gson.fromJson(checkList, String[].class);
		
		String pseq = edao.getEstimate(list[0]).getProductSq();
		
		try	{
			for(String eseq : list) {
				edao.okEstimate(eseq);
			}
			pdao.okProduct(pseq);
		}
		catch(Exception e) {
			txManager.rollback(txStatus);
			
			return false;
		}
		txManager.commit(txStatus);
		return true;
	}
	
	@RequestMapping(value="/searchEstimate", method=RequestMethod.GET)
	public String searchEstimate() {
		return "estimate/searchEstimate";
	}
		
	@ResponseBody
	@RequestMapping(value="/searchEstimate", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchEstimate(@RequestParam String key) {
		Gson gson = new Gson();
	
		List<EstimateVO> elist = edao.searchEstimate(key);
		
		String elistJson = gson.toJson(elist);
		
		return elistJson;
	}
		
	@RequestMapping("/eExcelDownload")
	public View eExcelDownload(Model model) {
		List<EstimateVO> elist = edao.getEstimates();
	
		model.addAttribute("elist", elist);
	
		return new EstimateExcelDown();
	}
}