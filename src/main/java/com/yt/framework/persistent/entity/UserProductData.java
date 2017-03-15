package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class UserProductData implements Serializable {
	private static final long serialVersionUID = 1L;

	private String data_id;
	private String data_sn;// 商品期号
	private String product_id;// 产品id
	private String category_id;// 分类id
	private Integer data_total_count;// 商品夺宝总需人次
	private BigDecimal data_total_price;// 夺宝总价
	private BigDecimal data_single_price;// 夺宝单价
	private Integer data_count;// 商品当前夺宝人次
	private String data_status;// 商品状态：1:等待 2:进行中 3：揭晓中 4：已结束
	private Integer data_turn;// 商品开启当前轮次
	private Date data_start_time;// 商品夺宝开始时间
	private Date data_finish_time;// 商品夺宝结束时间
	private String data_win_num;// 中奖号码
	private String data_win_user;//中奖用户id
	private String data_total_num;//参与用户时间求和
	private String data_remainder;//参与用户时间求和除以人数得余数
	private String data_ticket;//时时彩中奖号码
	private String data_calculate_count;//号码计算人次
	
	
	public String getData_id() {
		return data_id;
	}

	public void setData_id(String data_id) {
		this.data_id = data_id;
	}

	public String getData_sn() {
		return data_sn;
	}

	public void setData_sn(String data_sn) {
		this.data_sn = data_sn;
	}

	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getCategory_id() {
		return category_id;
	}

	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}

	public Integer getData_total_count() {
		return data_total_count;
	}

	public void setData_total_count(Integer data_total_count) {
		this.data_total_count = data_total_count;
	}

	public BigDecimal getData_total_price() {
		return data_total_price;
	}

	public void setData_total_price(BigDecimal data_total_price) {
		this.data_total_price = data_total_price;
	}

	public BigDecimal getData_single_price() {
		return data_single_price;
	}

	public void setData_single_price(BigDecimal data_single_price) {
		this.data_single_price = data_single_price;
	}

	public Integer getData_count() {
		return data_count;
	}

	public void setData_count(Integer data_count) {
		this.data_count = data_count;
	}

	public String getData_status() {
		return data_status;
	}

	public void setData_status(String data_status) {
		this.data_status = data_status;
	}

	public Integer getData_turn() {
		return data_turn;
	}

	public void setData_turn(Integer data_turn) {
		this.data_turn = data_turn;
	}

	public Date getData_start_time() {
		return data_start_time;
	}

	public void setData_start_time(Date data_start_time) {
		this.data_start_time = data_start_time;
	}

	public Date getData_finish_time() {
		return data_finish_time;
	}

	public void setData_finish_time(Date data_finish_time) {
		this.data_finish_time = data_finish_time;
	}

	public String getData_win_num() {
		return data_win_num;
	}

	public void setData_win_num(String data_win_num) {
		this.data_win_num = data_win_num;
	}

	public String getData_win_user() {
		return data_win_user;
	}

	public void setData_win_user(String data_win_user) {
		this.data_win_user = data_win_user;
	}

	public String getData_total_num() {
		return data_total_num;
	}

	public void setData_total_num(String data_total_num) {
		this.data_total_num = data_total_num;
	}

	public String getData_remainder() {
		return data_remainder;
	}

	public void setData_remainder(String data_remainder) {
		this.data_remainder = data_remainder;
	}

	public String getData_ticket() {
		return data_ticket;
	}

	public void setData_ticket(String data_ticket) {
		this.data_ticket = data_ticket;
	}

	public String getData_calculate_count() {
		return data_calculate_count;
	}

	public void setData_calculate_count(String data_calculate_count) {
		this.data_calculate_count = data_calculate_count;
	}
	
	
		
}
