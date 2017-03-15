package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 联赛图片视频上传
 * @author gl
 *
 */
public class ImageVideoLeague implements Serializable {
	private static final long serialVersionUID = -6787779070486085347L;
	private String id;
	private String league_id;//联赛ID
	private String group_id;//分组ID
	private String v_cover;//封面地址
	private Integer if_show;//是否在首页展示 1：展示 2：不展示
	private Integer click_count;//点击量
	private String src;//上传路径
	private String title;//title描述
	private Integer status;//是否可用 0：不可用 1:可用 
	private Integer praise_count;//赞数
	private Integer unpraise_count;//踩
	private Date create_time;
	private Integer type;//类型 1：图片 2：视频
	private Integer no;//排列顺序
	private String f_size;//文件长度
	private String describle;// 描述
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
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
	public Integer getClick_count() {
		return click_count;
	}
	public void setClick_count(Integer click_count) {
		this.click_count = click_count;
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
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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
	
}
