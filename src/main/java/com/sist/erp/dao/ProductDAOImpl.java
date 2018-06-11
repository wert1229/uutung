package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.ProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Autowired
	SqlSession session;

	@Override
	public List<ProductVO> getProducts() {
		return session.getMapper(ProductDAO.class).getProducts();
	}
	
	@Override
	public List<ProductVO> getProductsAsc() {
		return session.getMapper(ProductDAO.class).getProductsAsc();
	}

	@Override
	public ProductVO getProduct(String pseq) {
		return session.getMapper(ProductDAO.class).getProduct(pseq);
	}

	@Override
	public void addProduct(ProductVO p) {
		session.getMapper(ProductDAO.class).addProduct(p);
	}

	@Override
	public void updateProduct(ProductVO p) {
		session.getMapper(ProductDAO.class).updateProduct(p);
	}

	@Override
	public void delProduct(String pseq) {
		session.getMapper(ProductDAO.class).delProduct(pseq);
	}

	@Override
	public List<ProductVO> searchProduct(String key) {
		String realKey = "%" + key + "%";
		return session.getMapper(ProductDAO.class).searchProduct(realKey);
	}
}