package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.EstiProductVO;
import com.sist.erp.vo.TempVO;

public interface TempDAO
{
	List<TempVO> searchProduct(String key);
	
	List<EstiProductVO> searchEstProduct(String key, String cseq);
	
}
