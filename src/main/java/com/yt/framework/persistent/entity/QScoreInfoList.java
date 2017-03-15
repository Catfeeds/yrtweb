package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * <p>
 * 接口赛事进球数据统计对象
 * <p>
 * 
 * @author gl
 * @Date 2015年12月24日 下午5:10:15
 * @version
 */
public class QScoreInfoList implements Serializable{

	private static final long serialVersionUID = 1L;
	private List<QScoreInfo> scores;
	public List<QScoreInfo> getScores() {
		return scores;
	}
	public void setScores(List<QScoreInfo> scores) {
		this.scores = scores;
	}
	
}
