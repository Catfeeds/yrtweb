package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.persistent.entity.ImageVideoLeague;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 联赛视频
 * @author bo.xie
 *
 */
public interface ImageVideoLeagueService extends BaseService<ImageVideoLeague> {

	/**
	 * 查询所有联赛图片或视频
	 * @param maps
	 * 
	 * @return
	 */
	public AjaxMsg loadAllLeaguePhotosVideos(Map<String,Object>maps,PageModel pageModel);
	
}
