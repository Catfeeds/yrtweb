package com.yt.framework.persistent.entity;

import java.util.Date;

public class ScheduleJob {
    /** 任务id */
    private String id;
    /** 任务标志 */
    private String job_name;
    /** 任务分组 */
    private String job_group;
    /** 任务状态 0禁用 1启用*/
    private int job_status;
    /** 任务运行时间表达式 */
    private String cron_expression;
    /** 任务描述 */
    private String remark;
    /** 任务执行实现类*/
    private String class_name;
    
    private Date create_time;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getJob_name() {
		return job_name;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}

	public String getJob_group() {
		return job_group;
	}

	public void setJob_group(String job_group) {
		this.job_group = job_group;
	}

	public int getJob_status() {
		return job_status;
	}

	public void setJob_status(int job_status) {
		this.job_status = job_status;
	}

	public String getCron_expression() {
		return cron_expression;
	}

	public void setCron_expression(String cron_expression) {
		this.cron_expression = cron_expression;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
}
