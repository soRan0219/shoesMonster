package com.sm.domain;

import lombok.Data;

@Data
public class ManagementVO {
	
	private String title;
	private String programName;
	private Myenum settingPermissions;
	
}

enum Myenum {
	Y, N
}