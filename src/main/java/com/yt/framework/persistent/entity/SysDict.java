package com.yt.framework.persistent.entity;

import java.io.Serializable;

public class SysDict implements Serializable{
	private Long id;
	/**
	 * 字段
	 */
	private String dict_column;
	/**
	 * 字段描述
	 */
	private String dict_desc;
	/**
	 * 字段值描述
	 */
	private String dict_value;
	/**
	 * 字段值描述
	 */
	private String dict_value_desc;
	/**
	 * 是否有效0:有效 1:无效
	 */
	private Integer dict_flag;
	/**
	 * 排序
	 */
	private Integer dict_sort;
	/**
	 * 父节点id 
	 */
	private Integer parent_id;
	/**
	 * 是否叶子节点  1：是 0 否
	 */
	private Integer if_leaf;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getDict_column() {
		return dict_column;
	}
	public void setDict_column(String dict_column) {
		this.dict_column = dict_column;
	}
	public String getDict_desc() {
		return dict_desc;
	}
	public void setDict_desc(String dict_desc) {
		this.dict_desc = dict_desc;
	}
	public String getDict_value() {
		return dict_value;
	}
	public void setDict_value(String dict_value) {
		this.dict_value = dict_value;
	}
	public String getDict_value_desc() {
		return dict_value_desc;
	}
	public void setDict_value_desc(String dict_value_desc) {
		this.dict_value_desc = dict_value_desc;
	}
	public Integer getDict_flag() {
		return dict_flag;
	}
	public void setDict_flag(Integer dict_flag) {
		this.dict_flag = dict_flag;
	}
	public Integer getDict_sort() {
		return dict_sort;
	}
	public void setDict_sort(Integer dict_sort) {
		this.dict_sort = dict_sort;
	}
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public Integer getIf_leaf() {
		return if_leaf;
	}
	public void setIf_leaf(Integer if_leaf) {
		this.if_leaf = if_leaf;
	}
	
	
}
