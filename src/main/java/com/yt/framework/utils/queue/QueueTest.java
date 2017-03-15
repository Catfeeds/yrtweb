package com.yt.framework.utils.queue;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.utils.Common;

public class QueueTest {
	
	public static void main(String[] args) {
		ProcessorManager.getInstance().startQueueProcessor();
		System.out.println(System.currentTimeMillis());
		List<String> ls = Common.createAutomaticNum("8",100);
		Collections.shuffle(ls);
		for(String x:ls){
			System.out.println("顺序号"+x);
		}
		UserOrder order = new UserOrder();
		order.setOrder_sn(Common.createOrderOSN());
		String taskId = order.getOrder_sn();
		order.setOrder_count(10);
		order.setOrder_actual_cash(new BigDecimal("1000"));
		WorkOrderEntity taskObject = new WorkOrderEntity(order);
		
		QueueContainer.getContainer().addTaskDetectingQueue(new TaskDetecting(taskId, 1, taskObject ));
	}
}
