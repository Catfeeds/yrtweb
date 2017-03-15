package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *消费Entity
 *@autor bo.xie
 *@date2015-8-10下午4:04:27
 */
public class PayCost implements Serializable{

	private static final long serialVersionUID = -1195502217904350587L;

	private String id;
	private String user_id;
	private String teaminfo_id;//俱乐部ID
	private BigDecimal amount;//消费金额
	private String describle;//消费描述
	private String num_str;//消费订单号
	private String order_id;//订单ID
	private Date create_time;//消费时间
	private int status;//消费状态
	private String p_code;//商品代码
	
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
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
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getNum_str() {
		return num_str;
	}
	public void setNum_str(String num_str) {
		this.num_str = num_str;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	
}
