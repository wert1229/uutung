package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.OrderAprvDetailVO;
import com.sist.erp.vo.OrderAprvVO;
import com.sist.erp.vo.OrderCheckVO;
import com.sist.erp.vo.OrderDetailOseqVO;
import com.sist.erp.vo.OrderDetailVO;
import com.sist.erp.vo.OrderListDetailVO;
import com.sist.erp.vo.OrderListVO;
import com.sist.erp.vo.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO{


	@Autowired
	SqlSession session;
	
	@Override
	public List<OrderCheckVO> getOrderChecks(String dept) {
		return session.getMapper(OrderDAO.class).getOrderChecks(dept);
	
	}

	@Override
	public List<OrderDetailVO> getdetailList(String ocseq) {
		return session.getMapper(OrderDAO.class).getdetailList(ocseq);
	}

	@Override
	public void addOrder(OrderVO o) {
		session.getMapper(OrderDAO.class).addOrder(o);
	}

	@Override
	public void addOrderAprv(List<OrderAprvVO> oa) {

		session.getMapper(OrderDAO.class).addOrderAprv(oa);
	}

	@Override
	public void addOrderList(List<OrderListVO> ol) {

		session.getMapper(OrderDAO.class).addOrderList(ol);
	}

	@Override
	public void approveOrderAprv(String oseq, String loginSeq) {
		session.getMapper(OrderDAO.class).approveOrderAprv(oseq, loginSeq);
		
	}

	@Override
	public List<OrderListDetailVO> getOrderDetailListByOseq(String oseq) {
	
		return session.getMapper(OrderDAO.class).getOrderDetailListByOseq(oseq);
	}

	@Override
	public OrderDetailOseqVO getOrderDetailByOseq(String oseq) {
		
		return session.getMapper(OrderDAO.class).getOrderDetailByOseq(oseq);
	}

	@Override
	public List<OrderAprvDetailVO> getOrderAprvByOseq(String oseq) {
		
		return session.getMapper(OrderDAO.class).getOrderAprvByOseq(oseq);
	}

	@Override
	public void finishAprv(String oseq) {
		
		session.getMapper(OrderDAO.class).finishAprv(oseq);
	}

	@Override
	public String checkAprvFinished(String oseq) {
		
		return session.getMapper(OrderDAO.class).checkAprvFinished(oseq);
	}

	@Override
	public void addHistoryofOrder(String oseq, OrderListDetailVO o) {
		
		session.getMapper(OrderDAO.class).addHistoryofOrder(oseq, o);
		
	}

	@Override
	public void rejectOrderAprv(String oseq, String loginSeq) {
		session.getMapper(OrderDAO.class).rejectOrderAprv(oseq, loginSeq);
		
	}

	@Override
	public void setAprvRejected(String oseq) {

		session.getMapper(OrderDAO.class).setAprvRejected(oseq);
	}


}
