package com.yt.framework.utils.queue;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.service.UserOrderService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.SpringContextUtil;
import com.yt.framework.utils.gson.JSONUtils;

public class QueueProcessorWorkOrder extends QueueProcessor {
	static Logger logger = LogManager.getLogger(QueueProcessorWorkOrder.class.getName());

	public void process(QueueContainer eventContainer) {

		try {
			TaskDetecting tse = eventContainer.takeTaskDetectingEntity();
			String key = tse.getTaskId();
			if (tse.getTaskType() == 1) {// 订单
				WorkOrderEntity woe = (WorkOrderEntity) tse.getTaskObject();
				execute(woe);
				QueueContainer.getContainer().removeWorkOrder(key);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}

	public void execute(WorkOrderEntity woe) {
		UserOrder order = woe.getOrder();
		UserOrderService userOrderService = (UserOrderService) SpringContextUtil.getBean("userOrderService");
		//保存订单
		try {
			AjaxMsg msg = userOrderService.saveQueueUserOrder(order);
			logger.info("==============="+msg.toJson()+"===========");
		} catch (Exception e) {
			logger.info("===============保存订单出错===========" + e.getMessage());
			e.printStackTrace();
		}
		System.out.println("执行选号业务:"+JSONUtils.bean2json(woe)); 
	}

}
