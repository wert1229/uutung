package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.InventoryVO;

@Repository
public class InventoryDAOImpl implements InventoryDAO{

	@Autowired
	SqlSession session;
	
	
	@Override
	public List<InventoryVO> getInventorys() {
		return session.getMapper(InventoryDAO.class).getInventorys();
	}

}
