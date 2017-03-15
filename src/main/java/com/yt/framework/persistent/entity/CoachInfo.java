package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 *教练信息实体类
 *@autor bo.xie
 *@date2015-8-6下午5:15:31
 */
public class CoachInfo implements Serializable {
	
	private static final long serialVersionUID = 4063745291747325711L;
	
	private String id;
	private String user_id;
	private int is_player;//是否有球员经历 0：没有 1：有
	private String cer_no;//证书编号
	private String in_team;//所属俱乐部
	private String stars;//所培养的球星
	private Date create_time;
	
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
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
	public int getIs_player() {
		return is_player;
	}
	public void setIs_player(int is_player) {
		this.is_player = is_player;
	}
	public String getCer_no() {
		return cer_no;
	}
	public void setCer_no(String cer_no) {
		this.cer_no = cer_no;
	}
	public String getIn_team() {
		return in_team;
	}
	public void setIn_team(String in_team) {
		this.in_team = in_team;
	}
	public String getStars() {
		return stars;
	}
	public void setStars(String stars) {
		this.stars = stars;
	}
	
	

}
