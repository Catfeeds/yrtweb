package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 *@autor bo.xie
 *@date2015-7-21下午2:16:03
 */
public class User implements Serializable {

	private static final long serialVersionUID = 5397358798971180882L;
	/**
	 * session中id key值
	 */
	public static final String LOGIN_USER_ID_SESSION_NAME = "id";
	
	/**
	 * session中user对象 key值
	 */
	public static final String LOGIN_USER_SESSION_NAME = "user";

	private String user_type="user";
	/**
	 * 用户ID
	 */
	private String id;
	/**
	 * 用户昵称
	 */
	private String usernick;
	/**
	 * 手机号
	 */
	private String phone;
	/**
	 * 用户姓名
	 */
	private String username;
	
	/**
	 * 身份证
	 */
	private String id_card;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 创建时间
	 */
	private Date create_time;
	/**
	 * 上传视频个数（默认0个）
	 */
	private int video_count;
	/**
	 * 上传图片张数(默认0张)
	 */
	private int image_count;
	/**
	 * 用户性别 0:女 1:男
	 */
	private Integer sex; //update gl 20150828 int>Integer
	/**
	 * 出生年月
	 */
	private Date borndate;
	/**
	 * 个人签名
	 */
	private String signature;
	/**
	 * 区域
	 */
	private String area;
	/**
	 * 城市
	 */
	private String city;
	/**
	 * 所在省份
	 */
	private String province;
	/**
	 * 头像
	 */
	private String head_icon;
	/**
	 * 最近登录时间
	 */
	private Date last_login;
	/**
	 * 最近登录IP
	 */
	private String last_login_ip;
	
	private int receive_sms;//是否接受短信通知 1：接受 2：不接受
	private int usercp;
	
	private int if_protocol;//是否同意协议
	
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(List<String> userRoleList) {
		if(userRoleList.contains("7")){
			this.user_type = "baby";
		}else if(userRoleList.contains("6")){
			this.user_type = "team";
		}else if(userRoleList.contains("5")){
			this.user_type = "coach";
		}else if(userRoleList.contains("3")){
			this.user_type = "player";
		}else if(userRoleList.contains("2")){
			this.user_type = "agent";
		}else{
			this.user_type = "user";
		}
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public int getUsercp() {
		return usercp;
	}
	public void setUsercp(int usercp) {
		this.usercp = usercp;
	}
	public int getReceive_sms() {
		return receive_sms;
	}
	public void setReceive_sms(int receive_sms) {
		this.receive_sms = receive_sms;
	}
	public String getId_card() {
		return id_card;
	}
	public void setId_card(String id_card) {
		this.id_card = id_card;
	}
	public Date getLast_login() {
		return last_login;
	}
	public void setLast_login(Date last_login) {
		this.last_login = last_login;
	}
	public String getLast_login_ip() {
		return last_login_ip;
	}
	public void setLast_login_ip(String last_login_ip) {
		this.last_login_ip = last_login_ip;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsernick() {
		return usernick;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public int getVideo_count() {
		return video_count;
	}
	public void setVideo_count(int video_count) {
		this.video_count = video_count;
	}
	public int getImage_count() {
		return image_count;
	}
	public void setImage_count(int image_count) {
		this.image_count = image_count;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public Date getBorndate() {
		return borndate;
	}
	public void setBorndate(Date borndate) {
		this.borndate = borndate;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getHead_icon() {
		return head_icon;
	}
	public void setHead_icon(String head_icon) {
		this.head_icon = head_icon;
	}
	public int getIf_protocol() {
		return if_protocol;
	}
	public void setIf_protocol(int if_protocol) {
		this.if_protocol = if_protocol;
	}
	
}
