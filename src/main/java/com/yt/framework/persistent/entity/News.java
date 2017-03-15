package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 联赛新闻
 * @author gl
 *
 */
public class News implements Serializable {

	private static final long serialVersionUID = 2112455292864074490L;
	private String id;
	private String title;//新闻标题
	private String content;//新闻内容
	private String cover_img;//封面
	private Integer is_special;//是否突出 0：否 1：是
	private Integer show_num;//排序
	private Integer type; //类型 1：新闻 2：公告
	private Integer hava_iv;//内容是否有图片或视频 0：没有 1：有
	private Date create_time;
	private String model_id;//关联模块id（联赛ID）
	private Integer n_state;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getCover_img() {
		return cover_img;
	}
	public void setCover_img(String cover_img) {
		this.cover_img = cover_img;
	}
	public Integer getIs_special() {
		return is_special;
	}
	public void setIs_special(Integer is_special) {
		this.is_special = is_special;
	}
	public Integer getShow_num() {
		return show_num;
	}
	public void setShow_num(Integer show_num) {
		this.show_num = show_num;
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
	public Integer getHava_iv() {
		return hava_iv;
	}
	public void setHava_iv(Integer hava_iv) {
		this.hava_iv = hava_iv;
	}
	public String getModel_id() {
		return model_id;
	}
	public void setModel_id(String model_id) {
		this.model_id = model_id;
	}
	public Integer getN_state() {
		return n_state;
	}
	public void setN_state(Integer n_state) {
		this.n_state = n_state;
	}
}
