package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.MoveAprvVO;
import com.sist.erp.vo.MoveListVO;
import com.sist.erp.vo.MoveVO;

@Repository
public class MoveDAOImpl implements MoveDAO
{
	@Autowired
	SqlSession session;
	
	@Override
	public List<MoveVO> getMoves()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MoveVO getMove(String mseq)
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addMove(MoveVO m)
	{
		session.getMapper(MoveDAO.class).addMove(m);
	}

	@Override
	public void addMoveAprv(List<MoveAprvVO> ma)
	{
		session.getMapper(MoveDAO.class).addMoveAprv(ma);
	}

	@Override
	public void addMoveList(List<MoveListVO> ml)
	{
		session.getMapper(MoveDAO.class).addMoveList(ml);
	}
}