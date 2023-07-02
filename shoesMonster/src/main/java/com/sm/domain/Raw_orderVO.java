package com.sm.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Raw_orderVO {

	private String raw_order_num;
	private String raw_code;
	private String client_code;
	private String emp_id;
	private int raw_order_count;
	private Date raw_order_date;
	
	private RawMaterialVO rawMaterial;
	private ClientsVO clients;
	private StockVO stock;
	private In_materialVO in_mat;
	private WarehouseVO warehouse;
	
	public Raw_orderVO () {
		
		rawMaterial = new RawMaterialVO();
		clients = new ClientsVO();
		stock = new StockVO();
		in_mat = new In_materialVO();
		
	}
	
	
	
}
