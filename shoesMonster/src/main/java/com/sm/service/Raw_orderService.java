package com.sm.service;

import java.util.List;

import com.sm.domain.ClientsVO;
import com.sm.domain.In_materialVO;
import com.sm.domain.PageVO;
import com.sm.domain.Raw_orderVO;
import com.sm.domain.WarehouseVO;

public interface Raw_orderService {
	
	// 발주 목록 조회
	public List<Raw_orderVO> getRaw_order(PageVO vo) throws Exception;
	
	// 발주 목록 개수
	public int count1() throws Exception;
	
	// 발주 등록(팝업)
	public List<Raw_orderVO> getPopup(PageVO vo) throws Exception;
	
	// 발주 (팝업)리스트 갯수
    public int countPoP() throws Exception;
	
	// 창고 등록(팝업)
	public List<WarehouseVO> whPopup() throws Exception;
	
	// 발주 등록
	public void roInsert(Raw_orderVO vo, String emp_id) throws Exception;
	
	// 거래처 상세(팝업)
	public List<Raw_orderVO> getDetail() throws Exception;
	
	// 발주 검색 목록 갯수
	public int count1(Raw_orderVO rvo) throws Exception;
	
	// 발주 검색 목록 조회
	public List<Raw_orderVO> getRaw_order(PageVO vo, Raw_orderVO rvo) throws Exception;
	
	// 발주 팝업 검색 갯수
    public int countPop(Raw_orderVO rvo) throws Exception;
    
    // 발주 팝업 검색 목록
    public List<Raw_orderVO> Popup(PageVO vo ,Raw_orderVO rvo) throws Exception;
    
    // 발주 취소 팝업
    public List<ClientsVO> detailPopup(String rawCode) throws Exception;
    
    // 발주 취소 버튼
    public void roCancel(String raw_order_num) throws Exception;
    

}