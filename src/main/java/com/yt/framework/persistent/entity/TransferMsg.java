package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 转会纪录消息
 * @author YLT	
 * @Date 2016年2月29日16:24:30
 */
public class TransferMsg implements Serializable{

	private static final long serialVersionUID = 391987214055063218L;
	private String id ;
	private String buy_teaminfo_id;//购买俱乐部ID
	private String sell_teaminfo_id;//出售俱乐部ID
	private String user_id;//球员id
	private BigDecimal price;//身价
	private int if_ok;//是否成交 0：否 1：是
	private int status;//0：待处理 1：同意 2：拒绝 
	private String remark;//备注
	private Date deal_time;//交易日期
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
	public String getSell_teaminfo_id() {
		return sell_teaminfo_id;
	}
	public void setSell_teaminfo_id(String sell_teaminfo_id) {
		this.sell_teaminfo_id = sell_teaminfo_id;
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
	public Date getDeal_time() {
		return deal_time;
	}
	public void setDeal_time(Date deal_time) {
		this.deal_time = deal_time;
	}
	
	
	
}
