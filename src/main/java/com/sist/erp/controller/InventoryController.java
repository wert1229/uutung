package com.sist.erp.controller;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sist.erp.dao.BranchDAO;
import com.sist.erp.dao.InventoryDAO;
import com.sist.erp.dao.MemberDAO;
import com.sist.erp.dao.ProductDAO;
import com.sist.erp.vo.BranchVO;
import com.sist.erp.vo.InventoryVO;
import com.sist.erp.vo.MemberVO;
import com.sist.erp.vo.ProductVO;

@Controller
public class InventoryController 
{
	@Autowired
	InventoryDAO inventoryDAO;

	@Autowired
	BranchDAO branchDAO;

	@Autowired
	ProductDAO productDAO;
	
	@Autowired
	MemberDAO memberDAO;

	@RequestMapping(value = "/inventory", method = RequestMethod.GET)
	public String inventory(Model model)
	{
		List<BranchVO> branchList = branchDAO.getBranches();

		List<ProductVO> productList = productDAO.getProducts();

		List<InventoryVO> inventoryList = inventoryDAO.getInventorys();
		
		List<MemberVO> memberList = memberDAO.getMembers();

		List<InventoryVO> balanceList = new ArrayList<>();
		
		for(int i=0; i<branchList.size(); i++) {
			for(int j=0; j<productList.size(); j++) {
				for(int k=0; k<inventoryList.size(); k++) {
					if(inventoryList.get(k).getBseq().equals(branchList.get(i).getBseq()) && inventoryList.get(k).getPseq().equals(productList.get(j).getPseq())) {
						balanceList.add(inventoryList.get(k));
						break;
					}
				}
			}
		}

		model.addAttribute("branchList", branchList);
		model.addAttribute("productList", productList);
		model.addAttribute("inventoryList", inventoryList);
		model.addAttribute("balanceList", balanceList);
		model.addAttribute("memberList", memberList);
		return "inventory/inventory";
	}
}
