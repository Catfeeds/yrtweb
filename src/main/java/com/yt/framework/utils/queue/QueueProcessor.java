package com.yt.framework.utils.queue;

public abstract class QueueProcessor extends Thread {
	private boolean continueToRun;
	private QueueContainer eventContainer;

	public QueueProcessor() {
		this.continueToRun = true;
		eventContainer = QueueContainer.getContainer();
	}

	public void run() {
		while (isRunning()) {
				process(eventContainer);
		}
	}

	public abstract void process(QueueContainer eventContainer);

	public synchronized void stopRunning() {
		continueToRun = false;
	}

	public synchronized boolean isRunning() {
		return continueToRun;
	}

}
