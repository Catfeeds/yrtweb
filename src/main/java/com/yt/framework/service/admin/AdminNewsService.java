package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.News;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

/**
 * @author gl
 *
 */
public interface AdminNewsService extends BaseService<News>{

	public List<Map<String, Object>> queryTeamInfoByNid(String newsId);

	public AjaxMsg saveNewsTeam(String newsId, List<Map<String, Object>> newsteams); 

}
