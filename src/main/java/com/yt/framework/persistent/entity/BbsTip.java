package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * <p>
 * 论坛举报实体对象
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月7日 下午3:17:48
 * @version
 */
public class BbsTip implements Serializable{

	private static final long serialVersionUID = 7705740696346211557L;
    private String id;
    private String user_id;//举报人
    private String b_user_id;//被举报人id
    private String content;//举报内容
    private String note_id;//帖子id
    private String note_reply_id;//回复id
    private String type;//举报类型（多选逗号隔开）
    private Integer status;//状态 1：处理 2：未处理
    private Date create_time;//举报日期
    private Date deal_time;//处理时间
    
    private String title;//论坛标题
    private Integer floor_num;//回复楼层
    
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
	public String getB_user_id() {
		return b_user_id;
	}
	public void setB_user_id(String b_user_id) {
		this.b_user_id = b_user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getNote_id() {
		return note_id;
	}
	public void setNote_id(String note_id) {
		this.note_id = note_id;
	}
	public String getNote_reply_id() {
		return note_reply_id;
	}
	public void setNote_reply_id(String note_reply_id) {
		this.note_reply_id = note_reply_id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getDeal_time() {
		return deal_time;
	}
	public void setDeal_time(Date deal_time) {
		this.deal_time = deal_time;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getFloor_num() {
		return floor_num;
	}
	public void setFloor_num(Integer floor_num) {
		this.floor_num = floor_num;
	}
	
}
