package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Comment;
import com.yt.framework.persistent.entity.Dynamic;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.TeamDynamic;

/**
 * @Title: DynamicMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月10日 下午2:51:47 
 */
public interface DynamicMapper extends BaseMapper<Dynamic>{


	/**
	 * 查询动态评论
	 * @param params
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> queryComments(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 查询动态评论条数
	 * @param params
	 * @return int
	 */
	public int commentCount(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 回复动态
	 * @param comment
	 */
	public int replyComment(Comment comment);

	/**
	 * 自己动态总条数
	 * @param params
	 * @return int
	 */
	public int myDataCount(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 查询最新动态总条数
	 * @param maps
	 * @return
	 */
	public int newDataCount(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 自己动态查询
	 * @param params 
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> queryMyDynamic(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 最新动态查询
	 * @param maps
	 * @return
	 */
	public List<Map<String, Object>> queryNewDynamic(@Param(value="maps")Map<String, Object> maps);

	/**
	 * 统计关注人数，被关注人数，动态数
	 * @param userId
	 * @return AjaxMsg
	 */
	public List<String> dynCount(@Param(value="userId")String userId);

	/**
	 * 对动态点赞
	 * @param request
	 * @return AjaxMsg
	 */
	public int praiseDyn(@Param(value="dynId")String dynId,@Param(value="praise_count")int praise_count);

	/**
	 * 首页动态查询
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> queryHotDynamic(@Param(value="maps")Map<String,Object> maps);

	/**
	 *首页动态总数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午3:39:55
	 */
	public int queryHotDynamicCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 首页俱乐部动态查询
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> queryHotTeamDynamic(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 首页俱乐部动态总数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午3:54:40
	 */
	public int queryHotTeamDynamicCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取俱乐部最新动态信息
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> queryNewTeamDynamic(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取俱乐部最新动态总条数
	 * @param maps
	 * @return
	 */
	public int queryNewTeamDynamicCount(@Param(value="maps")Map<String,Object> maps);

	/**
	 * 删除动态 假删
	 * @param did
	 */
	public void deleteDynamic(@Param(value="dynId")String dynId);
	/**
	 * 保存俱乐部动态消息
	 * @param 
	 * @author ylt
	 * @date 2015年9月11日 下午4:41:41 
	 */
	public void saveTeamDynamic(TeamDynamic teamDynamic);
	
	

	/**
	 * 查询置顶动态
	 * YJH
	 * @param size
	 * @return
	 */
	public List<Dynamic> queryTopDynamics(int size);
	/**
	 * 
	 * @param maps
	 * @return
	 */
	public List<Dynamic> queryDynamicsDef(@Param(value="maps")Map<String,Object> maps);
	public List<Message> queryMessageDef(@Param(value="maps")Map<String,Object> maps);
	public List<TeamDynamic> queryTeamDynamicDef(@Param(value="maps")Map<String,Object> maps);
}
