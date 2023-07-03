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
	
	private OrderStatusVO orders;
	private ClientsVO client;
	private Out_materialVO out_mat;
	
	public ProductVO() {
		orders = new OrderStatusVO();
		client = new ClientsVO();
		out_mat = new Out_materialVO();
	
	
	}
	
} //productVO