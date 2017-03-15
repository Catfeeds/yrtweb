package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单
 *@autor ylt
 *@date2015-8-3下午6:59:46
 */
public class Order implements Serializable{

	private static final long serialVersionUID = 6626908272179493087L;
	
	private String id;
	private String user_id;//用户ID
	private String teaminfo_id;//俱乐部ID
	private String num_str;//订单号
	private BigDecimal price;//单价
	private int mount;//购买数量
	private BigDecimal sum_amount;//总价
	private String p_code;//商品代码
	private Date create_time;
	
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
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
	public String getNum_str() {
		return num_str;
	}
	public void setNum_str(String num_str) {
		this.num_str = num_str;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public int getMount() {
		return mount;
	}
	public void setMount(int mount) {
		this.mount = mount;
	}
	public BigDecimal getSum_amount() {
		return sum_amount;
	}
	public void setSum_amount(BigDecimal sum_amount) {
		this.sum_amount = sum_amount;
	}
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
}
