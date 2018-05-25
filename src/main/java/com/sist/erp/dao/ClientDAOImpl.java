package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.ClientVO;

@Repository
public class ClientDAOImpl implements ClientDAO{

	@Autowired
	SqlSession session;
	
	@Override
	public ClientVO getClient(String cseq) {
		
		return session.getMapper(ClientDAO.class).getClient(cseq);
	}

	@Override
	public int deleteClient(ClientVO c) {
		
		return session.getMapper(ClientDAO.class).deleteClient(c);
	}

	@Override
	public void updateClient(ClientVO c) {
		
		session.getMapper(ClientDAO.class).updateClient(c);
	}

	@Override
	public int addClient(ClientVO c) {
		
		return session.getMapper(ClientDAO.class).addClient(c);
	}

	@Override
	public List<ClientVO> getClients() {
		
		return session.getMapper(ClientDAO.class).getClients();
	}

	@Override
	public List<ClientVO> searchClients(String key) {
		
		String realKey = "%"+key+"%";
		return session.getMapper(ClientDAO.class).searchClients(realKey);
	}
}
