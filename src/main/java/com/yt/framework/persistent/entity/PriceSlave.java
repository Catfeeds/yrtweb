package com.yt.framework.persistent.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 身价entity
 * @author bo.xie
 * @date 2015年11月18日12:00:11
 */
public class PriceSlave {

	private String id;
	/**
	 * 用户ID
	 */
	private String user_id;
	/**
	 * 联赛ID
	 */
	private String league_id;
	
	/**
	 * 赛季分类id
	 */
	private String s_id;
	
	/**
	 * 身价
	 */
	private BigDecimal price;
	/**
	 * 角色类型：1：球迷；2:球员；3:球队；4：经纪人;5:教练;6:宝贝
	 */
	private int role_type;
	/**
	 * 是否是当前身价  0：不是 1：是
	 */
	private int status;
	private Date create_time;
	/**
	 * 交易方式 jp:竞拍 zh：转会	
	 */	
	private String buy_type; 
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public int getRole_type() {
		return role_type;
	}
	public void setRole_type(int role_type) {
		this.role_type = role_type;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getBuy_type() {
		return buy_type;
	}
	public void setBuy_type(String buy_type) {
		this.buy_type = buy_type;
	}
	
	
}
