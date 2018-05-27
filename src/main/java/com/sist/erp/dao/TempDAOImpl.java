package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.temp.BalanceVO;
import com.sist.erp.vo.temp.HistoryVO;

@Repository
public class TempDAOImpl implements TempDAO
{
	@Autowired
	SqlSession session;
	
	@Override
	public List<BalanceVO> getBalances()
	{
		return session.getMapper(TempDAO.class).getBalances();
	}

	@Override
	public List<HistoryVO> getHistory(String bseq, String pseq)
	{
		return session.getMapper(TempDAO.class).getHistory(bseq, pseq);
	}

}
