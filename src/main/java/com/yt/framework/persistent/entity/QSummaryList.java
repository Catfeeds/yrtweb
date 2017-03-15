package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.List;

public class QSummaryList implements Serializable{

	private static final long serialVersionUID = 4235722289092199605L;
	private List<QSummaryInfo> summarys;
	public List<QSummaryInfo> getSummarys() {
		return summarys;
	}
	public void setSummarys(List<QSummaryInfo> summarys) {
		this.summarys = summarys;
	}

	
}
