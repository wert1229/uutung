package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.ProductVO;

public interface ProductDAO {

	List<ProductVO> getProducts();

	List<ProductVO> getProductsAsc();
	
	ProductVO getProduct(String pseq);

	void addProduct(ProductVO p);

	void updateProduct(ProductVO p);

	void delProduct(String pseq);

	List<ProductVO> searchProduct(String key);

	void okProduct(String pseq);
}