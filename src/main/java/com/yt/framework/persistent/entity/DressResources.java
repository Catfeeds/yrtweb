package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 个人中心皮肤
 * @Title: DressResources.java 
 * @Package com.yt.framework.persistent.entity
 * @author GL
 * @date 2015年8月17日 下午3:33:59 
 */
public class DressResources implements Serializable {

	private static final long serialVersionUID = -7265885632805792497L;
	private String id;
	private String user_id;// 管理用户ID
	private String name;// 模版名称
	private String css_src;// 模版路径
	private String img_src;// 封面
	private BigDecimal money;// 购买永久模板价格
	private BigDecimal price_month;// 模板单价/月
	private Date create_time;

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCss_src() {
		return css_src;
	}

	public void setCss_src(String css_src) {
		this.css_src = css_src;
	}

	public String getImg_src() {
		return img_src;
	}

	public void setImg_src(String img_src) {
		this.img_src = img_src;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public BigDecimal getPrice_month() {
		return price_month;
	}

	public void setPrice_month(BigDecimal price_month) {
		this.price_month = price_month;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

}
