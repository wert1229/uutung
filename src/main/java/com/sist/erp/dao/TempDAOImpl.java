package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.EstiProductVO;
import com.sist.erp.vo.TempVO;

@Repository
public class TempDAOImpl implements TempDAO
{
	@Autowired
	SqlSession session;

	@Override
	public List<TempVO> searchProduct(String key)
	{
		String realKey = "%"+key+"%";
		
		return session.getMapper(TempDAO.class).searchProduct(realKey);
	}

	@Override
	public List<EstiProductVO> searchEstProduct(String key, String cseq) {
		
		String realKey = "%"+key+"%";
		
		return session.getMapper(TempDAO.class).searchEstProduct(realKey, cseq);
	}

}
