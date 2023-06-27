package com.sm.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class RequirementsList {
	private List<RequirementsVO> reqs;
	
	public RequirementsList() {
		reqs = new ArrayList<RequirementsVO>();
	}
	
}