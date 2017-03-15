package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 * 
 * @author mocoy
 *
 */
public class ReceiveGifts {
	private String id;
	private String rec_user_id;
	private String pay_user_id;
	private String p_code;
	private String p_name;
	private int charm_value;
	private int price;
	private Date createTime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRec_user_id() {
		return rec_user_id;
	}
	public void setRec_user_id(String rec_user_id) {
		this.rec_user_id = rec_user_id;
	}
	public String getPay_user_id() {
		return pay_user_id;
	}
	public void setPay_user_id(String pay_user_id) {
		this.pay_user_id = pay_user_id;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getCharm_value() {
		return charm_value;
	}
	public void setCharm_value(int charm_value) {
		this.charm_value = charm_value;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	

}
