package com.yt.framework.persistent.enums;
/**
 *俱乐部相关信息枚举类
 *@autor bo.xie
 *@date2015-7-24下午1:45:50
 */
public class TeamEnum {
	
	/**
	 * 俱乐部成员
	 * @author bo.xie
	 *
	 */
	public enum ROLETYPE{
		/**
		 * 射手榜
		 */
		SHOOTER("shooter"),
		/**
		 * 出场榜
		 */
		STAGE("stage"),
		/**
		 * 前场
		 */
		FRONT("front"),
		/**
		 * 中场
		 */
		MIDFIELD("midfield"),
		/**
		 * 后场
		 */
		BACK("back"),
		/**
		 * 守门员
		 */
		GATE("gate"),
		/**
		 * 宝贝
		 */
		BABY("baby");
		
		private String key = "";

		private ROLETYPE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}

	/**
	 * 排序类型
	 */
	public enum ORDERTYPE {
		/**
		 * 按名称排序
		 */
		N("N"),
		/**
		 * 按积分排序
		 */
		J("J"),
		/**
		 * 按战绩排序
		 */
		Z("Z"),
		/**
		 * 按进球数排序
		 */
		B("B");
		
		private String key = "";

		private ORDERTYPE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
	
}
