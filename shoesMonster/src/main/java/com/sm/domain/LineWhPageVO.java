package com.sm.domain;

public class LineWhPageVO {
	
	private int page;
	
	private int pageSize;
	
	public LineWhPageVO() {
		this.page = 1;
		this.pageSize = 10;
	}
	
	// 제어설정
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	public void setPageSize(int pageSize) {
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
			return;
		}
		this.pageSize = pageSize;
	}
	
	public int getPage() {
		return page;
	}

	public int getPageSize() {
		return pageSize;
	}
	
	// 시작인덱스 계산
	public int getStartPage() {
		return (this.page - 1) * this.pageSize;
	}

	@Override
	public String toString() {
		return "LineWhPageVO [page=" + page + ", pageSize=" + pageSize + "]";
	}
	
}
