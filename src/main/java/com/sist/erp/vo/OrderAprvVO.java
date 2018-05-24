package com.sist.erp.vo;

public class OrderAprvVO {

	private String oaseq;
	private String orderdSq;
	private String approver;
	private int priority;
	private String state;
	
	public String getOaseq() {
		return oaseq;
	}
	public void setOaseq(String oaseq) {
		this.oaseq = oaseq;
	}
	public String getOrderdSq() {
		return orderdSq;
	}
	public void setOrderdSq(String orderdSq) {
		this.orderdSq = orderdSq;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	
}

