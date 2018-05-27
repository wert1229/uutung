package com.sist.erp.vo.temp;

public class HistoryVO
{
	private String target;
	private String pname;
	private int quantity;
	private int balance;
	private String kind;
	private String regdate;
	
	public String getTarget()
	{
		return target;
	}
	public void setTarget(String target)
	{
		this.target = target;
	}
	public String getPname()
	{
		return pname;
	}
	public void setPname(String pname)
	{
		this.pname = pname;
	}
	public int getQuantity()
	{
		return quantity;
	}
	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}
	public int getBalance()
	{
		return balance;
	}
	public void setBalance(int balance)
	{
		this.balance = balance;
	}
	public String getKind()
	{
		return kind;
	}
	public void setKind(String kind)
	{
		this.kind = kind;
	}
	public String getRegdate()
	{
		return regdate;
	}
	public void setRegdate(String regdate)
	{
		this.regdate = regdate;
	}
}
