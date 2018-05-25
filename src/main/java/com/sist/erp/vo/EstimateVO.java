package com.sist.erp.vo;

public class EstimateVO {
	private String eseq;
	private int price;
	private String productSq;
	private String productName;
	private String clientSq;
	private String clientName;
	
	public EstimateVO() {
		this(null, 0, null, null, null, null);
	}
	
	public EstimateVO(String eseq, int price, String productSq, String productName, String clientSq, String clientName) {
		this.eseq = eseq;
		this.price = price;
		this.productSq = productSq;
		this.productName = productName;
		this.clientSq = clientSq;
		this.clientName = clientName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getEseq() {
		return eseq;
	}

	public void setEseq(String eseq) {
		this.eseq = eseq;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProductSq() {
		return productSq;
	}

	public void setProductSq(String productSq) {
		this.productSq = productSq;
	}

	public String getClientSq() {
		return clientSq;
	}

	public void setClientSq(String clientSq) {
		this.clientSq = clientSq;
	}
}