package com.yt.framework.utils.queue;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;


/**
 * 任务检测
 * 
 * @author YJH
 * @date 2014年6月24日
 */
public class TaskDetecting {
	static Logger logger = LogManager.getLogger(TaskDetecting.class.getName());
	private String taskId;
	private long startTime;
	private int taskType = 1;//1:订单
	private Object taskObject;

	
	
	public TaskDetecting() {
		super();
		this.startTime = System.currentTimeMillis();
		taskType = 0;
	}

	public TaskDetecting(String taskId, int taskType, Object taskObject) {
		super();
		this.taskId = taskId;
		this.taskType = taskType;
		this.taskObject = taskObject;
		this.startTime = System.currentTimeMillis();
	}

	public void sleep(long time) {
		try {
			if (time <= 0)
				time = 60000;
			Thread.sleep(time);
		} catch (InterruptedException e) {
			logger.error(e.getLocalizedMessage(),e);
		}
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public long getStartTime() {
		return startTime;
	}

	public void setStartTime(long startTime) {
		this.startTime = startTime;
	}

	public int getTaskType() {
		return taskType;
	}

	public void setTaskType(int taskType) {
		this.taskType = taskType;
	}

	public boolean isTest() {
		return taskType==0;
	}

	public Object getTaskObject() {
		return taskObject;
	}

	public void setTaskObject(Object taskObject) {
		this.taskObject = taskObject;
	}

	
}
