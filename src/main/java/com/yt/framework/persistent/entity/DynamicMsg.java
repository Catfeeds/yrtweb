package com.yt.framework.persistent.entity;

public class DynamicMsg implements Cloneable{
	private String dynamic_id;
	private String user_id;
	private String user_name;
	private String user_head_src;
	private String image_src;
	private String msg_type;
	private String user_type;
	private String create_time;
	private String text;
	private long createtime;
	
	private boolean msg_me=false;
	private boolean isImages=false;

	
	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getDynamic_id() {
		return dynamic_id;
	}

	public void setDynamic_id(String dynamic_id) {
		this.dynamic_id = dynamic_id;
	}

	public boolean isImages() {
		return isImages;
	}

	public void setImages(boolean isImages) {
		this.isImages = isImages;
	}

	public String getUser_head_src() {
		return user_head_src;
	}

	public void setUser_head_src(String user_head_src) {
		this.user_head_src = user_head_src;
	}

	public long getCreatetime() {
		return createtime;
	}

	public void setCreatetime(long createtime) {
		this.createtime = createtime;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getMsg_type() {
		return msg_type;
	}

	public void setMsg_type(String msg_type) {
		this.msg_type = msg_type;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getImage_src() {
		return image_src;
	}

	public void setImage_src(String image_src) {
		this.image_src = image_src;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public boolean isMsg_me() {
		return msg_me;
	}

	public void setMsg_me(boolean msg_me) {
		this.msg_me = msg_me;
	}
	public DynamicMsg clone() {   
        try {   
            return (DynamicMsg) super.clone();   
        } catch (CloneNotSupportedException e) {   
            return null;   
        }   
    }   
}
