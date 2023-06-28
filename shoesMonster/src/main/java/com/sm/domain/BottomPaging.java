package com.sm.domain;

public class BottomPaging {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int pageBlock = 10;
	
	private PageVO pageVO;
	
	
	public void setPageVO(PageVO pageVO) {
		this.pageVO = pageVO;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// DB에서 계산된 정보 가져오기
		calcMyPage();
	}
	
	public void calcMyPage() {
		// 페이징처리 하단에 필요한 정보 계산 - 시작
		endPage = (int)(Math.ceil(pageVO.getPage()/(double)pageBlock) * pageBlock);
		startPage = (endPage - pageBlock) + 1;
		
		int tmpEndpage = (int)(Math.ceil(totalCount / (double)pageVO.getPageSize()));
		
		if(endPage > tmpEndpage) {
			endPage = tmpEndpage;
		}
		
		
		prev = startPage != 1;
		
		next = (endPage * pageVO.getPageSize() >= totalCount)? false : true;
		// 페이징처리 하단에 필요한 정보 계산 - 끝
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

	public PageVO getPageVO() {
		return pageVO;
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
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", pageBlock=" + pageBlock + ", pageVO=" + pageVO + "]";
	}

	

}
