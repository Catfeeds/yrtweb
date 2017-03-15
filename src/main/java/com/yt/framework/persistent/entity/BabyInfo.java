package com.yt.framework.persistent.entity;
/**
 *足球宝贝基本信息
 *@autor bo.xie
 *@date2015-9-24下午5:54:05
 */
public class BabyInfo {

	private String id;
	
	private String user_id;
	/**
	 * 星座
	 */
	private String constellation;
	/**
	 * 身高
	 */
	private Integer height;
	
	/**
	 * 体重
	 */
	private Double weight;
	
	/**
	 * 胸围
	 */
	private Double chest;
	
	/**
	 * 图片地址
	 */
	private String images_url;
	
	/**
	 * 爱好
	 */
	private String hobby;
	
	/**
	 * 成就
	 */
	private String achievement;
	/**
	 * 自我介绍
	 */
	private String intro;
	/**
	 * 喜爱俱乐部
	 */
	private String love_team;
	
	/**
	 * 臀围
	 */
	private Double hip;
	
	/**
	 * 腰围
	 */
	private Double waist;
	
	/**
	 * 宝贝评分 
	 */
	private Double score;
	/**
	 * 是否推荐到首页
	 */
	private int is_index;
	/**
	 * 排序
	 */
	private int show_num;
	
	/**
	 * 是否屏蔽
	 * @return
	 */
	private int if_del;

	public int getIs_index() {
		return is_index;
	}

	public void setIs_index(int is_index) {
		this.is_index = is_index;
	}

	public int getShow_num() {
		return show_num;
	}

	public void setShow_num(int show_num) {
		this.show_num = show_num;
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

	public String getConstellation() {
		return constellation;
	}

	public void setConstellation(String constellation) {
		this.constellation = constellation;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public Double getChest() {
		return chest;
	}

	public void setChest(Double chest) {
		this.chest = chest;
	}

	public String getImages_url() {
		return images_url;
	}

	public void setImages_url(String images_url) {
		this.images_url = images_url;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getAchievement() {
		return achievement;
	}

	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getLove_team() {
		return love_team;
	}

	public void setLove_team(String love_team) {
		this.love_team = love_team;
	}

	public Double getHip() {
		return hip;
	}

	public void setHip(Double hip) {
		this.hip = hip;
	}

	public Double getWaist() {
		return waist;
	}

	public void setWaist(Double waist) {
		this.waist = waist;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public int getIf_del() {
		return if_del;
	}

	public void setIf_del(int if_del) {
		this.if_del = if_del;
	}
	
	
}
