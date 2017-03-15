package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
/**
 * 订单管理
 * 
 * @Title: UserOrder.java
 * @Package com.yt.framework.persistent.entity
 * @author ylt
 * @date 2016年09月29日 
 */
public class UserOrder implements Serializable {
	
	private static final long serialVersionUID = 8287464522215930890L;
	private String order_id;
	private String order_sn; //订单编号
	private String data_sn;//期号
	private String data_id;  //商品id
	private String user_id; //购买用户id
	private Date create_time; //下单时间
	private Date order_pay_time; //支付时间
	private Long order_pay_num; //支付时间（用于计算夺宝）
	private String order_user_name; //收货人姓名
	private String order_user_phone; //收货人电话
	private String order_address; //收货地址
	private Date order_check_time; //确认领奖时间
	private Integer order_ifcheck; //是否确认
	private String order_user_offer; //用户建议
	private Date order_send_time; //发货时间
	private BigDecimal order_actual_cash; //实际支付宇拓币
	private BigDecimal order_cash; //支付宇拓币
	private Integer order_ifsend; //是否发货
	private String order_nums; //夺宝号码（多个）
	private Integer order_count; //购买次数
	private Integer order_ifwin; //是否中奖
	private String order_status; //订单流程状态  1:进行中 2:已结束 
	private Integer order_ifvalid; //订单是否有效 1:是 0：否
	private String order_send_no;//货单号
	private BigDecimal order_send_cash;//快递费用
	private String order_send;//快递公司
	private String order_buy_channel; //购买渠道 1：手机  2：pc
	private String amount_type; //账户类型 （临时变量）
	private String amount_id;//账户id（临时变量）
	
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getOrder_sn() {
		return order_sn;
	}
	public void setOrder_sn(String order_sn) {
		this.order_sn = order_sn;
	}
	public String getData_id() {
		return data_id;
	}
	public void setData_id(String data_id) {
		this.data_id = data_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getOrder_pay_time() {
		return order_pay_time;
	}
	public void setOrder_pay_time(Date order_pay_time) {
		this.order_pay_time = order_pay_time;
	}
	public String getOrder_user_name() {
		return order_user_name;
	}
	public void setOrder_user_name(String order_user_name) {
		this.order_user_name = order_user_name;
	}
	public String getOrder_user_phone() {
		return order_user_phone;
	}
	public void setOrder_user_phone(String order_user_phone) {
		this.order_user_phone = order_user_phone;
	}
	public String getOrder_address() {
		return order_address;
	}
	public void setOrder_address(String order_address) {
		this.order_address = order_address;
	}
	public Date getOrder_check_time() {
		return order_check_time;
	}
	public void setOrder_check_time(Date order_check_time) {
		this.order_check_time = order_check_time;
	}
	public Integer getOrder_ifcheck() {
		return order_ifcheck;
	}
	public void setOrder_ifcheck(Integer order_ifcheck) {
		this.order_ifcheck = order_ifcheck;
	}
	public Date getOrder_send_time() {
		return order_send_time;
	}
	public void setOrder_send_time(Date order_send_time) {
		this.order_send_time = order_send_time;
	}
	public BigDecimal getOrder_actual_cash() {
		return order_actual_cash;
	}
	public void setOrder_actual_cash(BigDecimal order_actual_cash) {
		this.order_actual_cash = order_actual_cash;
	}
	public BigDecimal getOrder_cash() {
		return order_cash;
	}
	public void setOrder_cash(BigDecimal order_cash) {
		this.order_cash = order_cash;
	}
	public Integer getOrder_ifsend() {
		return order_ifsend;
	}
	public void setOrder_ifsend(Integer order_ifsend) {
		this.order_ifsend = order_ifsend;
	}
	public String getOrder_nums() {
		return order_nums;
	}
	public void setOrder_nums(String order_nums) {
		this.order_nums = order_nums;
	}
	public Integer getOrder_count() {
		return order_count;
	}
	public void setOrder_count(Integer order_count) {
		this.order_count = order_count;
	}
	public Integer getOrder_ifwin() {
		return order_ifwin;
	}
	public void setOrder_ifwin(Integer order_ifwin) {
		this.order_ifwin = order_ifwin;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public Integer getOrder_ifvalid() {
		return order_ifvalid;
	}
	public void setOrder_ifvalid(Integer order_ifvalid) {
		this.order_ifvalid = order_ifvalid;
	}
	public String getOrder_send_no() {
		return order_send_no;
	}
	public void setOrder_send_no(String order_send_no) {
		this.order_send_no = order_send_no;
	}
	public BigDecimal getOrder_send_cash() {
		return order_send_cash;
	}
	public void setOrder_send_cash(BigDecimal order_send_cash) {
		this.order_send_cash = order_send_cash;
	}
	public String getOrder_send() {
		return order_send;
	}
	public void setOrder_send(String order_send) {
		this.order_send = order_send;
	}
	public String getAmount_type() {
		return amount_type;
	}
	public void setAmount_type(String amount_type) {
		this.amount_type = amount_type;
	}
	public String getAmount_id() {
		return amount_id;
	}
	public void setAmount_id(String amount_id) {
		this.amount_id = amount_id;
	}
	public String getData_sn() {
		return data_sn;
	}
	public void setData_sn(String data_sn) {
		this.data_sn = data_sn;
	}
	public Long getOrder_pay_num() {
		return order_pay_num;
	}
	public void setOrder_pay_num(Long order_pay_num) {
		this.order_pay_num = order_pay_num;
	}
	public String getOrder_user_offer() {
		return order_user_offer;
	}
	public void setOrder_user_offer(String order_user_offer) {
		this.order_user_offer = order_user_offer;
	}
	public String getOrder_buy_channel() {
		return order_buy_channel;
	}
	public void setOrder_buy_channel(String order_buy_channel) {
		this.order_buy_channel = order_buy_channel;
	}
	
	
}
