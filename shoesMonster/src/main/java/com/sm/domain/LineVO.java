package com.sm.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class LineVO {
	private String line_code;
	private String line_name;
	private int line_use;
	private String emp_id;
	private String insert_date;
	private String line_note;
	private String line_place;
	
	private EmployeesVO emp;
	
} //LineVO
