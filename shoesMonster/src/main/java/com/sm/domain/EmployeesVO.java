package com.sm.domain;

import lombok.Data;

@Data
public class EmployeesVO {
	
	private String emp_id;
	private String emp_pw;
	private String emp_name;
	private String emp_department;
	private String emp_position;
	private String emp_email;
	private String emp_phone;
	private String emp_work;
	private String emp_addr;
	private String emp_birth;
	private String emp_gender;
	private String emp_file;
	private String emp_hiredate;
	private String emp_tel;
	private String img;
	
	private String hyphenPhone;
	private String hyphenEmail;
	
	public void setEmp_ehone(String emp_phone) {
		this.emp_phone = emp_phone;
		this.hyphenPhone = emp_phone.replace("-", "");
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
		this.hyphenEmail = emp_email.replace("-", "");
	}

	public String getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}

	
	
	
	
	
}
