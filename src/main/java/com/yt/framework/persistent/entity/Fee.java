package com.yt.framework.persistent.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 手续费记录
 * @author bo.xie
 * @date 2015年11月25日17:14:29
 */
public class Fee {

	private String id;
	private String order_id;//订单ID
	private BigDecimal fee_money;//手续费用
	private Date create_time;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public BigDecimal getFee_money() {
		return fee_money;
	}
	public void setFee_money(BigDecimal fee_money) {
		this.fee_money = fee_money;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
}
