package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.IndexBanner;
import com.yt.framework.persistent.entity.IndexModel;
import com.yt.framework.persistent.entity.News;

/**
 * 首页mapper
 * @author gl
 *
 */
public interface IndexMapper {

	public List<Map<String, Object>> queryNews(@Param(value="maps")Map<String, Object> params);

	public int newsCount(@Param(value="maps")Map<String, Object> params);

	public News getNewsById(@Param(value="nid")String nid);

	/**
	 * 首页图片视频
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryImagesOrVideos(@Param(value="maps")Map<String, Object> params);

	/**
	 * 首页图片视频
	 * @param params
	 * @return
	 */
	public int imagesOrVideosCount(@Param(value="maps")Map<String, Object> params);

	/**
	 * 根据type查询最后一个栏位
	 * @param type
	 * @return
	 */
	public IndexModel getIndexBySortDesc(@Param(value="type")String type);

	public int saveField(IndexModel im);

	public int deleteField(@Param(value="id")String id);

	/**
	 * 添加栏位值
	 * @param id 栏位id
	 * @param vid 值
	 * @param type image video player baby
	 * @return
	 */
	public int updateFieldValue(IndexModel index);

	public List<Map<String, Object>> queryBabys(@Param(value="maps")Map<String, Object> params);

	public int babysCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryAllBabys(@Param(value="maps")Map<String, Object> params);

	public int allBabysCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryPlayers(@Param(value="maps")Map<String, Object> params);

	public int playersCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryAllPlayers(@Param(value="maps")Map<String, Object> params);

	public int allPlayersCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryTeamPlayers(@Param(value="maps")Map<String, Object> params);

	public int teamPlayersCount(@Param(value="maps")Map<String, Object> params);

	public int queryIndexBannerCount(@Param(value="maps")Map<String, Object> params);

	public List<Map<String, Object>> queryIndexBanners(@Param(value="maps")Map<String, Object> params);
	
	public void saveIndexBanner(IndexBanner indexBanner);
	public void updateIndexBanner(IndexBanner indexBanner);
	public void deleteIndexBanner(@Param(value="id")String id);
	public IndexBanner getIndexBannerById(@Param(value="id")String id);
}
