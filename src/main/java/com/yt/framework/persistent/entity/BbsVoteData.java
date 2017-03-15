package com.yt.framework.persistent.entity;

import java.io.Serializable;

/**
 * 论坛投票选项
 * @author ylt
 *
 */
public class BbsVoteData implements Serializable {
	private static final long serialVersionUID = 7502564876131038330L;
	private String id;
	private String vote_id; //投票id
	private String name;//投票选项名称
	private int sort;//排序
	private int vote_count;//投票数
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getVote_id() {
		return vote_id;
	}
	public void setVote_id(String vote_id) {
		this.vote_id = vote_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getVote_count() {
		return vote_count;
	}
	public void setVote_count(int vote_count) {
		this.vote_count = vote_count;
	}
	
}
