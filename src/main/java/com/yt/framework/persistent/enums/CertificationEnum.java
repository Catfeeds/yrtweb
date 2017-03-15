package com.yt.framework.persistent.enums;
/**
 *
 *@autor bo.xie
 *@date2015-8-25上午11:43:45
 */
public class CertificationEnum {

	public enum CerType{
		
		/**
		 * 职业球员认证
		 */
		PROFESSIONAL("professional"),
		/**
		 * 身份证认证
		 */
		IDCARD("idcard");

		private String key = "";

		private CerType(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
}
