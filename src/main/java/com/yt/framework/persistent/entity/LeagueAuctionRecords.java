package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 球员竞拍市场表
 *@autor ylt
 *@date2015-11-10下午6:59:46
 */
public class LeagueAuctionRecords implements Serializable{
	private static final long serialVersionUID = 757699940046461641L;
	
	private String id;//
	private String manager_id ;// 购买者id
	private String auc_id ;//竞拍表id
	private BigDecimal bid_price;//竞拍价
	private Date bid_time;//得拍价
	private String team_id;//俱乐部
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
	public String getAuc_id() {
		return auc_id;
	}
	public void setAuc_id(String auc_id) {
		this.auc_id = auc_id;
	}
	public BigDecimal getBid_price() {
		return bid_price;
	}
	public void setBid_price(BigDecimal bid_price) {
		this.bid_price = bid_price;
	}
	public Date getBid_time() {
		return bid_time;
	}
	public void setBid_time(Date bid_time) {
		this.bid_time = bid_time;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public int getIf_bid() {
		return if_bid;
	}
	public void setIf_bid(int if_bid) {
		this.if_bid = if_bid;
	}
	public String getF_id() {
		return f_id;
	}
	public void setF_id(String f_id) {
		this.f_id = f_id;
	}
		
}
