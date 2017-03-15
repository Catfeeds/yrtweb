package com.yt.framework.utils.queue;

import java.util.ArrayList;
import java.util.List;

public class ProcessorManager extends ThreadGroup {
	private static ProcessorManager instance = null;

	private List<QueueProcessor> lisProcessor = new ArrayList<QueueProcessor>();

	private ProcessorManager() {
		super("Thread Pool");
		instance = this;
	}

	public static ProcessorManager getInstance() {
		if (instance == null) {
			synchronized (ProcessorManager.class) {
				if (instance == null) {
					instance = new ProcessorManager();
				}
			}
		}
		return instance;
	}

	public synchronized void startup() {
		startProcessor();
	}

	/**
	 * 注册处理任务的类
	 * 
	 * @param proc
	 */
	public synchronized void registerQueueProcessor(QueueProcessor proc) {
		lisProcessor.add(proc);
	}

	public void startProcessor() {
		for (QueueProcessor processor : lisProcessor)
			processor.start();
	}

	public void startQueueProcessor() {
		ProcessorManager p = ProcessorManager.getInstance();
		p.registerQueueProcessor(new QueueProcessorWorkOrder());
		p.registerQueueProcessor(new QueueProcessorRemind());
		p.startup();
		QueueContainer.getContainer().addTaskRemindQueue(new TaskDetecting());

	}
}
