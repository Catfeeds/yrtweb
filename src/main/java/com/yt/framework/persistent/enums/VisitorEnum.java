package com.yt.framework.persistent.enums;
/**
 *
 *@autor ylt
 *@date2015-8-20下午2:07:52
 */
public class VisitorEnum {

	public enum VISTORTYPE{

		/**
		 * 个人中心
		 */
		CENTER("center"),
		/**
		 * 俱乐部
		 */
		CLUB("club"),
		/**
		 * 动态
		 */
		DYNAMIC("dynamic"),
		
		/**
		 * 广场
		 */
		SQUARE("square");
		
		
		private String key = "";

		private VISTORTYPE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
}
