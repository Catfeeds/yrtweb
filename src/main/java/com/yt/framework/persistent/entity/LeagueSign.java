package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 联赛报名
 *@autor ylt
 *@date2015-10-14下午6:59:46
 */
public class LeagueSign implements Serializable{
	private static final long serialVersionUID = 3695750888132172291L;
	private String id;
	private String user_id; //报名用户ID
	private String leagues_id; // 联赛ID
	private Date create_time; //创建时间
	private Integer status; //报名状态 1：报名成功 2:审核中 3：报名失败
	private String reason; //失败理由
	private String image_src;//免冠照
	private String mobile;//联系电话
	private Integer sex;//性别
	private Double height;//身高
	private Double weight;//体重
	private String position;//擅长位置
	private String cfoot;//惯用脚
	private Integer invalid;//是否失效 0 失效 1未失效
	private Integer entry_mode;//参赛方式 1单飞 2组队
	private String love_num;//喜欢球衣号码
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birth_date;
	private String idCard; //身份证
	
	private String active_code;//球员报名时使用激活码
	private String s_id;//赛季标志id
	
	public String getLove_num() {
		return love_num;
	}
	public void setLove_num(String love_num) {
		this.love_num = love_num;
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
	public String getLeagues_id() {
		return leagues_id;
	}
	public void setLeagues_id(String leagues_id) {
		this.leagues_id = leagues_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getImage_src() {
		return image_src;
	}
	public void setImage_src(String image_src) {
		this.image_src = image_src;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Double getHeight() {
		return height;
	}
	public void setHeight(Double height) {
		this.height = height;
	}
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getCfoot() {
		return cfoot;
	}
	public void setCfoot(String cfoot) {
		this.cfoot = cfoot;
	}
	public Integer getInvalid() {
		return invalid;
	}
	public void setInvalid(Integer invalid) {
		this.invalid = invalid;
	}
	public Integer getEntry_mode() {
		return entry_mode;
	}
	public void setEntry_mode(Integer entry_mode) {
		this.entry_mode = entry_mode;
	}
	public Date getBirth_date() {
		return birth_date;
	}
	public void setBirth_date(Date birth_date) {
		this.birth_date = birth_date;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getActive_code() {
		return active_code;
	}
	public void setActive_code(String active_code) {
		this.active_code = active_code;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	
}
