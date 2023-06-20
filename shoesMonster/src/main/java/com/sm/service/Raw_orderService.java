package com.sm.service;

import java.util.List;

import com.sm.domain.Raw_orderVO;

public interface Raw_orderService {
    
    // 발주 목록 조회
    public List<Raw_orderVO> getRaw_Order_List() throws Exception;
    
    // 입고 총 갯수
            public int count1() throws Exception;
            
            // 입고 페이지
            public List<Raw_orderVO> getRaw_orderPage(int displayPost,int postNum) throws Exception;

}