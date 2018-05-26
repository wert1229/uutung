package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.temp.BalanceVO;
import com.sist.erp.vo.temp.HistoryVO;

public interface TempDAO
{
	List<BalanceVO> getBalances();

	List<HistoryVO> getHistory(String bseq, String pseq);
}
