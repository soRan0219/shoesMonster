package com.sm.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ProductList {
	private List<ProductVO> products;
	
	public ProductList() {
		products = new ArrayList<ProductVO>();
	}
	
}
