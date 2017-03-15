package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 
 * <p>
 * 论坛版主实体对象
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月7日 上午11:54:45
 * @version
 */
public class BbsLeader implements Serializable{

	private static final long serialVersionUID = 4784824746994355157L;
    private String id;
    private String user_id;//版主用户id
    private String plate_id;//板块id
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date duty_time;//任职时间
    private String remark;//备注
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPlate_id() {
		return plate_id;
	}
	public void setPlate_id(String plate_id) {
		this.plate_id = plate_id;
	}
	public Date getDuty_time() {
		return duty_time;
	}
	public void setDuty_time(Date duty_time) {
		this.duty_time = duty_time;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
    
}
