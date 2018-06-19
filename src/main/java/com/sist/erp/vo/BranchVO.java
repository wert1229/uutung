package com.sist.erp.vo;

public class BranchVO
{
	private String bseq;
	private String name;
	private String manager;
	private String managerName;
	private String managerPos;
	private String phone;
	private String location;
	
	public String getBseq()
	{
		return bseq;
	}
	public void setBseq(String bseq)
	{
		this.bseq = bseq;
	}
	public String getManagerPos()
	{
		return managerPos;
	}
	public void setManagerPos(String managerPos)
	{
		this.managerPos = managerPos;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getManager()
	{
		return manager;
	}
	public void setManager(String manager)
	{
		this.manager = manager;
	}
	public String getManagerName()
	{
		return managerName;
	}
	public void setManagerName(String managerName)
	{
		this.managerName = managerName;
	}
	public String getPhone()
	{
		return phone;
	}
	public void setPhone(String phone)
	{
		this.phone = phone;
	}
	public String getLocation()
	{
		return location;
	}
	public void setLocation(String location)
	{
		this.location = location;
	}
}
