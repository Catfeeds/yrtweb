package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *信息发送记录
 *@autor bo.xie
 *@date2015-8-18下午1:54:23
 */
public class MessageRecords implements Serializable {

	private static final long serialVersionUID = -4377566615164432730L;
	private String id;
	/**
	 * 触发推送用户表ID
	 */
	private String user_id;
	/**
	 * 接收推送信息的用户ID
	 */
	private String user_ids;
	/**
	 * SystemEnum 枚举类型
	 */
	private String type;
	/**
	 * 消息文本
	 */
	private String content;
	private Date create_time;
	
	/**
	 * 推送状态0：未推送，1：已推送 
	 */
	private int status;
	/**
	 * 是否需要显示到广场上0：不需要 1：需要
	 */
	private int is_show;
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
	public String getUser_ids() {
		return user_ids;
	}
	public void setUser_ids(String user_ids) {
		this.user_ids = user_ids;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public int getIs_show() {
		return is_show;
	}
	public void setIs_show(int is_show) {
		this.is_show = is_show;
	}
	
}
