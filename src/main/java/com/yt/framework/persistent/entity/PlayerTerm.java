package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

/**
 * 球员查询条件
 *@autor ylt
 *@date2015-8-25下午6:59:46
 */
public class PlayerTerm implements Serializable{

	private static final long serialVersionUID = 7841536373920163983L;
	private Integer begin_age ; //开始年龄
	private Integer end_age; //结束年龄
	private Integer level; //类别 是否妖人球员
	private String age;//年龄
	private String t_name;//球队名称
	private String agent_name;//经济人名称
	private String begin_score;//综合得分
	private String end_score;//综合得分
	private String position; // 场上位置
	private String time_period;// 喜欢参赛时间（周末，非周末）
	private Integer ball_format; // 喜爱赛制（5、7、11）
	private String usernick;//用户昵称
	private String city;//所属城市
	private String user_id; //访问用户id
	private String age_sort;//年龄排序
	private String h_sort;//身高排序
	private String w_sort;//体重排序
	private String score_sort;//能力排序
	private Integer sex;//性别
	private String cfoot;//惯用脚
	private String s_user_id;//关注用户标志
	
	
	public Integer getBegin_age() {
		if(StringUtils.isNotBlank(age)){
			String []ages = age.split(",");
			begin_age  = Integer.parseInt(ages[0]);
		}
		return begin_age;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public void setBegin_age(Integer begin_age) {
		this.begin_age = begin_age;
	}
	public Integer getEnd_age() {
		if(StringUtils.isNotBlank(age)){
			String []ages = age.split(",");
			if(ages.length>1){
				end_age  = Integer.parseInt(ages[1]);
			}
		}	
		return end_age;
	}
	public void setEnd_age(Integer end_age) {
		this.end_age = end_age;
	}
	public String getT_name() {
		return t_name;
	}
	public void setT_name(String t_name) {
		this.t_name = t_name;
	}
	public String getAgent_name() {
		return agent_name;
	}
	public void setAgent_name(String agent_name) {
		this.agent_name = agent_name;
	}
	
	public String getBegin_score() {
		return begin_score;
	}
	public void setBegin_score(String begin_score) {
		this.begin_score = begin_score;
	}
	public String getEnd_score() {
		return end_score;
	}
	public void setEnd_score(String end_score) {
		this.end_score = end_score;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getTime_period() {
		return time_period;
	}
	public void setTime_period(String time_period) {
		this.time_period = time_period;
	}
	public Integer getBall_format() {
		return ball_format;
	}
	public void setBall_format(Integer ball_format) {
		this.ball_format = ball_format;
	}
	public String getUsernick() {
		return usernick;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAge_sort() {
		return age_sort;
	}
	public void setAge_sort(String age_sort) {
		this.age_sort = age_sort;
	}
	public String getH_sort() {
		return h_sort;
	}
	public void setH_sort(String h_sort) {
		this.h_sort = h_sort;
	}
	public String getW_sort() {
		return w_sort;
	}
	public void setW_sort(String w_sort) {
		this.w_sort = w_sort;
	}
	public String getScore_sort() {
		return score_sort;
	}
	public void setScore_sort(String score_sort) {
		this.score_sort = score_sort;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getCfoot() {
		return cfoot;
	}
	public void setCfoot(String cfoot) {
		this.cfoot = cfoot;
	}
	public String getS_user_id() {
		return s_user_id;
	}
	public void setS_user_id(String s_user_id) {
		this.s_user_id = s_user_id;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	
	
}
