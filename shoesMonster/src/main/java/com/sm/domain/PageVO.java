package com.sm.domain;

import lombok.Data;

@Data
public class PageVO {
	
	private int page;
	private int pageSize;
	
	public PageVO() {
		this.page = 1;
		this.pageSize = 50;
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPageSize() {
		return pageSize;
	}
	
	public int getStartPage() {
		
		return (this.page - 1) * this.pageSize;
	}

}
