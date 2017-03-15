package com.yt.framework.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.DynamicMsg;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.gson.JSONUtils;


/**
 * 
 * @author YJH
 *
 * 2015年11月12日
 */
public class EhCache {

	private static EhCache singleton = new EhCache();
	private Map<String, EhCacheObj> cacheMap;
	private List<DynamicMsg> dymsgList;
	private List<String> dymsgListKey;
	private boolean newDynamic=false;

	public EhCache() {
		cacheMap = new HashMap<String, EhCacheObj>();
		dymsgList = new ArrayList<DynamicMsg>();
		dymsgListKey = new ArrayList<String>();
	}


	public synchronized boolean isNewDynamic() {
		return newDynamic;
	}


	public synchronized void setNewDynamic(boolean newDynamic) {
		this.newDynamic = newDynamic;
	}
	public synchronized User addUserToCache(UserService userService,String userid) {
		User user = userService.getEntityById(userid);
		if (user != null) {
			List<String> ls = userService.getUserRole(userid);
			user.setUser_type(ls);
			EhCache.getInstance().add(userid, new EhCacheObj(user));
		}
		return user;
	}

	public synchronized static EhCache getInstance() {
		if (null == singleton) {
			singleton = new EhCache();
		}
		return singleton;
	}

	public void add(String key, EhCacheObj obj) {
		EhCacheObj old = get(key);
		if (old != null) {
			old.setLastTime(System.currentTimeMillis());
			old.setObj(obj.getObj());
		} else {
			obj.setLastTime(System.currentTimeMillis());
			cacheMap.put(key, obj);
		}
	}
	public EhCacheObj get(String key) {
		return cacheMap.get(key);
	}
	public void remove(String key) {
		cacheMap.remove(key);
	}
	public Long getMaxDateLong() {
		if(dymsgList.size()>0){
			 return dymsgList.get(dymsgList.size()-1).getCreatetime();
		}
		return 0l;
	}
	public String getMaxDate() {
		Date d = new Date();
		if(dymsgList.size()>0){
			 d = new Date(dymsgList.get(dymsgList.size()-1).getCreatetime());
		}
		return JSONUtils.formatDate(d, null);
	}
	public String getMinDate() {
		String retd = dateModify(new Date(),10);
		if(dymsgList.size()>0){
			Date d = new Date(dymsgList.get(0).getCreatetime());
			retd = JSONUtils.formatDate(d, null);
		}
		return retd;
	
	}
	public boolean isCache(String key) {
		EhCacheObj olu = cacheMap.get(key);
		if(olu==null)return false;
				
		long cutime = System.currentTimeMillis()-olu.getLastTime();
		if(cutime>=olu.getSurvival_time()){
			remove(key);
			return false;
		}
		return true;
	}


	public List<DynamicMsg> getDymsgList() {
		return dymsgList;
	}
	public List<DynamicMsg> getDymsgNewList(long lastTime) {
		List<DynamicMsg> retList=new ArrayList<DynamicMsg>();
		if(this.getMaxDateLong()<lastTime){
			return retList;
		}
		for(DynamicMsg dm:dymsgList){
			if(dm.getCreatetime()>lastTime){
				retList.add(dm);
			}
		}
		return retList;
	}

	public void setDymsgList(List<DynamicMsg> dymsgList) {
		this.dymsgList = dymsgList;
	}


	public List<String> getDymsgListKey() {
		return dymsgListKey;
	}

	public synchronized void addDymsg(DynamicMsg dm) {
		String key = dm.getDynamic_id();
		if (!dymsgListKey.contains(key)) {
			dymsgList.add(dm);
			dymsgListKey.add(key);
		}
	}
	public synchronized void addDymsgList(List<DynamicMsg> dymsgNewList) {
		for(DynamicMsg dm:dymsgNewList){
			addDymsg(dm);
		}
	}

	public void setDymsgListKey(List<String> dymsgListKey) {
		this.dymsgListKey = dymsgListKey;
	}
	public static String dateModify(Date dt, int amount) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar c = Calendar.getInstance();
		c.setTime(dt);
		c.add(Calendar.DATE, amount); 
		return sdf.format(c.getTime());
	}
	
}
