package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *经纪人实体类
 *@autor bo.xie
 *@date2015-8-3下午6:59:46
 */
public class AgentInfo implements Serializable{

	private static final long serialVersionUID = 7988090667504066272L;

	private String id;
	private String user_id;
	/**
	 * 认证号（中国足协或国际足联颁发）
	 */
	private String cer_no;
	/**
	 * 代理过的球员
	 */
	private String agent_plays;
	/**
	 * 熟悉的俱乐部(球队)
	 */
	private String know_clubs;
	/**
	 * 创建时间
	 */
	private Date create_time;
	/**
	 * 案例
	 */
	private String cases;
	/**
	 * 寻找球员区域
	 */
	private String find_area;
	/**
	 * 是否有球员经历0：没有 1：有
	 */
	private int is_player;
	/**
	 * 头衔
	 */
	private String title;
	/**
	 * 学历
	 */
	private String education;
	/**
	 * 所属公司
	 */
	private String company;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCer_no() {
		return cer_no;
	}
	public void setCer_no(String cer_no) {
		this.cer_no = cer_no;
	}
	public String getAgent_plays() {
		return agent_plays;
	}
	public void setAgent_plays(String agent_plays) {
		this.agent_plays = agent_plays;
	}
	public String getKnow_clubs() {
		return know_clubs;
	}
	public void setKnow_clubs(String know_clubs) {
		this.know_clubs = know_clubs;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getCases() {
		return cases;
	}
	public void setCases(String cases) {
		this.cases = cases;
	}
	public String getFind_area() {
		return find_area;
	}
	public void setFind_area(String find_area) {
		this.find_area = find_area;
	}
	public int getIs_player() {
		return is_player;
	}
	public void setIs_player(int is_player) {
		this.is_player = is_player;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	
}
