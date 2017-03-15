package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *俱乐部成员
 *@autor bo.xie
 *@date2015-8-4下午5:06:46
 */
public class TeamPlayer implements Serializable{

	private static final long serialVersionUID = 6172014759753250993L;
	
	private String id;
	private String teaminfo_id;//球队ID
	private String user_id;//球员用户ID
	private int type;//球员类型 1:队长 2:副队长 3：普通球员
	private Date create_time;
	private String player_num; //球衣号码
	private String position; //场上位置 
	private String position_num; //场上位置 
	private int is_sale;//球员是否挂牌出售 0：未挂牌 1：已挂牌
	private BigDecimal salary;//当前薪资
	
	
	public String getPosition_num() {
		return position_num;
	}
	public void setPosition_num(String position_num) {
		this.position_num = position_num;
	}
	public int getIs_sale() {
		return is_sale;
	}
	public void setIs_sale(int is_sale) {
		this.is_sale = is_sale;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	public String getPlayer_num() {
		return player_num;
	}
	public void setPlayer_num(String player_num) {
		this.player_num = player_num;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public BigDecimal getSalary() {
		return salary;
	}
	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}
	
}
