package com.yt.framework.service.admin;

import com.yt.framework.persistent.entity.LeagueScorer;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

/**
 * @author gl
 *
 */
public interface AdminLeagueScorerService extends BaseService<LeagueScorer>{

	public AjaxMsg updateScorer(String league_id) throws Exception; 

}
