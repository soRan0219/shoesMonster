package com.sm.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class WorkOrderVO {
	private String work_code;
	private String prod_code;
	private String order_code;
	private Date work_date;
	private String line_code;
	private int work_qt;
	private String emp_id;
	private String change_id;
	private Date change_date;
	private String work_state;
	
	
} //WorkOrder
