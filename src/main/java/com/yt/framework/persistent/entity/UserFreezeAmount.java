package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 用户资金
 * @author bo.xie
 * @date 2015年10月13日11:44:06
 */
public class UserFreezeAmount implements Serializable{

	private static final long serialVersionUID = 5843992554678242636L;
	private String id;
	private String user_id;
	private String teaminfo_id;//俱乐部ID
	/**
	 * 资金账户ID
	 */
	private String u_amount_id;
	/**
	 * 冻结宇拓币金额
	 */
	private BigDecimal amount;
	/**
	 * 创建时间
	 */
	private Date create_time; 
	private int status; //冻结状态：1：冻结 2：解冻中 3：已解冻
	private String describle;//备注
	
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
	public String getU_amount_id() {
		return u_amount_id;
	}
	public void setU_amount_id(String u_amount_id) {
		this.u_amount_id = u_amount_id;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
	}
	
	
}
