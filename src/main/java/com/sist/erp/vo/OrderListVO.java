package com.sist.erp.vo;

public class OrderListVO {

	private String olseq;
	private String productSq;
	private int price;
	private int quantity;
	private String orderSq;
	
	public String getOlseq() {
		return olseq;
	}
	public void setOlseq(String olseq) {
		this.olseq = olseq;
	}
	public String getProductSq() {
		return productSq;
	}
	public void setProductSq(String productSq) {
		this.productSq = productSq;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getOrderSq()
	{
		return orderSq;
	}
	public void setOrderSq(String orderSq)
	{
		this.orderSq = orderSq;
	}
}
