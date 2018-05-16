package com.sist.erp.vo;

public class MoveListDetailVO
{
	private String mlseq;
	private String productSq;
	private String productName;
	private int quantity;
	private String category;
	private String note;
	
	public String getMlseq()
	{
		return mlseq;
	}
	public void setMlseq(String mlseq)
	{
		this.mlseq = mlseq;
	}
	public String getProductSq()
	{
		return productSq;
	}
	public void setProductSq(String productSq)
	{
		this.productSq = productSq;
	}
	public String getProductName()
	{
		return productName;
	}
	public void setProductName(String productName)
	{
		this.productName = productName;
	}
	public int getQuantity()
	{
		return quantity;
	}
	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}
	public String getCategory()
	{
		return category;
	}
	public void setCategory(String category)
	{
		this.category = category;
	}
	public String getNote()
	{
		return note;
	}
	public void setNote(String note)
	{
		this.note = note;
	}
}
