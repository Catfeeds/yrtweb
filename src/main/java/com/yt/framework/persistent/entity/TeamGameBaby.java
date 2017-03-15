package com.yt.framework.persistent.entity;
import java.util.List;

/**
 * 俱乐部比赛宝贝
 *@autor ylt
 *@date2015-8-14 下午3:47:25
 */
@SuppressWarnings("serial")
public class TeamGameBaby extends TeamGame{
	List<UserBaby> users;

	public List<UserBaby> getUsers() {
		return users;
	}

	public void setUsers(List<UserBaby> users) {
		this.users = users;
	}

	
}
