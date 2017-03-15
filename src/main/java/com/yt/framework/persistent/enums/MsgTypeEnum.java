package com.yt.framework.persistent.enums;

/**
 * 推送信息类型
 * @author ylt
 * 2015年8月10日16:36:58
 */
public class MsgTypeEnum {
	
	/**
	 * 推送信息类型
	 */
	public enum RecordType {
		/**
		 * 信息变更
		 */
		MSGCHANGE("msgchange"),
		/**
		 * 比赛预告
		 */
		TEAMNOTICE("teamnotice"),
		
		/**
		 * 比赛结果
		 */
		TEAMRESULT("teamresult"),
		
		/**
		 * 比赛结果
		 */
		TEAMINFO("teaminfo");
		
		private String key = "";

		private RecordType(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
}
