package com.yt.framework.persistent.entity;

public class PPosition {

	private String id;//俱乐部成员记录表ID
	private String position;//球场位置
	private String position_num;//球场位置标示
	private int isCheck;//是否勾选
	private String user_id;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(int isCheck) {
		this.isCheck = isCheck;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPosition_num() {
		return position_num;
	}
	public void setPosition_num(String position_num) {
		this.position_num = position_num;
	}
}
