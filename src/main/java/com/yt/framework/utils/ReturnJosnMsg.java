package com.yt.framework.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


/**
 * 
 * @author yjh
 *
 */
public class ReturnJosnMsg  {
	private int state=0;
	private String message="success";
	private static Gson gson = new GsonBuilder().serializeNulls().create();

	
	public ReturnJosnMsg(int state, String message) {
		super();
		this.state = state;
		this.message = message;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public static ReturnJosnMsg newSuccess() {
		return new ReturnJosnMsg(0,"成功");
	}

	public static ReturnJosnMsg newError() {
		return new ReturnJosnMsg(-1,"失败");
	}

	public String toJson() {
		return gson.toJson(this);
	}

}

