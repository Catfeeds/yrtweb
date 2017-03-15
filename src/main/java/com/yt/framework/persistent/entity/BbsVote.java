package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 论坛投票
 * @author ylt
 *
 */
public class BbsVote implements Serializable {
	private static final long serialVersionUID = 1033525915040581981L;
	private String id;
	private String note_id;//帖子id
	private String user_id;
	private int type;//选择类型 1:单选 2:复选
	private Date create_time;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date end_time; //投票结束时间
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNote_id() {
		return note_id;
	}
	public void setNote_id(String note_id) {
		this.note_id = note_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
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
	
	
}
