package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 论坛投票详情
 * @author ylt
 *
 */
public class BbsVoteClick implements Serializable {
	private static final long serialVersionUID = 8357362034522383690L;
	private String id;
	private String votedata_id; //投票选项id
	private String user_id; //投票人
	private Date create_time;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getVotedata_id() {
		return votedata_id;
	}
	public void setVotedata_id(String votedata_id) {
		this.votedata_id = votedata_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	
	
}
