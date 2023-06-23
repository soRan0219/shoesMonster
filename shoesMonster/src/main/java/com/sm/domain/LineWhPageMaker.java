package com.sm.domain;

public class LineWhPageMaker {
	
	// 하단부 페이징처리

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int pageBlock = 10;
	
	private LineWhPageVO lwPageVO;
	
	//=======================================
	
	public void setLwPageVO(LineWhPageVO lwPageVO) {
		this.lwPageVO = lwPageVO;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcMyPage();
	}
	
	public void calcMyPage() {
		// 페이징처리 하단부에 필요한 정보 계산 - 시작
		
		endPage
			= (int)(Math.ceil(lwPageVO.getPage()/(double)pageBlock) * pageBlock);
		
		startPage
			= (endPage - pageBlock) + 1;
		
		int tmpEndPage
			= (int)(Math.ceil(totalCount/(double)lwPageVO.getPageSize()));
		
		if(endPage > tmpEndPage) {
			endPage = tmpEndPage;
		}
		
		// prev = (startPage == 1)? false : true;
		prev = startPage != 1; // 1이 아니면 true
		
		next
			= (endPage * lwPageVO.getPageSize() >= totalCount)? false : true;
		
		// 페이징처리 하단부에 필요한 정보 계산 - 끝
	}
	
	
	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getPageBlock() {
		return pageBlock;
	}

	public LineWhPageVO getLwPageVO() {
		return lwPageVO;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}

	@Override
	public String toString() {
		return "LineWhPageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", prev=" + prev + ", next=" + next + ", pageBlock=" + pageBlock + ", lwPageVO=" + lwPageVO + "]";
	}
	
}
