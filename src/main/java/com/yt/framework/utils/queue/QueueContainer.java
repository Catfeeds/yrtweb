package com.yt.framework.utils.queue;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;



public class QueueContainer {
	private static QueueContainer eventContainer = new QueueContainer();
	private BlockingQueue<TaskDetecting> taskDetectingQueue;
	private BlockingQueue<TaskDetecting> taskRemindQueue;
	Map<String, WorkOrderEntity> workOrderMap = new HashMap<String, WorkOrderEntity>();

	public QueueContainer() {
		this.taskDetectingQueue = new LinkedBlockingQueue<TaskDetecting>();
		this.taskRemindQueue = new LinkedBlockingQueue<TaskDetecting>();
	}

	public static QueueContainer getContainer() {
		return eventContainer;
	}


	public void addTaskRemindQueue(TaskDetecting obj) {
		taskRemindQueue.add(obj);
	}

	public TaskDetecting takeTaskRemindEntity() throws InterruptedException {
		return taskRemindQueue.take();
	}
	
	public void addTaskDetectingQueue(TaskDetecting obj) {
		taskDetectingQueue.add(obj);
	}

	public TaskDetecting takeTaskDetectingEntity() throws InterruptedException {
		return taskDetectingQueue.take();
	}

	public void addWorkOrder(String key, WorkOrderEntity woe) {
		if (workOrderMap.containsKey(key)) {
			workOrderMap.remove(key);
			workOrderMap.put(key, woe);
		}else{
			workOrderMap.put(key, woe);
		}
	}
	public void removeWorkOrder(String key) {
		workOrderMap.remove(key);
	}

	public WorkOrderEntity getWorkOrder(String key) {
		return workOrderMap.get(key);
	}
	public List<String> getWorkOrderKeys() {
		Set<String> kset = workOrderMap.keySet();
		List<String> keyList = new ArrayList<String>();
		keyList.addAll(kset);
		return keyList;
	}

	public List<WorkOrderEntity> getWorkOrderList() {
		List<WorkOrderEntity> woeList = new ArrayList<WorkOrderEntity>();
		List<String> keyList = getWorkOrderKeys();
		for(String key:keyList){
			woeList.add(workOrderMap.get(key));
		}
		return woeList;
	}
}
