package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.IvComment;
import com.yt.framework.persistent.entity.MsgHistory;
import com.yt.framework.persistent.entity.PageCount;
import com.yt.framework.persistent.entity.UserComment;

/**
 * 公用Mapper
 * @Title: CommonMapper.java 
 * @Package com.yt.framework.mapper
 * @author GL
 * @date 2015年8月11日 下午2:31:14 
 */
public interface CommonMapper {

	/**
	 * 图片视频评论查询
	 * @param params
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> queryIvComments(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 图片视频评论总条数
	 * @param params
	 * @return int
	 */
	public int ivCommentCount(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 评论图片视频评论
	 * @param comment
	 * @return int
	 */
	public int replyIvComment(IvComment comment);

	/**
	 * 图片视频点赞
	 * @param parseLong
	 * @return int
	 */
	public int praiseIv(@Param(value="ivId")String ivId);

	/**
	 * 获取首页动态图片
	 * @return
	 */
	public List<Map<String, Object>> queryIndexImages();

	/**
	 * 保存图片点赞帐号
	 * @param params
	 * @return int
	 */
	public int savePraiseRecord(Map<String, Object> params);
	
	/**
	 * 根据用户ID和动态ID查询用户点赞信息
	 * @param params
	 * @return 
	 */
	public List<Map<String, Object>> queryPraiseRecord(Map<String, Object> params);
	
	/**
	 * 删除用户点赞
	 * @param params
	 * @return
	 */
	public int deletePraiseRecord(Map<String, Object> params);
	
	/**
	 * 保存短信和右键发送记录
	 * @param msgHistory
	 * @return
	 */
	public int saveMsgHistory(MsgHistory msgHistory);

	public List<Map<String, Object>> queryUserComments(@Param(value="maps")Map<String, Object> params);

	public int userCommentsCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryUserCommentChilds(@Param(value="maps")Map<String, Object> params);

	public int userCommentChildsCount(@Param(value="maps")Map<String, Object> params);

	public int saveUserComment(UserComment comment);

	public int deleteUserComment(@Param(value="id")String id);
	
	/**
	 * 保存页面访问统计量
	 * @param pageCount
	 */
	public void savePageCount(PageCount pageCount);
	
	/**
	 * 统计该用户页面被访问总次数
	 * @param user_id 受访者用户ID
	 * @param code_str
	 * @return
	 */
	public PageCount getPageCount(@Param(value="user_id")String user_id,@Param("code_str")String code_str);
	
	/**
	 * 更新统计次数
	 * @param pageCount
	 */
	public void updatePageCount(PageCount pageCount);
}
