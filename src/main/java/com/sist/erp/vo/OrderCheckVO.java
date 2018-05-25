package com.sist.erp.vo;

import java.util.List;

public class OrderCheckVO {

	private String ocseq;
	private String title;
	private String name;
	private String estdate;
	private String state;
	private String note;
	
	public String getEstdate() {
		return estdate;
	}
	public void setEstdate(String estdate) {
		this.estdate = estdate;
	}
	
	public String getOcseq() {
		return ocseq;
	}
	public void setOcseq(String ocseq) {
		this.ocseq = ocseq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}

	
	
	
}
