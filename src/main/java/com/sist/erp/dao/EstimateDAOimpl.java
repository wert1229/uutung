package com.sist.erp.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.erp.vo.EstiProductVO;
import com.sist.erp.vo.EstimateVO;

@Repository
public class EstimateDAOimpl implements EstimateDAO {
	
	@Autowired
	SqlSession session;

	@Override
	public List<EstimateVO> getEstimates() {
		return session.getMapper(EstimateDAO.class).getEstimates();
	}

	@Override
	public EstimateVO getEstimate(String eseq) {
		return session.getMapper(EstimateDAO.class).getEstimate(eseq);
	}

	@Override
	public void addEstimate(EstimateVO e) {
		session.getMapper(EstimateDAO.class).addEstimate(e);
	}

	@Override
	public void updateEstimate(EstimateVO e) {
		session.getMapper(EstimateDAO.class).updateEstimate(e);
	}

	@Override
	public void delEstimate(String eseq) {
		session.getMapper(EstimateDAO.class).delEstimate(eseq);
	}

	@Override
	public List<EstimateVO> searchEstimate(String key) {
		String realKey = "%" + key + "%";
		return session.getMapper(EstimateDAO.class).searchEstimate(realKey);
	}

	@Override
	public void okEstimate(String eseq) {
		session.getMapper(EstimateDAO.class).okEstimate(eseq);
	}
	
	@Override
	public List<EstiProductVO> searchEstProduct(String key, String cseq) {
		
		String realKey = "%"+key+"%";
		
		return session.getMapper(EstimateDAO.class).searchEstProduct(realKey, cseq);
	}

	@Override
	public List<EstimateVO> getDetailEstimates(String pseq) {
		return session.getMapper(EstimateDAO.class).getDetailEstimates(pseq);
	}
}