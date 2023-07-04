package com.sm.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderStatusVO {
	private String order_code;
	private Date order_date;
	private Date order_deliveryDate;
	private String emp_id;
	private int order_count;
	private String client_code;
	private String order_finish;
	private String oreder_note;
	
	private ClientsVO clients;
	private ProductVO prod;
	private Out_materialVO out_mat;
	
	public OrderStatusVO() {
		clients = new ClientsVO();
//		out_mat = new Out_materialVO();
		prod = new  ProductVO();
		// orderStatus 페이지 안돌아가서 주석처리함 이거때문에 문제 생기면 이도희 찾아오셈
		
//		clients = new ClientsVO();	
	}
	
	
}
