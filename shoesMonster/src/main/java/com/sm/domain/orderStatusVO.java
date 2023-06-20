package com.sm.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class orderStatusVO {
	private String order_code;
	private Date order_date;
	private String client_code;
	private String emp_id;
	private String prod_code;
	private String prod_name;
	private String prod_unit;
	private Date order_deliveryDate;
	private int order_count;
	private String order_finish;

} // oderStatusVO
