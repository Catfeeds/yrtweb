package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 联赛报名费用记录表
 * @author bo.xie
 *
 */
public class LeagueCost implements Serializable {
	private static final long serialVersionUID = 2891007721691621136L;
	private String id;
	/**
	 * 联赛ID
	 */
	private String league_id;
	/**
	 * 用户ID
	 */
	private String user_id;
	/**
	 * 报名费用
	 */
	private BigDecimal amount;
	/**
	 * 报名缴费时间 
	 */
	private Date create_time;
	/**
	 * 报名费用状态 1：成功 2：失败
	 */
	private int status;

	/**
	 * 订单号
	 */
	private String order_no;
	
	/**
	 * 报名方式 1：pc端 2：移动端 3:线下
	 */
	private int sign_way;
	
	public int getSign_way() {
		return sign_way;
	}

	public void setSign_way(int sign_way) {
		this.sign_way = sign_way;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLeague_id() {
		return league_id;
	}

	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
}
