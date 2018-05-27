package com.sist.erp.vo;

public class OrderVO {

	private String ocseq;
	private String title;
	private String slaveSq;
	private String estdate;
	private String clientSq;
	private String state;
	private String regdate;
	private String expdate;
	private String note;
	
	public String getOcseq()
	{
		return ocseq;
	}
	public void setOcseq(String ocseq)
	{
		this.ocseq = ocseq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSlaveSq() {
		return slaveSq;
	}
	public void setSlaveSq(String slaveSq) {
		this.slaveSq = slaveSq;
	}

	public String getEstdate() {
		return estdate;
	}
	public void setEstdate(String estdate) {
		this.estdate = estdate;
	}
	public String getClientSq() {
		return clientSq;
	}
	public void setClientSq(String clientSq) {
		this.clientSq = clientSq;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getExpdate() {
		return expdate;
	}
	public void setExpdate(String expdate) {
		this.expdate = expdate;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
}
