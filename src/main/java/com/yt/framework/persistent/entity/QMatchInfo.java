package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
/**
 * 
 * <p>
 * 接口参赛信息
 * <p>
 * 
 * @author zhangwei
 * @Date 2015年12月22日 下午5:26:43
 * @version
 */
public class QMatchInfo implements Serializable{
     
	private static final long serialVersionUID = 1L;
	private String id;
	private String match_id;//接口赛事id
	private String home_id;//接口主队id
	private String home_name;//接口主队名称
	private String visit_id;//接口客队id
	private String visit_name;//接口客队名称
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") 
	private Date date_time;//比赛时间
	private String space_name;//比赛场地名称
	private String space_address;//比赛场地地址
	private String h_team_id;//关联主队俱乐部id
	private String v_team_id;//关联客队俱乐部id
	private String league_id;//关联联赛id
	private String record_id;//关联赛事记录id
	private Integer status;//比赛信息状态【1,未发布 2,已发布 3,已作废】
	private Date create_time;//创建时间
	private Integer invokeCount;//接口调用次数
	private Integer review_status;//审核状态【1,未审核 2,已审核】
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getHome_name() {
		return home_name;
	}
	public void setHome_name(String home_name) {
		this.home_name = home_name;
	}
	public String getVisit_name() {
		return visit_name;
	}
	public void setVisit_name(String visit_name) {
		this.visit_name = visit_name;
	}
	public Date getDate_time() {
		return date_time;
	}
	public void setDate_time(Date date_time) {
		this.date_time = date_time;
	}
	public String getSpace_name() {
		return space_name;
	}
	public void setSpace_name(String space_name) {
		this.space_name = space_name;
	}
	public String getSpace_address() {
		return space_address;
	}
	public void setSpace_address(String space_address) {
		this.space_address = space_address;
	}
	public String getH_team_id() {
		return h_team_id;
	}
	public void setH_team_id(String h_team_id) {
		this.h_team_id = h_team_id;
	}
	public String getV_team_id() {
		return v_team_id;
	}
	public void setV_team_id(String v_team_id) {
		this.v_team_id = v_team_id;
	}
	public String getRecord_id() {
		return record_id;
	}
	public void setRecord_id(String record_id) {
		this.record_id = record_id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Integer getInvokeCount() {
		return invokeCount;
	}
	public void setInvokeCount(Integer invokeCount) {
		this.invokeCount = invokeCount;
	}
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public Integer getReview_status() {
		return review_status;
	}
	public void setReview_status(Integer review_status) {
		this.review_status = review_status;
	}
	public String getMatch_id() {
		return match_id;
	}
	public void setMatch_id(String match_id) {
		this.match_id = match_id;
	}
	public String getHome_id() {
		return home_id;
	}
	public void setHome_id(String home_id) {
		this.home_id = home_id;
	}
	public String getVisit_id() {
		return visit_id;
	}
	public void setVisit_id(String visit_id) {
		this.visit_id = visit_id;
	}
}
