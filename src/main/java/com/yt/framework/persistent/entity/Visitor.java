package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 访客实体类
 *@autor ylt
 *@date2015-8-31下午6:59:46
 */
public class Visitor implements Serializable{

	private static final long serialVersionUID = 522680947836244583L;
	private String id;
	private String visitor_id; //访问者id
	private Date visit_time; // 访问时间
	private String visit_type; // 访问类型 0:个人 1:俱乐部
	private String visit_url ; //访问模块
	private String p_visitor_id; //被访问者id
	private Integer visit_count; //总访问量
	private Integer t_visit_count; //今日访问量
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getVisitor_id() {
		return visitor_id;
	}
	public void setVisitor_id(String visitor_id) {
		this.visitor_id = visitor_id;
	}
	public Date getVisit_time() {
		return visit_time;
	}
	public void setVisit_time(Date visit_time) {
		this.visit_time = visit_time;
	}
	public String getVisit_type() {
		return visit_type;
	}
	public void setVisit_type(String visit_type) {
		this.visit_type = visit_type;
	}
	public String getP_visitor_id() {
		return p_visitor_id;
	}
	public void setP_visitor_id(String p_visitor_id) {
		this.p_visitor_id = p_visitor_id;
	}
	public String getVisit_url() {
		return visit_url;
	}
	public void setVisit_url(String visit_url) {
		this.visit_url = visit_url;
	}
	public Integer getVisit_count() {
		return visit_count;
	}
	public void setVisit_count(Integer visit_count) {
		this.visit_count = visit_count;
	}
	public Integer getT_visit_count() {
		return t_visit_count;
	}
	public void setT_visit_count(Integer t_visit_count) {
		this.t_visit_count = t_visit_count;
	}
	
	
}
