package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * @Title: Resources.java 
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年7月23日 下午3:53:50 
 */
public class Resources implements Serializable{
	private static final long serialVersionUID = 5486141367740730380L;

	private String res_id;

	private String res_name;

	private String res_url;

	private Integer res_parentid;

	private Integer res_sort;

	private String res_code;

	public String getRes_id() {
		return res_id;
	}

	public void setRes_id(String res_id) {
		this.res_id = res_id;
	}

	public String getRes_name() {
		return res_name;
	}

	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}

	public String getRes_url() {
		return res_url;
	}

	public void setRes_url(String res_url) {
		this.res_url = res_url;
	}

	public Integer getRes_parentid() {
		return res_parentid;
	}

	public void setRes_parentid(Integer res_parentid) {
		this.res_parentid = res_parentid;
	}

	public Integer getRes_sort() {
		return res_sort;
	}

	public void setRes_sort(Integer res_sort) {
		this.res_sort = res_sort;
	}

	public String getRes_code() {
		return res_code;
	}

	public void setRes_code(String res_code) {
		this.res_code = res_code;
	}

	@Override
	public String toString() {
		return "Resources [resId=" + res_id + ", resName=" + res_name + ", resUrl=" + res_url + ", resParentid="
				+ res_parentid + ", resSort=" + res_sort + ", resCode=" + res_code + "]";
	}
}