package com.sm.persistence;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.sm.domain.LineVO;
import com.sm.domain.ProductVO;

@Repository
public interface PerformanceDAO {
	
	// 품목관리 목록 불러오기
	public List<ProductVO> readProdList() throws Exception;
		
  // 품목관리 정보 다중 저장
	public void insertProdList(ProductVO product); 
		
	
	// 라인
	public void insertLine(LineVO vo) throws Exception;
	public List<LineVO> getLineList() throws Exception;
}
