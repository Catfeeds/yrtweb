package com.yt.framework.persistent.entity;

import java.io.Serializable;
/**
 * 后台管理员报名录入信息
 * 
 * @Title: AdminSign.java
 * @Package com.yt.framework.persistent.entity
 * @author ylt
 * @date 2015年11月3日 下午3:12:46
 */
public class AdminSign implements Serializable {
	
	private static final long serialVersionUID = 7906863761455765995L;
	private String id;
	private String mobile; // 手机号
	private String username; //用户姓名
	private String idcard;
	private String s_id;
	private String createTime;
	private Integer input_type;//填写渠道 : 1:移动端  2:pc端
	private Integer if_pay; //是否交费  1：是 0：否
	private String sign_id;  //报名主题id
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getInput_type() {
		return input_type;
	}
	public void setInput_type(Integer input_type) {
		this.input_type = input_type;
	}
	public Integer getIf_pay() {
		return if_pay;
	}
	public void setIf_pay(Integer if_pay) {
		this.if_pay = if_pay;
	}
	public String getSign_id() {
		return sign_id;
	}
	public void setSign_id(String sign_id) {
		this.sign_id = sign_id;
	}
	
	
	
}
