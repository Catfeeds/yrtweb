package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 *认证实体类
 *@autor bo.xie
 *@date2015-8-25上午11:39:48
 */
public class Certification {

	private String id;
	/**
	 * 用户ID
	 */
	private String user_id;
	/**
	 * 认证类型
	 */
	private String type; //认证类型 职业球员认证：professional，身份证认证：idcard
	/**
	 * 身份证号码
	 */
	private String id_card;
	/**
	 * 认证图片
	 */
	private String img_src;
	
	private String permit_img_src;
	/**
	 * 认证状态 0：未认证  1：已认证  2：认证中  3：认证失败
	 */
	private int status;
	/**
	 * 描述
	 */
	private String descripe;
	
	private String name;
	/**
	 * 审核通过时间
	 */
	private Date audit_time;
	/**
	 * 创建时间，申请时间
	 */
	private Date create_time;
	
	public Date getAudit_time() {
		return audit_time;
	}
	public void setAudit_time(Date audit_time) {
		this.audit_time = audit_time;
	}
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getId_card() {
		return id_card;
	}
	public void setId_card(String id_card) {
		this.id_card = id_card;
	}
	public String getImg_src() {
		return img_src;
	}
	public void setImg_src(String img_src) {
		this.img_src = img_src;
	}
	public String getPermit_img_src() {
		return permit_img_src;
	}
	public void setPermit_img_src(String permit_img_src) {
		this.permit_img_src = permit_img_src;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDescripe() {
		return descripe;
	}
	public void setDescripe(String descripe) {
		this.descripe = descripe;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
