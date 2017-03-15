package com.yt.framework.persistent.enums;
/**
 *
 *@autor bo.xie
 *@date2015-8-20下午2:07:52
 */
public class UserEnum {
	
	/**
	 * 用户类型
	 * @author bo.xie
	 */
	public enum ROLETYPE{
		/**
		 * 平台用户
		 */
		USER("user"),
		/**
		 * 俱乐部
		 */
		TEAM("team");
		
		private String key = "";

		private ROLETYPE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}

	public enum BINDTYPE{

		/**
		 * 绑定账号名称
		 */
		BINDNAME("bindname"),
		/**
		 * 绑定手机
		 */
		PHONE("phone"),
		/**
		 * 绑定邮箱
		 */
		EMAIL("email");
		
		private String key = "";

		private BINDTYPE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
}
