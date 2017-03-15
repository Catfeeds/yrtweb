package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;
/**
 * 
 * <p>
 * 论坛帖子回复
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月7日 上午11:55:20
 * @version
 */
public class BbsNoteReply implements Serializable{

	private static final long serialVersionUID = 5878892820619828670L;

	private String Id;
	private String note_id;//帖子id
	private String content;//回复内容
	private String user_id;//回帖用户
	private int floor_num;//楼层数
	private Date update_time;//最近一次修改时间
	private Integer unpriase_count;//点踩量
	private Integer priase_count;//点赞量
	private String reply_time;//回复时间
	private Integer if_del;//是否删除
	private String p_user_id;//指定回复用户
	
	public int getFloor_num() {
		return floor_num;
	}
	public void setFloor_num(int floor_num) {
		this.floor_num = floor_num;
	}
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
	}
	public String getNote_id() {
		return note_id;
	}
	public void setNote_id(String note_id) {
		this.note_id = note_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public Integer getUnpriase_count() {
		return unpriase_count;
	}
	public void setUnpriase_count(Integer unpriase_count) {
		this.unpriase_count = unpriase_count;
	}
	public Integer getPriase_count() {
		return priase_count;
	}
	public void setPriase_count(Integer priase_count) {
		this.priase_count = priase_count;
	}
	public String getReply_time() {
		return reply_time;
	}
	public void setReply_time(String reply_time) {
		this.reply_time = reply_time;
	}
	
	public Integer getIf_del() {
		return if_del;
	}
	public void setIf_del(Integer if_del) {
		this.if_del = if_del;
	}
	public String getP_user_id() {
		return p_user_id;
	}
	public void setP_user_id(String p_user_id) {
		this.p_user_id = p_user_id;
	}
	
}
