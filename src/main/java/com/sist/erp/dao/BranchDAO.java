package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.BranchVO;

public interface BranchDAO
{
	List<BranchVO> getBranches();

	void addBranch(BranchVO b);

	List<BranchVO> searchBranches(String key);

	void delBranch(String bseq);

	BranchVO getBranch(String bseq);

	void updateBranch(BranchVO b);
}
