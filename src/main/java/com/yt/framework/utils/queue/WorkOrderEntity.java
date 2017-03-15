package com.yt.framework.utils.queue;


import com.yt.framework.persistent.entity.UserOrder;

public class WorkOrderEntity {
	private String order_sn;
	private UserOrder order ;

	public WorkOrderEntity() {

	}

	public UserOrder getOrder() {
		return order;
	}

	public void setOrder(UserOrder order) {
		this.order = order;
	}

	public WorkOrderEntity(UserOrder order) {
		this.order = order;
		order_sn = order.getOrder_sn();
	}

	public String getOrder_sn() {
		return order_sn;
	}

	public void setOrder_sn(String order_sn) {
		this.order_sn = order_sn;
	}


}
