package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.ClientVO;

public interface ClientDAO {
	
	ClientVO getClient(String cseq); 
	
	int deleteClient(ClientVO c);
	
	void updateClient(ClientVO c);
	
	int addClient(ClientVO c);
	
	List<ClientVO> getClients();
	
	List<ClientVO> searchClients(String key);
	
}
