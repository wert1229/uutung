package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.MoveVO;

public interface MoveDAO
{
	List<MoveVO> getMoves();

	MoveVO getMove(String mseq);

	void addMove(MoveVO m);
}
