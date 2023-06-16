package com.sm.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;

@Repository
public interface PerformanceDAO {
	
	public void insetProd(ProductVO vo);
	
	// 라인
	public void insertLine(LineVO vo) throws Exception;
	public List<LineVO> getLineList() throws Exception;
}
