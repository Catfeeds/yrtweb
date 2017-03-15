package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 订单详情
 *@autor bo.xie
 *@date2015-8-3下午6:59:46
 */
public class OrderDetail implements Serializable{

	private static final long serialVersionUID = 7980069503396378289L;
	private String id;
	/**
	 * 订单编号
	 */
	private String parent_orid;
	/**
	 * 创建时间
	 */
	private Date create_time;
	/**
	 * 是否作废: 0 作废 1 有效
	 */
	private int if_del;
	/**
	 * 购买数量
	 */
	private int mount;
	/**
	 * 小计金额
	 */
	private float p_total;
	/**
	 * 单价
	 */
	private float s_price;
	/**
	 * 商品id
	 */
	private String p_id;
	/**
	 * 商品分类 : 1 宇拓币 、2 皮肤 、 3 礼物
	 */
	private int p_type; 
	/**
	 * 付款时间
	 */
	private Date pay_time;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParent_orid() {
		return parent_orid;
	}
	public void setParent_orid(String parent_orid) {
		this.parent_orid = parent_orid;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public int getIf_del() {
		return if_del;
	}
	public void setIf_del(int if_del) {
		this.if_del = if_del;
	}
	public int getMount() {
		return mount;
	}
	public void setMount(int mount) {
		this.mount = mount;
	}
	public float getP_total() {
		return p_total;
	}
	public void setP_total(float p_total) {
		this.p_total = p_total;
	}
	public float getS_price() {
		return s_price;
	}
	public void setS_price(float s_price) {
		this.s_price = s_price;
	}
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	public int getP_type() {
		return p_type;
	}
	public void setP_type(int p_type) {
		this.p_type = p_type;
	}
	public Date getPay_time() {
		return pay_time;
	}
	public void setPay_time(Date pay_time) {
		this.pay_time = pay_time;
	}
	
	
}
