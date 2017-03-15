package com.yt.framework.utils.exceptions;

/**
 * 登录异常
 * @author bo.xie
 * 2015年7月21日15:00:30
 */
public class NeedLoginException extends RuntimeException {

	private static final long serialVersionUID = -8398604317722295375L;

	private String target;

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public NeedLoginException(String target) {
		super();
		this.target = target;
	}

	public NeedLoginException() {
		super();
	}
}
