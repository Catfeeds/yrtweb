package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *俱乐部图片视频Entity
 *@autor gl
 *@date2015-8-14下午2:03:18
 */
public class ImageVideoTeam implements Serializable {

	private static final long serialVersionUID = 227118202870892475L;

	private String id;
	/**
	 * 分组ID
	 */
	private String group_id;
	/**
	 * 角色类型 1：球迷；2:球员；3:俱乐部；4：经纪人；5教练人
	 */
	private Integer role_type;
	/**
	 * 上传路径
	 */
	private String src; 
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 点赞数
	 */
	private Integer praise_count;
	private Integer unpraise_count;
	/**
	 * 创建时间
	 */
	private Date create_time;
	/**
	 * 类型 1：图片 2：视频
	 */
	private Integer type;
	/**
	 * 排列顺序
	 */
	private Integer no;
	/**
	 * 文件长度
	 */
	private String f_size;
	/**
	 * 视频描述
	 */
	private String describle;
	/**
	 * 上传用户id
	 */
	private String team_id;
	
	/**
	 * 图片状态 
	 */
	private Integer status;
	
	/**
	 * 视频封面地址
	 */
	private String v_cover;
	
	/**
	 * 是否在首页展示 1:展示 2:不展示(默认) add by ylt 
	 * @return
	 */
	private Integer if_show;
	
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

	public Integer getRole_type() {
		return role_type;
	}

	public void setRole_type(Integer role_type) {
		this.role_type = role_type;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getPraise_count() {
		return praise_count;
	}

	public void setPraise_count(Integer praise_count) {
		this.praise_count = praise_count;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getF_size() {
		return f_size;
	}

	public void setF_size(String f_size) {
		this.f_size = f_size;
	}

	public String getDescrible() {
		return describle;
	}

	public void setDescrible(String describle) {
		this.describle = describle;
	}


	public String getTeam_id() {
		return team_id;
	}

	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getV_cover() {
		return v_cover;
	}

	public void setV_cover(String v_cover) {
		this.v_cover = v_cover;
	}

	public Integer getIf_show() {
		return if_show;
	}

	public void setIf_show(Integer if_show) {
		this.if_show = if_show;
	}

	public Integer getUnpraise_count() {
		return unpraise_count;
	}

	public void setUnpraise_count(Integer unpraise_count) {
		this.unpraise_count = unpraise_count;
	}
	
}
