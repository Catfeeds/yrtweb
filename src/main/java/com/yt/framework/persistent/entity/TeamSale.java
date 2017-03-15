package com.yt.framework.persistent.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 球员出售记录
 * @author bo.xie
 * @date 2015年12月2日16:22:38
 */
public class TeamSale {

	private String id;
	private String teaminfo_id;
	private String user_id;
	private int status;//是否已出售 1：已出售  2：出售中 3：出售失败
	private Date create_time;
	private BigDecimal price;//出售价格
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
}
