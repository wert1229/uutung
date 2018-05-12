package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.BranchVO;

@Repository
public class BranchDAOImpl implements BranchDAO
{
	@Autowired
	SqlSession session;
	
	@Override
	public List<BranchVO> getBranches()
	{
		return session.getMapper(BranchDAO.class).getBranches();
	}

	@Override
	public void addBranch(BranchVO b)
	{
		session.getMapper(BranchDAO.class).addBranch(b);
	}

	@Override
	public List<BranchVO> searchBranches(String key)
	{
		String realKey = "%"+key+"%";
		
		return session.getMapper(BranchDAO.class).searchBranches(realKey);
	}
}
