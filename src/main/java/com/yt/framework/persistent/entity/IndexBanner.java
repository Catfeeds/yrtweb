package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

public class IndexBanner implements Serializable {
	private static final long serialVersionUID = 1L;

	private String id;
	private String title;// 标题
	private String img_src;// 图片地址
	private String img_path;// 图片链接
	private Integer if_blank;// 是否在新窗口显示1是0否
	private Integer if_use;// 是否使用1是0否
	private Integer sort;// 排序 倒序
	private Date create_time;

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

	public String getImg_src() {
		return img_src;
	}

	public void setImg_src(String img_src) {
		this.img_src = img_src;
	}

	public String getImg_path() {
		return img_path;
	}

	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	public Integer getIf_blank() {
		return if_blank;
	}

	public void setIf_blank(Integer if_blank) {
		this.if_blank = if_blank;
	}

	public Integer getIf_use() {
		return if_use;
	}

	public void setIf_use(Integer if_use) {
		this.if_use = if_use;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

}
