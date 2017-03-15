package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.List;

public class QUserDataList implements Serializable{

	private static final long serialVersionUID = -1901905433558794801L;
	private List<QUserData> players;

	public List<QUserData> getPlayers() {
		return players;
	}

	public void setPlayers(List<QUserData> players) {
		this.players = players;
	}
	
}
