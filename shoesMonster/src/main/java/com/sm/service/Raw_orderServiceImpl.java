package com.sm.service;


import java.util.List;

import com.sm.domain.Raw_orderVO;
import com.sm.persistence.Raw_orderDAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Raw_orderServiceImpl implements Raw_orderService{
    
    @Autowired
    private Raw_orderDAO rodao;
    
    
    @Override
    public List<Raw_orderVO> getRaw_Order_List() throws Exception {
        
        return rodao.readRaw_Order();
    }
    
    

}