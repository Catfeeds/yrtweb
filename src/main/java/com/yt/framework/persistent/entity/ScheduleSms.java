package com.yt.framework.persistent.entity;

import java.util.Date;

/**
 *短信发送计划任务
 *@autor bo.xie
 *@date2015-9-19下午4:34:07
 */
public class ScheduleSms {

	private Long id;
	private String name;
	/**
	 * 手机号
	 */
	private String phone;
	
	/**
	 * 发送参数
	 */
	private String params;
	
	/**
	 * 发送文本内容
	 */
	private String content;
	/**
	 * 应发送时间
	 */
	private Date send_time;
	private Date create_time;
	/**
	 * 短信模板ID
	 */
	private String model_id;
	/**
	 * 0:未发送，1：已发送
	 */
	private int status;
	/**
	 * 0:发送失败,1:发送成功
	 */
	private int send_result;
	
	private int receive_sms;//是否接受短信通知 1：接受 2：不接受
	
	public int getReceive_sms() {
		return receive_sms;
	}
	public void setReceive_sms(int receive_sms) {
		this.receive_sms = receive_sms;
	}
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getSend_time() {
		return send_time;
	}
	public void setSend_time(Date send_time) {
		this.send_time = send_time;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getModel_id() {
		return model_id;
	}
	public void setModel_id(String model_id) {
		this.model_id = model_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getSend_result() {
		return send_result;
	}
	public void setSend_result(int send_result) {
		this.send_result = send_result;
	}
	
	
}
