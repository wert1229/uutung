package com.sist.erp.controller;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.sist.erp.dao.EstimateDAO;
import com.sist.erp.dao.MemberDAO;
import com.sist.erp.dao.OrderDAO;
import com.sist.erp.vo.EstiProductVO;
import com.sist.erp.vo.OrderAprvVO;
import com.sist.erp.vo.OrderCheckVO;
import com.sist.erp.vo.OrderDetailVO;
import com.sist.erp.vo.OrderListDetailVO;
import com.sist.erp.vo.OrderListVO;
import com.sist.erp.vo.OrderVO;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	@Autowired
	private OrderDAO orderdao;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private EstimateDAO estimateDAO;
	
	@Resource(name = "transactionManager")
	private DataSourceTransactionManager txManager;
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String orders(HttpSession session, Model model) {

		String loginSeq = (String)session.getAttribute("loginSeq");
		
		String dept = memberDAO.getMemberBySeq(loginSeq).getDept();
		
		List<OrderCheckVO> olist = orderdao.getOrderChecks(dept);
		
		model.addAttribute("olist",olist);
	
		return "order/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/main", method=RequestMethod.POST)
	public boolean addOrder(@RequestBody String mapJson)
	{
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		
		JsonElement map = parser.parse(mapJson);
		
		JsonElement order = map.getAsJsonObject().getAsJsonObject("order");
		JsonElement orderAprv = map.getAsJsonObject().getAsJsonArray("orderAprv");
		JsonElement orderList = map.getAsJsonObject().getAsJsonArray("orderList");
		
		OrderVO o = gson.fromJson(order, OrderVO.class);
		List<OrderAprvVO> oa = gson.fromJson(orderAprv, new TypeToken<ArrayList<OrderAprvVO>>() {}.getType());
		List<OrderListVO> ol = gson.fromJson(orderList, new TypeToken<ArrayList<OrderListVO>>() {}.getType());
		
		try
		{
			orderdao.addOrder(o);
			orderdao.addOrderAprv(oa);
			orderdao.addOrderList(ol);
		}
		catch(Exception e)
		{
			txManager.rollback(txStatus);
			e.printStackTrace();
			return false;
		}
		
		txManager.commit(txStatus);
		
		return true;
	}
	
	@RequestMapping("/addorder")
	public String addOrderForm(Model model, HttpSession session) {
		
		String mseq = (String)session.getAttribute("loginSeq");
		
		String slaveName = memberDAO.getMemberBySeq(mseq).getName();
		
		model.addAttribute("slave", slaveName);
		
		return "order/addorder";
	}
	
	@RequestMapping(value="/searchClient", method=RequestMethod.GET)
	public String searchClient()
	{
		return "order/searchClient";
	}
	
	@RequestMapping("/searchApprovers")
	public String searchApprovers() {
		
		return "order/searchApprovers";
		
	}
	
	@RequestMapping(value="/searchProduct", method=RequestMethod.GET)
	public String searchProduct(Model model, String no) {
		
		model.addAttribute("no", no);
		
		return "order/searchProduct";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/searchProduct", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchProduct(String key, String cseq)
	{
		System.out.println(cseq);
		Gson gson = new Gson();
		
		List<EstiProductVO> elist = estimateDAO.searchEstProduct(key, cseq);
		
		String elistJson = gson.toJson(elist);
		
		return elistJson;
	}
	
	@RequestMapping("/orderdetail")
	public String orderDetail(String ocseq, Model model)
	{
		
		List<OrderDetailVO> olist = orderdao.getdetailList(ocseq);
		model.addAttribute("olist", olist);
		
		return "order/orderdetail";
	}
	
	@ResponseBody
	@RequestMapping("/doApprove")
	public boolean orderAprv(String oseq, HttpSession session) {
		
		String loginSeq = (String)session.getAttribute("loginSeq");
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus= txManager.getTransaction(def);
		
		try {
			orderdao.approveOrderAprv(oseq, loginSeq);
			
			if(orderdao.checkAprvFinished(oseq).equals("Y")) {
				
				orderdao.finishAprv(oseq);
				
				List<OrderListDetailVO> olist = orderdao.getOrderDetailListByOseq(oseq);
					
				//실제로 인벤에 추가하는 과정
				
				for(OrderListDetailVO o : olist) {
					
					orderdao.addHistoryofOrder(oseq, o);
				}
				
			}
			
		} catch(Exception e) {
			
			e.printStackTrace();
			txManager.rollback(txStatus);
			
			return false;
		}
		txManager.commit(txStatus);
		
		return true;
		
	}
	
	@ResponseBody
	@RequestMapping("/doReject")
	public boolean doReject(String oseq, HttpSession session) {
		
		String loginSeq = (String)session.getAttribute("loginSeq");
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition(); 
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); 
		TransactionStatus txStatus= txManager.getTransaction(def);

		try
		{
			
			orderdao.rejectOrderAprv(oseq, loginSeq);
			orderdao.setAprvRejected(oseq);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			txManager.rollback(txStatus);
			
			return false;
		}
		txManager.commit(txStatus);
		
		return true;
		
	}
	
}
