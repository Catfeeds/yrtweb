package com.yt.framework.persistent.enums;

/**
 * 资金
 * @author bo.xie
 * 2015年8月10日16:36:58
 */
public class AmountEnum {
	
	/**
	 * 充值渠道
	 */
	public enum PayType {
		/**
		 * 支付宝
		 */
		ZHIFUBAO("ZHIFUBAO"),
		/**
		 * 银联
		 */
		YINLIAN("YINLIAN");

		private String key = "";

		private PayType(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
	
	/**
	 * 充值方式
	 */
	public enum WayType {
		/**
		 * 线上充值
		 */
		ONLINE("ONLINE"),
		/**
		 * 平台账户
		 */
		ONSITE("ONSITE"),
		/**
		 * 线下充值
		 */
		OFFLINE("OFFLINE");
		
		private String key = "";
		
		private WayType(String key) {
			this.key = key;
		}
		
		@Override
		public String toString() {
			return this.key;
		}
	}
	
}
