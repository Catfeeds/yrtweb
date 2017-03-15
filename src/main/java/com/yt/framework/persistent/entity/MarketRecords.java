package com.yt.framework.persistent.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 俱乐部购买球员记录表
 * @author bo.xie
 *
 */
public class MarketRecords {

	private String id;
	private String manager_id;//购买者ID
	private String m_id;//市场球员表记录id
	private BigDecimal buy_price;//购买价格
	private Date buy_time;//购买时间
	private String f_id;//冻结资金ID
	private int if_bid;//是否中标 0：否1：是
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getManager_id() {
		return manager_id;
	}
	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public BigDecimal getBuy_price() {
		return buy_price;
	}
	public void setBuy_price(BigDecimal buy_price) {
		this.buy_price = buy_price;
	}
	public Date getBuy_time() {
		return buy_time;
	}
	public void setBuy_time(Date buy_time) {
		this.buy_time = buy_time;
	}
	public String getF_id() {
		return f_id;
	}
	public void setF_id(String f_id) {
		this.f_id = f_id;
	}
	public int getIf_bid() {
		return if_bid;
	}
	public void setIf_bid(int if_bid) {
		this.if_bid = if_bid;
	}
	
}
