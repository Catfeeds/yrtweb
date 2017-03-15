package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 联赛类别区分对象
 *@autor ylt
 *@date2016-3-2下午6:59:46;
 */
public class LeagueCfg implements Serializable{

	private static final long serialVersionUID = 5332406367130066079L;
	private String id;
	private String area_code; //区域ID
	private String year;//年份
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date s_starttime;//报名开始时间
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date s_endtime;//报名结束时间
	private Integer status; //赛季状态 0：未开始 1：进行中  2：已结束
	private String season;//赛季标志
	private String image_src;//赛季分类图标
	private int sort;//排序
	private int if_show;//是否显示
	private int if_balance;//是否结算
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getArea_code() {
		return area_code;
	}
	public void setArea_code(String area_code) {
		this.area_code = area_code;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public Date getS_starttime() {
		return s_starttime;
	}
	public void setS_starttime(Date s_starttime) {
		this.s_starttime = s_starttime;
	}
	public Date getS_endtime() {
		return s_endtime;
	}
	public void setS_endtime(Date s_endtime) {
		this.s_endtime = s_endtime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public String getImage_src() {
		return image_src;
	}
	public void setImage_src(String image_src) {
		this.image_src = image_src;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getIf_show() {
		return if_show;
	}
	public void setIf_show(int if_show) {
		this.if_show = if_show;
	}
	public int getIf_balance() {
		return if_balance;
	}
	public void setIf_balance(int if_balance) {
		this.if_balance = if_balance;
	}
	
}
