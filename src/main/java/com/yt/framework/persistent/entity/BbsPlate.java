package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;
/**
 * 
 * <p>
 * 论坛版块表
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月7日 上午11:25:44
 * @version
 */
public class BbsPlate implements Serializable{

	private static final long serialVersionUID = -5208686942502843722L;
	private String id;
	private String name;
	private String type;//版面分类
	private String image_url;//版块封面
	private String rar_max;//附件上限大小
	private String remark;//板块备注
	private Integer sort;//板块排序
	private Integer if_show;//是否展示（0：不展示 1：展示）
	private Date create_time;//创建时间
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public String getRar_max() {
		return rar_max;
	}
	public void setRar_max(String rar_max) {
		this.rar_max = rar_max;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
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

}
