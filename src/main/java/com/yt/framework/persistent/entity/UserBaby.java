package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 *@autor  ylt
 *@date2015-10-12下午2:16:03
 */
public class UserBaby implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3880319634688158876L;
	/**
	 * 用户ID
	 */
	private String user_id;
	/**
	 * 用户昵称
	 */
	private String usernick;
	/**
	 * 头像
	 */
	private String head_icon;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUsernick() {
		return usernick;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public String getHead_icon() {
		return head_icon;
	}
	public void setHead_icon(String head_icon) {
		this.head_icon = head_icon;
	}
	
	
	
}
