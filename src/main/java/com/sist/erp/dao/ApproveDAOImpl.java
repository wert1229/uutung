package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.ApproveFromMeVO;
import com.sist.erp.vo.ApproveToMeVO;

@Repository
public class ApproveDAOImpl implements ApproveDAO
{
	@Autowired
	SqlSession session;
	
	@Override
	public List<ApproveFromMeVO> getApprovesFromMe(String loginSeq)
	{
		return session.getMapper(ApproveDAO.class).getApprovesFromMe(loginSeq);
	}

	@Override
	public List<ApproveToMeVO> getApprovesToMe(String loginSeq)
	{
		return session.getMapper(ApproveDAO.class).getApprovesToMe(loginSeq);
	}

}
