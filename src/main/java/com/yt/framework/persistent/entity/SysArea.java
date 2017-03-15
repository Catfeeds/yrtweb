package com.yt.framework.persistent.entity;

import java.io.Serializable;

public class SysArea implements Serializable{
	
	private static final long serialVersionUID = 4190462689845631658L;
	
	private Long id;
	
	private String area_name; //区域名称
	
	private int leaf; //叶子节点 0:否 1：是
	
	private String area_code; //区域代码
	
	private String parent_code; //父节点code
	
	private String first_letter;//首字母
	
	private int area_level;//区域级别
	
	private int area_sort;//排序

	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getArea_name() {
		return area_name;
	}

	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}


	public String getArea_code() {
		return area_code;
	}

	public void setArea_code(String area_code) {
		this.area_code = area_code;
	}


	public int getLeaf() {
		return leaf;
	}

	public void setLeaf(int leaf) {
		this.leaf = leaf;
	}

	public String getParent_code() {
		return parent_code;
	}

	public void setParent_code(String parent_code) {
		this.parent_code = parent_code;
	}

	public String getFirst_letter() {
		return first_letter;
	}

	public void setFirst_letter(String first_letter) {
		this.first_letter = first_letter;
	}

	public int getArea_level() {
		return area_level;
	}

	public void setArea_level(int area_level) {
		this.area_level = area_level;
	}

	public int getArea_sort() {
		return area_sort;
	}

	public void setArea_sort(int area_sort) {
		this.area_sort = area_sort;
	}

	

	
}
