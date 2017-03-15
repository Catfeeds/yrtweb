package com.yt.framework.persistent.entity;

import java.io.Serializable;

public class UserAddress implements Serializable{
	
	private static final long serialVersionUID = 6399749058762909930L;
	private String address_id;
	private String user_id; //
	private String user_name;  // 收货人名称
	private String user_address;  // 收货全地址
	private String user_phone;  //收货人电话
	private String user_default; //是否默认地址
	private String user_province; //省
	private String user_city; //市
	private String user_area; //县或者区域
	private String user_postcode; //邮政编码
	
	public String getAddress_id() {
		return address_id;
	}
	public void setAddress_id(String address_id) {
		this.address_id = address_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_default() {
		return user_default;
	}
	public void setUser_default(String user_default) {
		this.user_default = user_default;
	}
	public String getUser_province() {
		return user_province;
	}
	public void setUser_province(String user_province) {
		this.user_province = user_province;
	}
	public String getUser_city() {
		return user_city;
	}
	public void setUser_city(String user_city) {
		this.user_city = user_city;
	}
	public String getUser_area() {
		return user_area;
	}
	public void setUser_area(String user_area) {
		this.user_area = user_area;
	}
	public String getUser_postcode() {
		return user_postcode;
	}
	public void setUser_postcode(String user_postcode) {
		this.user_postcode = user_postcode;
	}
	
	
}
