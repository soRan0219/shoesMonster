package com.sm.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class PerformanceVO {
	private String perform_code;
	private String work_code;
	private Date perform_date;
	private int perform_qt;
	private String emp_id;
	private String change_id;
	private Date change_date;
	private int perform_fair;
	private int perform_defect;
	private String defect_note;
	private String perform_note;
	
} //Performance
