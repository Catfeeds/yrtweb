package com.yt.framework.utils;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class EhCacheObj {
	static Logger logger = LogManager.getLogger(EhCacheObj.class.getName());
	private int survival_time=8*60*60*1000;//默认缓存8小时
	private long lastTime;
	private Object obj;

	public EhCacheObj(Object obj) {
		super();
		this.lastTime = System.currentTimeMillis();
		this.obj=obj;
	}
	public long getLastTime() {
		return lastTime;
	}

	public void setLastTime(long lastTime) {
		this.lastTime = lastTime;
	}
	public int getSurvival_time() {
		return survival_time;
	}
	public void setSurvival_time(int survival_time) {
		this.survival_time = survival_time;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}

}
