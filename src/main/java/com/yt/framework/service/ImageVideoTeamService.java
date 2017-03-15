package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.persistent.entity.ImageVideoTeam;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: ImageVideoTeamService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年9月8日 下午5:35:18 
 */
public interface ImageVideoTeamService extends BaseService<ImageVideoTeam> {

	/**
	 * 查询俱乐部图片或视频
	 * @param params
	 * @param pageModel
	 * @return AjaxMsg
	 */
	public AjaxMsg searchImageVideos(Map<String, Object> params, PageModel pageModel);

	/**
	 * 查询俱乐部图片或视频总条数
	 * @param params
	 * @return int
	 */
	public int searchImageVideosCount(Map<String, Object> params);

	/**
	 * 批量上传图片
	 * @param imageVideo
	 * @param images
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg saveImgOrVideos(ImageVideoTeam imageVideo, String images);

	/**
	 * 删除图片或视频
	 * @param parseLong
	 * @param type
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg deleteFile(String id, String type);
	
	/**
	 * 查询用户拥有的栏位,剩余栏位
	 * @param teamId 俱乐部ID
	 * @param type image or video
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg teamRestCount(String teamId, String type);
	
	/**
	 * 改变在个人中心展示的图片或视频
	 * @param teamId 俱乐部ID
	 * @param id 图片ID
	 * @param type image or video
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg updateShowCenter(String teamId, String id, String type,String state);

}
