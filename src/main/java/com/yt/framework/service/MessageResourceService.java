package com.yt.framework.service;

import org.springframework.web.context.WebApplicationContext;

import com.yt.framework.persistent.entity.Message;
import com.yt.framework.utils.AjaxMsg;

/**
 * @Title: 国际化文件操作
 * @Package com.yt.framework.service
 * @author ylt
 * @date 2015年9月15日 下午3:33:46 
 */
public interface MessageResourceService extends BaseService<Message>{
	public WebApplicationContext getWebApplicationContext();
	
	/**
	 * 保存个人动态消息（国际化消息模板内容）
	 *@param obj 国际化消息补充参数
	 *@param  type 国际化消息类型
	 *@param  user_id 用户动态
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public AjaxMsg saveUserDynamicMessage(Object []obj,String type,String user_id)throws Exception;
	
	/**
	 * 保存动态消息（国际化消息模板内容）
	 *@param obj 国际化消息补充参数
	 *@param  type 国际化消息类型
	 *@param  teamInfo_id 主队动态
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public AjaxMsg saveTeamDynamicMessage(Object []obj,String type,String teamInfo_id)throws Exception;
	
	/**
	 * 保存即时发送消息
	 *@param obj 国际化消息补充参数
	 *@param enumType 枚举判断类型
	 *@param type 国际化消息类型
	 *@param user_id 接收用户
	 *@param s_user_id 发送用户
	 *@param relate_id 消息关联对象id
	 *@param sys_type 系统消息类型 1：系统消息 2：个人消息 3：俱乐部消息
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public AjaxMsg saveMessage(Object[] obj,String enumType,String type,
			String user_id,String s_user_id,String relate_id,Integer sys_type) throws Exception;
	
	/**
	 * 保存即时发送消息(无需回复)
	 *@param obj 国际化消息补充参数
	 *@param type 国际化消息类型
	 *@param user_id 接收用户
	 *@param s_user_id 发送用户
	 *@param sys_type 系统消息类型 1：系统消息 2：个人消息 3：俱乐部消息
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public AjaxMsg saveMessageNoReply(Object[] obj,String type,String user_id,String s_user_id,Integer sys_type) throws Exception;
	
	/**
	 * 保存即时发送消息(无需回复,CN)
	 *@param obj 国际化消息补充参数
	 *@param type 国际化消息类型
	 *@param user_id 接收用户
	 *@param s_user_id 发送用户
	 *@param sys_type 系统消息类型 1：系统消息 2：个人消息 3：俱乐部消息
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public AjaxMsg saveCNMessageNoReply(Object[] obj,String type,String user_id,String s_user_id,Integer sys_type) throws Exception;
	
	
	/**
	 * 获取资源消息
	 * param type 消息类型
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public String getMessage(String type);
	
	/**
	 * 获取带参数的消息
	 * param type 消息类型
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public String getMessage(Object[] obj,String type);
	
	/**
	 * 保存个人动态消息（国际化消息模板内容）(无需回复,CN)
	 *@param obj 国际化消息补充参数
	 *@param  type 国际化消息类型
	 *@param  user_id 用户动态
	 *@autor ylt
	 *@date2015-8-11下午5:01:15
	 */
	public AjaxMsg saveCNUserDynamicMessage(Object[] obj, String type, String user_id)throws Exception;
}
