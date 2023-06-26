package com.sm.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class RawMaterialList {
	private List<RawMaterialVO> raws;
	
	public RawMaterialList() {
		raws = new ArrayList<RawMaterialVO>();
	}
	
}