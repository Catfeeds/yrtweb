package com.yt.framework.persistent.enums;

/**
 * 用户系统消息
 * @Title: SystemEnum.java 
 * @Package com.yt.framework.persistent.enums
 * @author GL
 * @date 2015年8月11日 下午4:07:06 
 */
public class SystemEnum {

	/**
	 * 系统消息类型
	 */
	public enum SYSTYPE {
		/**
		 * 球员申请与经纪人签约
		 */
		PTAQ("ptaq"),
		/**
		 * 球员申请与经纪人解约
		 */
		PTAJ("ptaj"),
		/**
		 * 经纪人申请与球员签约
		 */
		ATPQ("atpq"),
		/**
		 * 经纪人申请与球员解约
		 */
		ATPJ("atpj"),
		/**
		 * 俱乐部邀请用户加入
		 */
		TTPA("ttpa"),
		/**
		 * 用户被移出俱乐部
		 */
		TTPD("ttpd"),
		/**
		 * 用户被指派为队长/副队长
		 */
		LEADER("leader"),
		/**
		 * 邀请试训
		 */
		TRIAL("trial"),
		/**
		 * 球员加入俱乐部
		 */
		INTEAM("inTeam"),
		/**
		 * 球员退出俱乐部
		 */
		OUTTEAM("outTeam"),
		/**
		 * PK邀请
		 */
		IPK("ipk"),
		/**
		 * 俱乐部同意PK
		 */
		TAPK("tapk"),
		/**
		 * 俱乐部拒绝PK
		 */
		TCPK("tcpk"),
		/**
		 * 俱乐部上传比赛比分
		 */
		TSCORE("tscore"),
		/**
		 * 俱乐部同意比分
		 */
		TASCORE("tascore"),
		/**
		 * 俱乐部不同意比分
		 */
		TCSCORE("tcscore"),
		/**
		 * 系统公告
		 */
		SYSTEM("system"),
		/**
		 * 关注信息
		 */
		FOCUS("focus"),
		/**
		 * 私信
		 */
		PRIVATE("private"),
		/**
		 * 宝贝退出俱乐部
		 */
		BBOUT("bbout"),
		/**
		 * 购买球员失败
		 */
		BUYFALSE("buyfalse"),
		/**
		 * 租借申请同意
		 */
		LOANTRUE("loantrue"),
		/**
		 * 租借申请拒绝
		 */
		LOANFALSE("loanfalse");
		private String key = "";

		private SYSTYPE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
	
	/**
	 * 信息类型
	 * @author bo.xie
	 * 2015年8月19日11:15:54
	 */
	public enum MSGTYPE{
		
		/**
		 * 用户
		 */
		USER("USER"),
		/**
		 * 首页推送
		 */
		INDEX("index");
		
		
		private String key = "";

		private MSGTYPE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
	
	public enum IMAGE{
		
		/**
		 * 用户
		 */
		USER("USER"),
		/**
		 * 球员
		 */
		PLAYER("PLAYER"),
		/**
		 * 经纪人
		 */
		AGENT("AGENT"),
		/**
		 * 教练
		 */
		COACH("COACH"),
		/**
		 * 宝贝
		 */
		BABY("BABY"),
		/**
		 * 俱乐部
		 */
		TEAM("TEAM"),
		/**
		 * 联赛
		 */
		LEAGUE("LEAGUE");
		
		
		private String key = "";

		private IMAGE(String key) {
			this.key = key;
		}

		@Override
		public String toString() {
			return this.key;
		}
	}
}
