package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Comment;
import com.yt.framework.persistent.entity.Dynamic;
import com.yt.framework.persistent.entity.DynamicMsg;
import com.yt.framework.persistent.entity.TeamDynamic;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: DynamicService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月10日 上午11:57:21 
 */
public interface DynamicService extends BaseService<Dynamic>{

	/**
	 * 查询动态
	 * @param params
	 * @param pageModel
	 * @return AjaxMsg
	 */
	public AjaxMsg queryComments(Map<String, Object> params, PageModel pageModel);

	/**
	 * 动态总条数
	 * @param params
	 * @return int 
	 */
	public int commentCount(Map<String, Object> params);

	/**
	 * 回复动态
	 * @param comment
	 * @return AjaxMsg
	 */
	public AjaxMsg replyComment(Comment comment);
	
	/**
	 * 动态查询
	 * @param params
	 * @param pageModel
	 * @return AjaxMsg
	 */
	public AjaxMsg queryDynamics(Map<String, Object> params, PageModel pageModel);
	
	/**
	 * 删除动态 假删
	 * @param did
	 * @return AjaxMsg
	 */
	public AjaxMsg deleteDynamic(String did);

	/**
	 * 查询自己的动态
	 * @param params
	 * @param pageModel
	 * @return AjaxMsg
	 */
	public AjaxMsg queryMyDynamic(Map<String, Object> params, PageModel pageModel);
	
	/**
	 * 查询最新的动态
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryNewDynamic(Map<String, Object> params, PageModel pageModel);

	/**
	 * 统计关注人数，被关注人数，动态数
	 * @param userId
	 * @return AjaxMsg
	 */
	public AjaxMsg dynCount(String userId);

	/**
	 * 对动态点赞
	 * @param params
	 * @return AjaxMsg
	 */
	public AjaxMsg savePraiseDyn(Map<String, Object> params) throws Exception;

	/**
	 * 首页动态查询
	 * @return AjaxMsg
	 */
	public AjaxMsg queryHotDynamic();

	/**
	 * 首页俱乐部动态查询List
	 * @autor ylt
	 * @parameter *
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>>  queryHotTeamDynamicList(Map<String,Object> maps);
	
	/**
	 * 首页俱乐部动态总数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午3:54:40
	 */
	public int queryHotTeamDynamicCount(Map<String,Object> maps);
	
	/**
	 * 首页动态查询List
	 *@autor ylt
	 *@parameter *
	 *@return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> queryHotDynamicList(Map<String,Object> maps);
	
	/**
	 *首页动态总数
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午3:39:55
	 */
	public int queryHotDynamicCount(Map<String,Object> maps);

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
	public List<DynamicMsg> queryTopDynamics(int size);
	
	/**
	 * 获取俱乐部最新动态信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg queryNewTeamDynamic(Map<String,Object> maps,PageModel pageModel);

	public List<DynamicMsg> queryDynamicsDef(Map<String, Object> params);

	public List<DynamicMsg> findNewMsg(Map<String, Object> params);
	
	public List<String> findMyFocus(String userid);
	
	public DynamicMsg transformationDynamic(Dynamic dy);
}
