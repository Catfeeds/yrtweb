package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 租借消息
 * @author YLT	
 * @Date 2016年2月29日16:24:30
 */
public class TeamLoanMsg implements Serializable{

	private static final long serialVersionUID = 1755608080795521673L;
	private String id ;
	private String buy_teaminfo_id;//租借俱乐部ID
	private String loan_teaminfo_id;//出租俱乐部ID
	private String user_id;//球员id
	private BigDecimal price;//租借价格
	private int if_ok;//是否成交 0：否 1：是
	private int status;//1：未处理 2：已处理 
	private String remark;//备注
	private Date create_time;//创建日期
	private Date end_time;//租借到期时间
	private Date over_time;//消息失效时间
	private String cfg_id;//转会窗口期id
	private Date closing_time;//操作确认时间
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBuy_teaminfo_id() {
		return buy_teaminfo_id;
	}
	public void setBuy_teaminfo_id(String buy_teaminfo_id) {
		this.buy_teaminfo_id = buy_teaminfo_id;
	}
	public String getLoan_teaminfo_id() {
		return loan_teaminfo_id;
	}
	public void setLoan_teaminfo_id(String loan_teaminfo_id) {
		this.loan_teaminfo_id = loan_teaminfo_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public int getIf_ok() {
		return if_ok;
	}
	public void setIf_ok(int if_ok) {
		this.if_ok = if_ok;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public String getCfg_id() {
		return cfg_id;
	}
	public void setCfg_id(String cfg_id) {
		this.cfg_id = cfg_id;
	}
	public Date getOver_time() {
		return over_time;
	}
	public void setOver_time(Date over_time) {
		this.over_time = over_time;
	}
	public Date getClosing_time() {
		return closing_time;
	}
	public void setClosing_time(Date closing_time) {
		this.closing_time = closing_time;
	}
	
	
}
