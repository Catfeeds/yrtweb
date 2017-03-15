package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ImageVideoTeam;
import com.yt.framework.utils.AjaxMsg;

/**
 *联赛图片、视频保存
 *@autor gl
 *@date2015-8-14下午2:18:49
 */
public interface ImageVideoLeagueMapper extends BaseMapper<ImageVideoTeam> {

	/**
	 * 查询所有联赛图片
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllLeaguePhotos(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 查询所有联赛图片总数
	 * @param maps
	 * @return
	 */
	public int getAllLeaguePhotosCount(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 查询所有图片或视频评论
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadAllIvComments(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 查询所有图片或视频评论
	 * @param maps
	 * @return
	 */
	public int loadAllIvCommentsCount(@Param(value="maps")Map<String,Object>maps);
	
}
