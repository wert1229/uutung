package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.ApproveFromMeVO;
import com.sist.erp.vo.ApproveToMeVO;

public interface ApproveDAO
{
	List<ApproveFromMeVO> getApprovesFromMe(String loginSeq);
 
	List<ApproveToMeVO> getApprovesToMe(String loginSeq);
}
