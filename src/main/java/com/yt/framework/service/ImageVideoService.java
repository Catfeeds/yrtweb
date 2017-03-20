package com.yt.framework.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *图片、视频
 *@autor bo.xie
 *@date2015-8-14下午3:17:54
 */
public interface ImageVideoService extends BaseService<ImageVideo>{

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
	public AjaxMsg getImageVideos(String group_id,Integer type,Integer role_type,PageModel<ImageVideo> pageModel);
	
	
	/**
	 * 获取用户所有的图片 或 视频
	 *@param user_id 用户ID
	 *@param type 1：图片 2：视频
	 *@param role_type 角色类型 1：球迷；2:球员；3:球队；4：经纪人；5教练人 可为空
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-14下午2:46:42
	 */
	public AjaxMsg getImageVideosByUserId(String user_id,Integer type,Integer role_type,PageModel<ImageVideo> pageModel);

	/**
	 * 获取用户所有的图片 或 视频
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午2:46:42
	 */
	public AjaxMsg hotImageVideos(Integer type);
	
	/**
	 * 获取热门的图片 或 视频
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午2:46:42
	 */
	public List<Map<String, Object>> hotImageVideosList(Integer type);

	/**
	 * 查询所有的图片 或 视频
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-09-03 下午2:46:42
	 */
	public AjaxMsg searchImageVideos(ImageVideo imageVideo, PageModel<ImageVideo>  pageModel);


	/**
	 * 查询用户拥有的栏位,剩余栏位
	 * @param userId 用户ID
	 * @param type image or video
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg restCount(String userId, String type);


	/**
	 * 批量上传图片
	 * @param imageVideo
	 * @param images
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg saveImgOrVideos(ImageVideo imageVideo, String images) throws Exception;
	
	public void saveVideo(ImageVideo imageVideo);
	public void saveImage(ImageVideo imageVideo);


	/**
	 * 改变在个人中心展示的图片或视频
	 * @param userId 用户ID
	 * @param id 图片ID
	 * @param type image or video
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg updateShowCenter(String userId, String id, String type,String state);


	/**
	 * 删除图片或视频
	 * @param parseLong
	 * @param type
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg deleteFile(String id, String type);
	
	/**
	 * 获取俱乐部，用户，足球宝贝所有的视频
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadAllVideos(Map<String,Object> maps,PageModel pageModel);
	
	/**
	 * 保存图片、视频评价
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveImageVideoComments(Map<String,Object> maps);
	
	/**
	 * 更新视频点击量
	 * @param maps
	 * @return
	 */
	public AjaxMsg updateImageVideoClickCount(Map<String,Object> maps);


	/**
	 * 查询视频评论
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryComments(Map<String, Object> params, PageModel pageModel);
	
	/**
	 * 查询联赛视频、图片评论
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryIVsLeagueComments(Map<String, Object> params, PageModel pageModel);
	
	public int queryCommentsCount(Map<String, Object> params);

	public List<Map<String, Object>> queryPraise(Map<String, Object> params);
	public List<String> praiseCount(Map<String, Object> params);
	/**
	 * 用户给图片或视频点赞或点踩
	 * @param params
	 * @return
	 */
	public AjaxMsg updatePraise(Map<String, Object> params);
	
	public ImageVideo getImageById(String id);
	
	public ImageVideo getVideoById(String id);
	/**
	 * 图片视频合并查询
	 * @param params
	 * @return
	 */
	public AjaxMsg queryViews(Map<String, Object> params, PageModel pageModel);
	
	
	/**
	 * 将本地图片上传到OSS上
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public boolean uploadFile2OSS(String ivId,String type,String filePath,String key) throws Exception;


	public void updateImgOrVideo2OSS(String ivId, String type,File uploadFile);

	/**
	 * 首页视频list
	 * @return
	 */
	public List<ImageVideo> queryIndexVideo();
}
