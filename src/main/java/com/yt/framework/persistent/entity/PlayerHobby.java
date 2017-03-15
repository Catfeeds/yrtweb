package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * 球员爱好
 * 
 * @Title: PlayerHobby.java
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月3日 下午3:04:06
 */
public class PlayerHobby implements Serializable {

	/**
	* 
	*/
	private static final long serialVersionUID = -2848582320966757954L;
	private String id;
	private String user_id;// '球员主要信息表ID',
	private String time_period;// '喜欢参赛时间（周末，非周末）',
	private String time_point;// '喜欢参赛时间（早、中、晚）',
	private String drink;// '喜欢的运动饮料',
	private String brands;// '喜欢品牌',
	private String stars;// '喜欢球星',
	private String teams;// '喜欢球队',
	private String shoes_brand; //喜欢的球鞋品牌

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

	public String getTime_period() {
		return time_period;
	}

	public void setTime_period(String time_period) {
		this.time_period = time_period;
	}

	public String getTime_point() {
		return time_point;
	}

	public void setTime_point(String time_point) {
		this.time_point = time_point;
	}

	public String getDrink() {
		return drink;
	}

	public void setDrink(String drink) {
		this.drink = drink;
	}

	public String getBrands() {
		return brands;
	}

	public void setBrands(String brands) {
		this.brands = brands;
	}

	public String getStars() {
		return stars;
	}

	public void setStars(String stars) {
		this.stars = stars;
	}

	public String getTeams() {
		return teams;
	}

	public void setTeams(String teams) {
		this.teams = teams;
	}

	public String getShoes_brand() {
		return shoes_brand;
	}

	public void setShoes_brand(String shoes_brand) {
		this.shoes_brand = shoes_brand;
	}

}
