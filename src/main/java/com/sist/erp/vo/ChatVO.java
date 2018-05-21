package com.sist.erp.vo;

public class ChatVO
{
	private int cseq;
	private String sender;
	private String senderName;
	private String senderPos;
	private String receiver;
	private String content;
	private String regdate;
	private String checkdate;
	
	public int getCseq()
	{
		return cseq;
	}
	public void setCseq(int cseq)
	{
		this.cseq = cseq;
	}
	public String getSender()
	{
		return sender;
	}
	public void setSender(String sender)
	{
		this.sender = sender;
	}
	public String getSenderName()
	{
		return senderName;
	}
	public void setSenderName(String senderName)
	{
		this.senderName = senderName;
	}
	public String getSenderPos()
	{
		return senderPos;
	}
	public void setSenderPos(String senderPos)
	{
		this.senderPos = senderPos;
	}
	public String getReceiver()
	{
		return receiver;
	}
	public void setReceiver(String receiver)
	{
		this.receiver = receiver;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getRegdate()
	{
		return regdate;
	}
	public void setRegdate(String regdate)
	{
		this.regdate = regdate;
	}
	public String getCheckdate()
	{
		return checkdate;
	}
	public void setCheckdate(String checkdate)
	{
		this.checkdate = checkdate;
	}
}
