package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 用户资金
 * @author bo.xie
 * @date 2015年10月13日11:44:06
 */
public class UserAmount implements Serializable{

	private static final long serialVersionUID = -1221209357297984038L;
	private String id;
	private String user_id;
	private String teaminfo_id;//俱乐部ID
	private int type;//账户类型 1：个人账户 2：俱乐部账户
	/**
	 * 总宇拓币金额
	 */
	private BigDecimal amount;
	/**
	 * 可用宇拓币金额
	 */
	private BigDecimal real_amount;
	/**
	 * 赠送宇拓币金额
	 */
	private BigDecimal send_amount;
	private int status;
	private int show;//是否显示 0：否 1：是
	
	
	
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
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
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public BigDecimal getReal_amount() {
		return real_amount;
	}
	public void setReal_amount(BigDecimal real_amount) {
		this.real_amount = real_amount;
	}
	public BigDecimal getSend_amount() {
		return send_amount;
	}
	public void setSend_amount(BigDecimal send_amount) {
		this.send_amount = send_amount;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getShow() {
		return show;
	}
	public void setShow(int show) {
		this.show = show;
	}
	
	
}
