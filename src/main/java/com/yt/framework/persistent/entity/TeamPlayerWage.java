package com.yt.framework.persistent.entity;

public class TeamPlayerWage implements Cloneable {
	private String dynamic_id;
	private String user_id;
	private String user_name;
	private String user_head_src;
	private String player_num;
	private String position;
	private String amount;
	private String create_time;
	private String text;
	private long createtime;

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDynamic_id() {
		return dynamic_id;
	}

	public void setDynamic_id(String dynamic_id) {
		this.dynamic_id = dynamic_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_head_src() {
		return user_head_src;
	}

	public void setUser_head_src(String user_head_src) {
		this.user_head_src = user_head_src;
	}

	public String getPlayer_num() {
		return player_num;
	}

	public void setPlayer_num(String player_num) {
		this.player_num = player_num;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
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

	public long getCreatetime() {
		return createtime;
	}

	public void setCreatetime(long createtime) {
		this.createtime = createtime;
	}

}
