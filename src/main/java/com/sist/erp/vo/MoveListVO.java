package com.sist.erp.vo;

public class MoveListVO
{
	private String mlseq;
	private String productSQ;
	private int quantity;
	private String moveSQ;
	
	public String getMlseq()
	{
		return mlseq;
	}
	public void setMlseq(String mlseq)
	{
		this.mlseq = mlseq;
	}
	public String getProductSQ()
	{
		return productSQ;
	}
	public void setProductSQ(String productSQ)
	{
		this.productSQ = productSQ;
	}
	public int getQuantity()
	{
		return quantity;
	}
	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}
	public String getMoveSQ()
	{
		return moveSQ;
	}
	public void setMoveSQ(String moveSQ)
	{
		this.moveSQ = moveSQ;
	}
}
