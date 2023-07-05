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
	private String oreder_note;
	private String prod_code;
	
	private ClientsVO clients;
	private ProductVO prod;
	private EmployeesVO employees;
	
	public OrderStatusVO() {
		clients = new ClientsVO();
		prod = new  ProductVO();
		employees = new EmployeesVO();
		
	}
	
	
}
