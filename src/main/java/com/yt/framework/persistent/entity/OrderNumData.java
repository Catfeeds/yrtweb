package com.yt.framework.persistent.entity;

import java.io.Serializable;

public class OrderNumData implements Serializable {
	private static final long serialVersionUID = 1L;

	private String num_id;
	private String data_sn;// 商品期号
	private String order_num;//  号码
	private Integer order_num_mark;// 下标
	private String order_sn;// 

	public String getNum_id() {
		return num_id;
	}

	public void setNum_id(String num_id) {
		this.num_id = num_id;
	}

	public String getData_sn() {
		return data_sn;
	}

	public void setData_sn(String data_sn) {
		this.data_sn = data_sn;
	}

	public String getOrder_num() {
		return order_num;
	}

	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}


	public Integer getOrder_num_mark() {
		return order_num_mark;
	}

	public void setOrder_num_mark(Integer order_num_mark) {
		this.order_num_mark = order_num_mark;
	}

	public String getOrder_sn() {
		return order_sn;
	}

	public void setOrder_sn(String order_sn) {
		this.order_sn = order_sn;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
