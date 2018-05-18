package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.MoveAprvDetailVO;
import com.sist.erp.vo.MoveAprvVO;
import com.sist.erp.vo.MoveDetailVO;
import com.sist.erp.vo.MoveListDetailVO;
import com.sist.erp.vo.MoveListVO;
import com.sist.erp.vo.MoveToDisplayVO;
import com.sist.erp.vo.MoveVO;

@Repository
public class MoveDAOImpl implements MoveDAO
{
	@Autowired
	SqlSession session;
	
	@Override
	public List<MoveVO> getMoves()
	{
		return session.getMapper(MoveDAO.class).getMoves();
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

	@Override
	public List<MoveToDisplayVO> getMovesToDisplay(String dept)
	{
		return session.getMapper(MoveDAO.class).getMovesToDisplay(dept);
	}

	@Override
	public List<MoveListDetailVO> getMoveListDetailByMseq(String mseq)
	{
		return session.getMapper(MoveDAO.class).getMoveListDetailByMseq(mseq);
	}

	@Override
	public MoveDetailVO getMoveDetailByMseq(String mseq)
	{
		return session.getMapper(MoveDAO.class).getMoveDetailByMseq(mseq);
	}

	@Override
	public List<MoveAprvDetailVO> getMoveAprvByMseq(String mseq)
	{
		return session.getMapper(MoveDAO.class).getMoveAprvByMseq(mseq);
	}

	@Override
	public void approveMoveAprv(String mseq, String loginSeq)
	{
		session.getMapper(MoveDAO.class).approveMoveAprv(mseq, loginSeq);
	}

	@Override
	public String checkAprvFinished(String mseq)
	{
		return session.getMapper(MoveDAO.class).checkAprvFinished(mseq);
	}

	@Override
	public void finishAprv(String mseq)
	{
		session.getMapper(MoveDAO.class).finishAprv(mseq);
	}
}