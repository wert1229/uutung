package com.sist.erp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.sist.erp.dao.ProductDAO;
import com.sist.erp.util.ProductExcelDown;
import com.sist.erp.vo.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	private ProductDAO pdao;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String productHome(Model model, String page) {
		
		List<ProductVO> plist = pdao.getProducts();
		
		if(page!=null) {
			model.addAttribute("page", page);
		}
		
		model.addAttribute("plist",plist);
		
		return "product/mainProduct";
	}
	
	@RequestMapping("/new")
	public String addProduct() {
		return "product/addProduct";
	}

	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public String editProduct(Model model, String pseq, String page) {
		ProductVO p = pdao.getProduct(pseq);
		
		model.addAttribute("page", page);
		model.addAttribute("product", p);
			
		return "product/editProduct";
	}
		
	@RequestMapping(value="", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute ProductVO p, Model model, HttpServletRequest request) {
		
		/*String path = "/image";
		String realPath = request.getServletContext().getRealPath(path);
		System.out.println("path: " + path);
		System.out.println("realPath: " + realPath);
		
		MultipartRequest mulReq;
		try {
			mulReq = new MultipartRequest(request, realPath, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			String fileName = mulReq.getFilesystemName("file");
			String orifileName = mulReq.getOriginalFileName("file");
			System.out.println("fileName: " + fileName);
			System.out.println("orifileName: " + orifileName);
		} catch (IOException e) {
			e.printStackTrace();
		}*/
		
		pdao.addProduct(p);

		model.addAttribute("flag", "1");

		return "product/addProduct";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public String editProduct(@ModelAttribute ProductVO p, String page, Model model) {
	
		pdao.updateProduct(p);
	
		model.addAttribute("flag", "1");
		model.addAttribute("page", page);
	
		return "product/editProduct";
	}
		
	@ResponseBody
	@RequestMapping(value="/delProduct", method=RequestMethod.POST)
	public boolean delProduct(@RequestBody String checkList) {
		System.out.println(checkList);
		
		Gson gson = new Gson();
	
		String[] list = gson.fromJson(checkList, String[].class);
	
		for(String pseq : list) {
			pdao.delProduct(pseq);
		}
	
		return true;
	}
	
	@RequestMapping(value="/searchProduct", method=RequestMethod.GET)
	public String searchProduct() {
		return "searchProduct";
	}
		
	@ResponseBody
	@RequestMapping(value="/searchProduct", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String searchProduct(@RequestParam String key) {
		Gson gson = new Gson();
	
		List<ProductVO> plist = pdao.searchProduct(key);
		
		String plistJson = gson.toJson(plist);
		
		return plistJson;
	}
		
	@RequestMapping("/pExcelDownload")
	public View pExcelDownload(Model model) {
		List<ProductVO> plist = pdao.getProducts();
	
		model.addAttribute("plist", plist);
	
		return new ProductExcelDown();
	}
}