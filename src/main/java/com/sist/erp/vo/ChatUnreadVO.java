package com.sist.erp.vo;

public class ChatUnreadVO
{
	private String sender;
	private String senderName;
	private String senderPos;
	private int unread;
	
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
	public int getUnread()
	{
		return unread;
	}
	public void setUnread(int unread)
	{
		this.unread = unread;
	}
}
