package com.yt.framework.persistent.enums;

public class PlayerEnum {

	public enum PLAYERINFO{

		/**
		 * 左脚
		 */
		LFOOT("lfoot"),
		/**
		 * 左脚
		 */
		RFOOT("rfoot"),
		/**
		 * 均衡脚
		 */
		LRFOOT("lrfoot");
		
		private String key = "";

		private PLAYERINFO(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
}
