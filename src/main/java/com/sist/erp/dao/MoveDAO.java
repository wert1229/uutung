package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.MoveAprvVO;
import com.sist.erp.vo.MoveListDetailVO;
import com.sist.erp.vo.MoveListVO;
import com.sist.erp.vo.MoveToDisplayVO;
import com.sist.erp.vo.MoveVO;

public interface MoveDAO
{
	List<MoveVO> getMoves();

	MoveVO getMove(String mseq);

	void addMove(MoveVO m);

	void addMoveAprv(List<MoveAprvVO> ma);

	void addMoveList(List<MoveListVO> ml);

	List<MoveToDisplayVO> getMovesToDisplay(String dept);

	List<MoveListDetailVO> getMoveListDetailByMseq(String mseq);
}
