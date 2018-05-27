package com.sist.erp.vo;

public class ProductVO {
	private String pseq;
	private String name;
	private String img;
	private String category;
	private String note;
	private String state;
	
	public ProductVO() {
		this(null, null, null, null, null, null);
	}
	
	public ProductVO(String pseq, String name, String img, String category, String note, String state) {
		this.pseq = pseq;
		this.name = name;
		this.img = img;
		this.category = category;
		this.note = note;
		this.state = state;
	}

	public String getPseq() {
		return pseq;
	}

	public void setPseq(String pseq) {
		this.pseq = pseq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}