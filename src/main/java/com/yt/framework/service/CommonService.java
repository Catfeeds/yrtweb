package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.IvComment;
import com.yt.framework.persistent.entity.MsgHistory;
import com.yt.framework.persistent.entity.PageCount;
import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.persistent.entity.UserComment;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: DynamicService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月10日 上午11:57:21 
 */
public interface CommonService {

	/**
	 * 图片视频评论查询
	 * @param params
	 * @return List<Map<String, Object>>
	 */
	public AjaxMsg queryIvComments(Map<String, Object> params, PageModel pageModel);

	/**
	 * 图片视频评论总条数
	 * @param params
	 * @return int
	 */
	public int ivCommentCount(Map<String, Object> params);

	/**
	 * 评论视屏图片
	 * @param comment
	 */
	public AjaxMsg replyIvComment(IvComment comment);

	/**
	 * 对图片会视频点赞
	 * @param userId 用户ID
	 * @param ivId 图片或视频ID
	 */
	public AjaxMsg savePraiseIv(Map<String, Object> params) throws Exception;


	/**
	 * 获取首页动态图片
	 * @return
	 */
	public List<Map<String, Object>> queryIndexImages();
	
	
	/**
	 * 保存短信和右键发送记录
	 * @param msgHistory
	 * @return
	 */
	public AjaxMsg saveMsgHistory(MsgHistory msgHistory);
	
	/**
	 * 用户评论
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryUserComments(Map<String, Object> params,PageModel pageModel);
	/**
	 * 评论的评论
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryUserCommentChilds(Map<String, Object> params,PageModel pageModel);
	
	/**
	 * 保存用户评论
	 * @param comment
	 * @return
	 */
	public AjaxMsg saveUserComment(UserComment comment,String type) throws Exception;
	
	/**
	 * 删除用户评论
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteUserComment(String id);
	
	/**
	 * 保存页面访问统计量
	 * @param pageCount
	 */
	public AjaxMsg savePageCount(PageCount pageCount);
	
	/**
	 * 统计该用户页面被访问总次数
	 * @param user_id 受访者用户ID
	 * @param code_str
	 * @return
	 */
	public int getPageCount(@Param(value="user_id")String user_id,@Param("code_str")String code_str);
}
