package com.sm.domain.a;


import lombok.Data;

@Data
public class StockVO {

	private String stock_num;
	private String raw_code;
	private String wh_code;
	private String stock_text;
	private String prod_code;
	private String in_num;
	private int stock_raw_count;
}
