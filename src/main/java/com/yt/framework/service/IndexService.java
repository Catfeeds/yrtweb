package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.IndexBanner;
import com.yt.framework.persistent.entity.IndexModel;
import com.yt.framework.persistent.entity.News;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 首页功能
 * @author gl
 *
 */
public interface IndexService {

	
	/**
	 * 首页讯息
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryNews(Map<String, Object> params,PageModel pageModel);

	/**
	 * 查询讯息详情
	 * @param nid
	 * @return
	 */
	public News getNewsById(String nid);
	
	/**
	 * 查询首页视频列表
	 * @param nid
	 * @return
	 */
	public AjaxMsg queryImageOrVideos(Map<String, Object> params,PageModel pageModel);
	
	/**
	 * 添加栏位
	 * @param type
	 * @return
	 */
	public AjaxMsg saveField(String type);

	/**
	 * 删除栏位
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteField(String id);
	/**
	 * 添加栏位值
	 * @param iid
	 * @param ivid
	 * @param type
	 * @return
	 */
	public AjaxMsg saveFieldValue(IndexModel index);

	/**
	 * 添加栏位值
	 * @param iid
	 * @param ivid
	 * @param type
	 * @return
	 */
	public AjaxMsg updateFieldValue(IndexModel index);

	/**
	 * 查询首页宝贝
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryBabys(Map<String, Object> params, PageModel pageModel);

	/**
	 * 查询所有宝贝
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryAllBabys(Map<String, Object> params, PageModel pageModel);

	/**
	 * 查询首页球员
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryPlayers(Map<String, Object> params, PageModel pageModel);

	/**
	 * 查询所有球员
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryAllPlayers(Map<String, Object> params,
			PageModel pageModel);

	public AjaxMsg queryTeamPlayers(Map<String, Object> params,
			PageModel pageModel);

	/**
	 * 首页banner
	 * @param params
	 * @param pageModel
	 * @return
	 */
	List<Map<String, Object>> queryIndexBanners(Map<String, Object> params);
	public AjaxMsg queryIndexBanners(Map<String, Object> params, PageModel pageModel);
	public AjaxMsg saveIndexBanner(IndexBanner indexBanner) throws Exception;
	public AjaxMsg updateIndexBanner(IndexBanner indexBanner) throws Exception;
	public AjaxMsg deleteIndexBanner(String id);
	public IndexBanner getIndexBannerById(String id);


}
