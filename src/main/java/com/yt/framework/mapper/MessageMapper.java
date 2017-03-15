package com.yt.framework.mapper;

import java.util.Map;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.MessageRecords;

/**
 * @Title: MessageMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月11日 下午4:41:41 
 */
public interface MessageMapper extends BaseMapper<Message>{

	/**
	 * 保存消息推送记录
	 *@param mr
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-18下午1:58:51
	 */
	public void saveMessageRecord(MessageRecords mr);

	/**
	 * 查询发送信息的用户
	 * @param userId
	 * @return AjaxMsg
	 */
	public List<Map<String, Object>> queryMsgUser(@Param(value="userId")String userId);

	public List<Message> queryMsg(@Param(value="userId")String userId, @Param(value="s_userId")String s_userId, @Param(value="type")String type);

	public int queryNotReadMsg(@Param(value="userId")String userId);

	/**
	 * 修改信息状态（0未读,1已读）
	 * @param userId
	 * @param state
	 */
	public void updateMsgState(@Param(value="userId")String userId,@Param(value="s_user_id")String s_user_id,@Param(value="state") int state);
	
	/**
	 * 查询指定发送消息
	 * @param userId 
	 * @param s_user_id
	 * @param type
	 * @return
	 */
	public List<Message> queryPointToPointMsg(@Param(value="user_id")String user_id,@Param(value="s_user_id")String s_user_id,@Param(value="type")String type);
	
	/**
	 * <p>Description: 加载系统消息</p>
	 * @Author zhangwei
	 * @Date 2015年12月11日 下午3:20:09
	 * @param maps
	 * @return
	 */
	public List<Map<String, Object>> loadAllSysMsgList(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * <p>Description: 加载系统消息总数</p>
	 * @Author zhangwei
	 * @Date 2015年12月11日 下午3:20:09
	 * @param maps
	 * @return
	 */
	public int loadSysMsgCount(@Param(value="maps")Map<String,Object> maps);
}
