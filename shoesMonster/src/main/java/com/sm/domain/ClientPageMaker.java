package com.sm.domain;

import java.util.List;

public class ClientPageMaker {
	
	// 하단부 페이징처리
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int pageBlock = 5;
	
	private ClientPageVO clientPageVO;

	// =====================================
	
	public void setClientPageVO(ClientPageVO clientPageVO) {
		this.clientPageVO = clientPageVO;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcMyPage();
	}
	
	public void calcMyPage() {
		// 페이징처리 하단부에 필요한 정보 계산 - 시작
		
		endPage
			= (int)(Math.ceil(clientPageVO.getPage()/(double)pageBlock) * pageBlock);
		
		startPage
			= (endPage - pageBlock) + 1;
		
		int tmpEndPage
			= (int)(Math.ceil(totalCount/(double)clientPageVO.getPageSize()));
		
		if(endPage > tmpEndPage) {
			endPage = tmpEndPage;
		}
		
		// prev = (startPage == 1)? false : true;
		prev = startPage != 1; // 1 아니면 true
		
		next
			= (endPage * clientPageVO.getPageSize() >= totalCount)? false : true;
		
		// 페이징처리 하단부에 필요한 정보 계산 - 끝
	}
	
	public int getTotalCount() {
		return totalCount;
	}


	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getPageBlock() {
		return pageBlock;
	}

	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}

	public ClientPageVO getClientPageVO() {
		return clientPageVO;
	}

	@Override
	public String toString() {
		return "ClientPageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", prev=" + prev + ", next=" + next + ", pageBlock=" + pageBlock + ", clientPageVO=" + clientPageVO + "]";
	}


	
}
