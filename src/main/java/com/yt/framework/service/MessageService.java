package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Message;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: MessageService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月11日 下午4:43:32 
 */
public interface MessageService extends BaseService<Message> {

	/**
	 * 用户处理系统消息
	 * @param msg
	 * @return AjaxMsg
	 */
	public AjaxMsg modifySystemMsg(Message msg, String submit)throws Exception;
	
	/**
	 * 查询发送信息的用户
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg queryMsgUser(String userId);

	/**
	 * 查询未读消息
	 * @param userId
	 * @return
	 */
	public AjaxMsg queryNotReadMsg(String userId);
	
	
	public AjaxMsg updateMsgState(String userId,String s_user_id,int state);
	
	/**
	 * 查询指定发送消息
	 * @param userId 
	 * @param s_user_id
	 * @param type
	 * @return
	 */
	public List<Message> queryPointToPointMsg(String user_id,String s_user_id,String type);
	
	
	/**
	 * <p>Description: 加载系统消息</p>
	 * @Author zhangwei
	 * @Date 2015年12月11日 下午3:20:09
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadAllSysMsgList(@Param(value="maps")Map<String,Object> maps,PageModel pageModel);
	
	
	
	public int loadAllSysMsgCount(@Param(value="maps")Map<String,Object> maps);
}
