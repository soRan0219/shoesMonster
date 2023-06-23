package com.sm.domain;

import lombok.Data;

@Data
public class ClientsVO {

	private String client_code;
	private String client_actname;
	private String client_type;
	private String client_number;
	private String client_sort;
	private String client_ceo;
	private String client_name;
	private String client_addr;
	private String client_addr2;
	private String client_tel;
	private String client_phone;
	private String client_fax;
	private String client_email;
	private String client_note;
	
	private EmployeesVO employees;
	private OrderStatusVO orders;
	
} // ClientsVO
