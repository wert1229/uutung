package com.sist.erp.dao;

import java.util.List;

import com.sist.erp.vo.EstiProductVO;
import com.sist.erp.vo.EstimateVO;

public interface EstimateDAO {

	List<EstimateVO> getEstimates();

	EstimateVO getEstimate(String eseq);

	void addEstimate(EstimateVO e);

	void updateEstimate(EstimateVO e);

	void delEstimate(String eseq);

	List<EstimateVO> searchEstimate(String key);

	void okEstimate(String eseq);

	List<EstiProductVO> searchEstProduct(String key, String cseq);

	List<EstimateVO> getDetailEstimates(String pseq);
}
