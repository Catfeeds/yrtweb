package com.yt.framework.utils;

import java.util.List;

import com.yt.framework.utils.gson.JSONUtils;


public class PageUtil {
	List dataList = null;
	long recordCount = 0;
	String jsonStr = "[]";
	
	public PageUtil(List ls, long recordCount) {
		this.dataList = ls;
		this.jsonStr = JSONUtils.bean2json(ls);
		this.recordCount = recordCount;
	}
	public String toJson() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"totalCount\" : "+recordCount);
		sb.append(",\"result\" :");
		sb.append(jsonStr);
		sb.append("}");
		return sb.toString();
	}
	
	public List getDataList() {
		return dataList;
	}
	public void setDataList(List dataList) {
		this.dataList = dataList;
	}
	public long getRecordCount() {
		return recordCount;
	}
	public void setRecordCount(long recordCount) {
		this.recordCount = recordCount;
	}
	
	
}
