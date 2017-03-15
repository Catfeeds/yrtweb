package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 论坛投票
 * @author ylt
 *
 */
public class BbsNote implements Serializable {
	private static final long serialVersionUID = 1058722396388258311L;
	
	private String id;
	private String plate_id; //板块ID
	private String user_id;//用户ID
	private String title;//标题
	private String content;//内容
	private String pre_content;
	private int if_top;//是否置顶
	private int if_show;//是否显示
	private int if_del;//是否删除 1：删除 2：未删除
	private int unpriase_count;//点踩
	private int priase_count;//点赞
	private String type;//帖子类型（投票:2、普通帖:1）
	private Date last_reply_time;//最后一次回复时间
	private String last_reply_user_id;//最后回帖者昵称
	private Date update_time; //最近一次修改时间
	private int if_pick;//是否精华帖 1：是 2：否
	private int if_reply;//是否回复可见权限 1：是  2：否
	private int if_lock;//是否锁定 : 1：锁定 2:不锁 
	private int write_content;//浏览量
	private int if_image;//是否有图片 1：是 2：否
	private int if_video;//是否有视频 1：是 2：否
	private Date create_time;

	public int getIf_del() {
		return if_del;
	}
	public void setIf_del(int if_del) {
		this.if_del = if_del;
	}
	public String getLast_reply_user_id() {
		return last_reply_user_id;
	}
	public void setLast_reply_user_id(String last_reply_user_id) {
		this.last_reply_user_id = last_reply_user_id;
	}
	public String getPre_content() {
		return pre_content;
	}
	public void setPre_content(String pre_content) {
		this.pre_content = pre_content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPlate_id() {
		return plate_id;
	}
	public void setPlate_id(String plate_id) {
		this.plate_id = plate_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getIf_top() {
		return if_top;
	}
	public void setIf_top(int if_top) {
		this.if_top = if_top;
	}
	public int getIf_show() {
		return if_show;
	}
	public void setIf_show(int if_show) {
		this.if_show = if_show;
	}
	public int getUnpriase_count() {
		return unpriase_count;
	}
	public void setUnpriase_count(int unpriase_count) {
		this.unpriase_count = unpriase_count;
	}
	public int getPriase_count() {
		return priase_count;
	}
	public void setPriase_count(int priase_count) {
		this.priase_count = priase_count;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getLast_reply_time() {
		return last_reply_time;
	}
	public void setLast_reply_time(Date last_reply_time) {
		this.last_reply_time = last_reply_time;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public int getIf_pick() {
		return if_pick;
	}
	public void setIf_pick(int if_pick) {
		this.if_pick = if_pick;
	}
	public int getIf_reply() {
		return if_reply;
	}
	public void setIf_reply(int if_reply) {
		this.if_reply = if_reply;
	}
	public int getIf_lock() {
		return if_lock;
	}
	public void setIf_lock(int if_lock) {
		this.if_lock = if_lock;
	}
	public int getWrite_content() {
		return write_content;
	}
	public void setWrite_content(int write_content) {
		this.write_content = write_content;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public int getIf_image() {
		return if_image;
	}
	public void setIf_image(int if_image) {
		this.if_image = if_image;
	}
	public int getIf_video() {
		return if_video;
	}
	public void setIf_video(int if_video) {
		this.if_video = if_video;
	}
	
	
}
