package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *充值Entity
 *@autor bo.xie
 *@date2015-8-10下午2:39:40
 */
public class PayRecord implements Serializable {

	private static final long serialVersionUID = -9168989791915348747L;
	
	private String id;
	private String user_id;//用户ID
	private String teaminfo_id;//俱乐部ID
	private String operate_id;//操作人ID
	private BigDecimal amount;//充值金额
	private BigDecimal free;//手续费
	private BigDecimal real_amount;//实得金额
	private String payer_no;//付款方帐号
	private String cash_no;//收款款方帐号
	private String order_no;//充值订单号
	private String bank_no;//交易流水号
	private String describle;//备注描述
	private Date create_time;//创建时间
	private String third_part;//第三方支付 支付宝，国付宝，银联等等
	private int status;//充值状态：0:充值失败，1：充值成功
	private String way;//充值方式ONLINE：线上充值 OFFLINE:线下充值
	private Date submit_time;//提交时间
	private Date end_time;//结束时间
	private int type;//充值类型 1：购买宇拓币 2：联赛报名费用
	
	public String getOperate_id() {
		return operate_id;
	}
	public void setOperate_id(String operate_id) {
		this.operate_id = operate_id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getCash_no() {
		return cash_no;
	}
	public void setCash_no(String cash_no) {
		this.cash_no = cash_no;
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
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public BigDecimal getFree() {
		return free;
	}
	public void setFree(BigDecimal free) {
		this.free = free;
	}
	public BigDecimal getReal_amount() {
		return real_amount;
	}
	public void setReal_amount(BigDecimal real_amount) {
		this.real_amount = real_amount;
	}
	public String getPayer_no() {
		return payer_no;
	}
	public void setPayer_no(String payer_no) {
		this.payer_no = payer_no;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public String getBank_no() {
		return bank_no;
	}
	public void setBank_no(String bank_no) {
		this.bank_no = bank_no;
	}
	public String getDescrible() {
		return describle;
	}
	public void setDescrible(String describle) {
		this.describle = describle;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getThird_part() {
		return third_part;
	}
	public void setThird_part(String third_part) {
		this.third_part = third_part;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getWay() {
		return way;
	}
	public void setWay(String way) {
		this.way = way;
	}
	public Date getSubmit_time() {
		return submit_time;
	}
	public void setSubmit_time(Date submit_time) {
		this.submit_time = submit_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	
	
}
