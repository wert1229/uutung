package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.TempVO;

public interface TempDAO
{
	List<TempVO> searchProduct(String key);
}
