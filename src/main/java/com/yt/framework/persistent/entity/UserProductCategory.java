package com.yt.framework.persistent.entity;

import java.io.Serializable;

public class UserProductCategory implements Serializable {
	private static final long serialVersionUID = 1L;

	private String category_id;
	private String parent_id; // 父级id
	private String category_name; // 分类名称
	private String category_header; // 分类封面
	private String category_sort; // 分配排序

	public String getCategory_id() {
		return category_id;
	}

	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getCategory_header() {
		return category_header;
	}

	public void setCategory_header(String category_header) {
		this.category_header = category_header;
	}

	public String getCategory_sort() {
		return category_sort;
	}

	public void setCategory_sort(String category_sort) {
		this.category_sort = category_sort;
	}

}
