package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *图片视频Entity
 *@autor bo.xie
 *@date2015-8-14下午2:03:18
 */
public class ImageVideo implements Serializable {

	private static final long serialVersionUID = 227118202870892475L;

	private String id;
	private String user_id;
	private String login_user_id;
	private String title;
	private String describle;
	private String f_size;
	private Integer f_status;
	private String f_src;
	private String v_cover;
	private Integer click_count;
	private Integer praise_count;
	private Integer unpraise_count;
	private String role_type;
	private String not_role_type;
	private Integer if_show;
	private Date create_time;
	private String create_timeS;
	private String type;
	private String ivname;
	private String orderby;
	private String if_send;
	private String add_iv_id;
	private Integer to_oss;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
	}
	public String getF_size() {
		return f_size;
	}
	public void setF_size(String f_size) {
		this.f_size = f_size;
	}
	public Integer getF_status() {
		return f_status;
	}
	public void setF_status(Integer f_status) {
		this.f_status = f_status;
	}
	public String getF_src() {
		return f_src;
	}
	public void setF_src(String f_src) {
		this.f_src = f_src;
	}
	public String getV_cover() {
		return v_cover;
	}
	public void setV_cover(String v_cover) {
		this.v_cover = v_cover;
	}
	public Integer getClick_count() {
		return click_count;
	}
	public void setClick_count(Integer click_count) {
		this.click_count = click_count;
	}
	public Integer getPraise_count() {
		return praise_count;
	}
	public void setPraise_count(Integer praise_count) {
		this.praise_count = praise_count;
	}
	public Integer getUnpraise_count() {
		return unpraise_count;
	}
	public void setUnpraise_count(Integer unpraise_count) {
		this.unpraise_count = unpraise_count;
	}
	public String getRole_type() {
		return role_type;
	}
	public void setRole_type(String role_type) {
		this.role_type = role_type;
	}
	public Integer getIf_show() {
		return if_show;
	}
	public void setIf_show(Integer if_show) {
		this.if_show = if_show;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIvname() {
		return ivname;
	}
	public void setIvname(String ivname) {
		this.ivname = ivname;
	}
	public String getLogin_user_id() {
		return login_user_id;
	}
	public void setLogin_user_id(String login_user_id) {
		this.login_user_id = login_user_id;
	}
	public String getOrderby() {
		return orderby;
	}
	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}
	public String getNot_role_type() {
		return not_role_type;
	}
	public void setNot_role_type(String not_role_type) {
		this.not_role_type = not_role_type;
	}
	public String getIf_send() {
		return if_send;
	}
	public void setIf_send(String if_send) {
		this.if_send = if_send;
	}
	public String getAdd_iv_id() {
		return add_iv_id;
	}
	public void setAdd_iv_id(String add_iv_id) {
		this.add_iv_id = add_iv_id;
	}
	public Integer getTo_oss() {
		return to_oss;
	}
	public void setTo_oss(Integer to_oss) {
		this.to_oss = to_oss;
	}
	public String getCreate_timeS() {
		return create_timeS;
	}
	public void setCreate_timeS(String create_timeS) {
		this.create_timeS = create_timeS;
	}
	
}
