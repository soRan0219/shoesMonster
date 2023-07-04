package com.sm.domain;

import lombok.Data;

@Data
public class ProductVO {
	private String prod_code;
	private String prod_name;
	private String prod_category;
	private String prod_unit;
	private String prod_size;
	private String prod_color;
	private String client_code;
	private float prod_price;
	private String prod_note;
	private String wh_code;
	
	private ClientsVO clients;
	private Wh_prodVO wh;
	private OrderStatusVO orders;
	
	public ProductVO() {
		clients = new ClientsVO();
		wh = new Wh_prodVO();
//		orders = new OrderStatusVO();
	}
	
	
} //productVO