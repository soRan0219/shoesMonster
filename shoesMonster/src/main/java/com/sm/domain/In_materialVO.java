package com.sm.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class In_materialVO {

	private String in_num;
	private String raw_order_num;
	private String emp_id;
	private String client_code;
	private String in_text;
	private Date in_date;
	private int in_count ;
	private String in_YN;
	
//	private Raw_orderVO rawOrder;
//	private ClientsVO clients;
//	private RawMaterialVO raw_mat;
//	private StockVO stock;
//	
//	public In_materialVO() {
//		rawOrder = new Raw_orderVO();
//		clients = new ClientsVO();
//		raw_mat = new RawMaterialVO();
//		stock = new StockVO();
//	}
	
}
