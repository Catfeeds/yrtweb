package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.utils.AjaxMsg;

/**
 *图片、视频保存
 *@autor bo.xie
 *@date2015-8-14下午2:18:49
 */
public interface ImageVideoMapper extends BaseMapper<ImageVideo> {

	/**
	 * 获取分组下所有图片 或视频
	 *@param group_id 分组ID
	 *@param type 1：图片 2：视频
	 *@param role_type 角色类型 1：球迷；2:球员；3:球队；4：经纪人；5教练人 可为空
	 *@param 分页条件
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-14下午2:30:48
	 */
	public List<ImageVideo> getImageVideos(@Param(value="group_id")String group_id,@Param(value="type")int type
			,@Param(value="role_type")int role_type,@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取分组下所有图片 或视频总数
	 *@param group_id 分组ID
	 *@param type 1：图片 2：视频
	 *@param role_type 角色类型 1：球迷；2:球员；3:球队；4：经纪人；5教练人 可为空
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-14下午3:10:35
	 */
	public int getImageVideosCount(@Param(value="group_id")String group_id,@Param(value="type")int type,@Param(value="role_type")int role_type);
	
	/**
	 * 获取用户所有的图片 或 视频
	 *@param user_id 用户ID
	 *@param type 1：图片 2：视频
	 *@param role_type 角色类型 1：球迷；2:球员；3:球队；4：经纪人；5教练人 可为空
	 *@param maps 分页条件
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-14下午2:46:42
	 */
	public List<ImageVideo> getImageVideosByUserId(@Param(value="user_id")String user_id,@Param(value="type")int type
			,@Param(value="role_type")int role_type,@Param(value="maps")Map<String,Object> maps);

	/**
	 * 获取用户所有的图片 或 视频总数
	 *@param user_id 用户ID
	 *@param type 1：图片 2：视频
	 *@param role_type 角色类型 1：球迷；2:球员；3:球队；4：经纪人；5教练人 可为空
	 *@param maps 分页条件
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-14下午2:46:42
	 */
	public int getImageVideosByUserIdCount(@Param(value="user_id")String user_id,@Param(value="type")int type,@Param(value="role_type")int role_type);
	
	/**
	 * 获取用户所有的图片 或 视频
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-17下午2:46:42
	 */
	public List<Map<String, Object>> hotImageVideos(@Param(value="type")int type);
	
	/**
	 * 获取用户所有的图片 或 视频
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-09-03 下午2:46:42
	 */
	public List<Map<String, Object>> searchImageVideos(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取用户所有的图片 或 视频
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-09-03 下午2:46:42
	 */
	public int searchImageVideosCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取俱乐部，用户，足球宝贝所有的视频
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllVideos(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取俱乐部，用户，足球宝贝所有的视频总数
	 * @param maps
	 * @return
	 */
	public int loadAllVideosCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 保存视频图片评论
	 * @param maps
	 */
	public void saveImageVideoComments(@Param(value="maps")Map<String,Object> maps);
	
	public void updateImageVideoClickCount(@Param(value="maps")Map<String,Object> maps);

	public List<Map<String, Object>> queryComments(@Param(value="maps")Map<String, Object> params);

	public int queryCommentsCount(@Param(value="maps")Map<String, Object> params);

	/**
	 * 踩或赞的的数量
	 * @param userId
	 * @return
	 */
	public List<String> praiseCount(Map<String, Object> params);
	
	/**
	 * 查询是否已经给视频点过赞或踩
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryPraise(Map<String, Object> params);
	
	/**
	 * 视频点赞
	 * @param params
	 * @return
	 */
	public int savePraise(Map<String, Object> params);
	/**
	 * 用户取消视频点赞
	 * @param params
	 * @return
	 */
	public int deletePraise(Map<String, Object> params);

	/**
	 * 保存图片
	 * @param imageVideo
	 */
	public void saveImage(ImageVideo imageVideo);

	/**
	 * 保存视频
	 * @param imageVideo
	 */
	public void saveVideo(ImageVideo imageVideo);

	/**
	 * 根据Id获取图片
	 * @param id
	 * @return
	 */
	public ImageVideo getImageById(@Param(value="id")String id);
	/**
	 * 根据Id获取视频
	 * @param id
	 * @return
	 */
	public ImageVideo getVideoById(@Param(value="id")String id);
	/**
	 * 根据Id删除图片
	 * @param id
	 * @return
	 */
	public void deleteImage(String id);
	/**
	 * 根据Id删除视频
	 * @param id
	 * @return
	 */
	public void deleteVideo(String id);
	
	/**
	 * 图片视频合并查询
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryViews(@Param(value="maps")Map<String, Object> params);
	public int queryViewsCount(@Param(value="maps")Map<String, Object> params);

	/**
	 * 删除图片或视频所有点赞
	 * @param id
	 */
	public void deleteAllPraise(@Param(value="ivid")String id);

	/**
	 * 删除图片或视频所有评论
	 * @param id
	 */
	public void deleteAllComment(@Param(value="ivid")String id);

	public void updateImgOrVideo2OSS(@Param(value="ivId")String ivId, @Param(value="type")String type);
}
