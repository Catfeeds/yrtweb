package com.yt.framework.utils.queue;

import java.util.List;
import java.util.Map;

public class ApiplusVO {
	String rows;
	String code;
	String info;
	List<Map<String, String>> data;

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public List<Map<String, String>> getData() {
		return data;
	}

	public void setData(List<Map<String, String>> data) {
		this.data = data;
	}

}
