package com.yt.framework.service.admin;

import java.util.Map;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @author gl
 *
 */
public interface AdminTeamInfoService  extends BaseService<TeamInfo>{
	/**
	 * 获取联赛俱乐部分组信息
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryTeamLeagueForMap(Map<String, Object> params, PageModel pageModel);

	/**
	 * 获取推荐俱乐部
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryRecommendation(Map<String, Object> params,PageModel pageModel); 
	
	/**
	 * 添加推荐俱乐部
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveRecommendation(String tids,String userId);
	
	/**
	 * 修改推荐俱乐部
	 * @param maps
	 * @return
	 */
	public AjaxMsg updateRecommendation(Map<String, Object> maps);
	
	/**
	 * 删除推荐俱乐部
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteRecommendation(String id);

}
