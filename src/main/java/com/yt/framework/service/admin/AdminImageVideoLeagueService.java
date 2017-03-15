package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.ImageVideoLeague;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

/**
 * @author gl
 *
 */
public interface AdminImageVideoLeagueService extends BaseService<ImageVideoLeague>{ 

	public List<Map<String, Object>> queryTeamInfoByIvid(String ivid);
	
	public AjaxMsg saveIvTeam(String ivid,List<Map<String, Object>> ivTeams);

	public AjaxMsg updateLeague(ImageVideo ivleagues) throws Exception ;

	public AjaxMsg saveOrUpdateIv(ImageVideo ivleagues, String images,String teamIds) throws Exception;

	public AjaxMsg deleteFile(String id, String type);
	
}
