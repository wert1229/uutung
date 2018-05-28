package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.OrderAprvDetailVO;
import com.sist.erp.vo.OrderAprvVO;
import com.sist.erp.vo.OrderCheckVO;
import com.sist.erp.vo.OrderDetailOseqVO;
import com.sist.erp.vo.OrderDetailVO;
import com.sist.erp.vo.OrderListDetailVO;
import com.sist.erp.vo.OrderListVO;
import com.sist.erp.vo.OrderVO;

public interface OrderDAO { 

	List<OrderCheckVO> getOrderChecks(String dept);
	
	List<OrderDetailVO> getdetailList(String ocseq);
	
	void addOrder(OrderVO o);

	void addOrderAprv(List<OrderAprvVO> oa);

	void addOrderList(List<OrderListVO> ol);
	
	void approveOrderAprv(String oseq, String loginSeq);
	
	List<OrderListDetailVO> getOrderDetailListByOseq(String oseq);
	
	OrderDetailOseqVO getOrderDetailByOseq(String oseq);
	
	List<OrderAprvDetailVO> getOrderAprvByOseq(String oseq);
	
	void finishAprv(String oseq);

	String checkAprvFinished(String oseq);
	
	void addHistoryofOrder(String oseq, OrderListDetailVO o);
	
	void rejectOrderAprv(String oseq, String loginSeq);

	void setAprvRejected(String oseq);
}
