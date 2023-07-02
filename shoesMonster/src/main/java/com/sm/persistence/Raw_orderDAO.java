package com.sm.persistence;

import java.util.List;

import com.sm.domain.ClientsVO;
import com.sm.domain.In_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.Raw_orderVO;
import com.sm.domain.WarehouseVO;

public interface Raw_orderDAO {

	
	// 발주 목록 조회
	public List<Raw_orderVO> Raw_order(PageVO vo) throws Exception;
	
	// 글 총 갯수
	public int count1() throws Exception;
    
	// 발주 등록(팝업)
	public List<Raw_orderVO> Popup(PageVO vo) throws Exception;
	
	//창고 팝업리스트 갯수
    public int countPop() throws Exception;
	
	// 창고 등록(팝업)
	public List<WarehouseVO> whPopup() throws Exception;
	
	// 발주 등록
 	public void roInsert(Raw_orderVO vo) throws Exception;
 	
 	
    
 	// 거래처 상세(팝업)
 	public List<Raw_orderVO> getDetail() throws Exception;

	// 발주 검색 총 갯수 
	public int count1(Raw_orderVO rvo) throws Exception;
	    
	// 발주 검색 목록
	public List<Raw_orderVO> Raw_order(PageVO vo, Raw_orderVO rvo) throws Exception;

    
  
}

