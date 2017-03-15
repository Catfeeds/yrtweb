package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 联赛
 *@autor ylt
 *@date2015-10-14下午6:59:46
 */
public class League implements Serializable{	

	private static final long serialVersionUID = 1215700038264754893L;
	private String id;
	private String name; //联赛名称
	private String simple_name; //联赛简称
	private Integer ball_format;  //球赛赛制 5：5人制,7：7人制,11:11人制
	private String city; // 举办所在地城市
	private String image_src;//海报图片
	private String banner_src;//banner图片
	private String backgroud_src;//背景图片
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date bg_time;//开始时间
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date end_time;//结束时间
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date s_starttime;//验证码使用开始时间
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date s_endtime;//验证码使用结束时间
	private Integer status; //联赛状态 0：未开始 1：进行中  2：已结束 
	private String describle;//描述信息
	private String s_id;//赛季分类
	private int if_show;//是否显示 0：否 1:是
	private BigDecimal salary;//联赛标准工资
	private int sort; //排序
	private int rounds; //联赛轮数
	
	public BigDecimal getSalary() {
		return salary;
	}
	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}
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
	public Integer getBall_format() {
		return ball_format;
	}
	public void setBall_format(Integer ball_format) {
		this.ball_format = ball_format;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getImage_src() {
		return image_src;
	}
	public void setImage_src(String image_src) {
		this.image_src = image_src;
	}
	public Date getBg_time() {
		return bg_time;
	}
	public void setBg_time(Date bg_time) {
		this.bg_time = bg_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
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
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getSimple_name() {
		return simple_name;
	}
	public void setSimple_name(String simple_name) {
		this.simple_name = simple_name;
	}
	public int getIf_show() {
		return if_show;
	}
	public void setIf_show(int if_show) {
		this.if_show = if_show;
	}
	public String getBanner_src() {
		return banner_src;
	}
	public void setBanner_src(String banner_src) {
		this.banner_src = banner_src;
	}
	public String getBackgroud_src() {
		return backgroud_src;
	}
	public void setBackgroud_src(String backgroud_src) {
		this.backgroud_src = backgroud_src;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getRounds() {
		return rounds;
	}
	public void setRounds(int rounds) {
		this.rounds = rounds;
	}
	
	
}
