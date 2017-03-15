package com.yt.framework.persistent.entity;

import java.io.Serializable;
/**
 * 
 * <p>
 * 点赞与点踩实体对象
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月7日 下午12:02:48
 * @version
 */
import java.util.Date;
public class BbsPraise implements Serializable{

	private static final long serialVersionUID = -294355044814677156L;
    private String id;
    private String user_id;//点击人
    private Integer state;//赞（1）踩（2）
    private Date create_time;//点击日期
    private Integer type;//点击类型:帖子（1）、回复内容（2）
    private String b_id;//关联数据id（帖子id，回复内容id）
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
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getB_id() {
		return b_id;
	}
	public void setB_id(String b_id) {
		this.b_id = b_id;
	}
    
    
    
}
