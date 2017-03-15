package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.admin.AdminTeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

@Service(value="adminTeamInfoService")
public class AdminTeamInfoServiceImpl extends BaseAdminServiceImpl<TeamInfo> implements AdminTeamInfoService {
	
	protected static Logger logger = LogManager.getLogger(AdminTeamInfoServiceImpl.class);

	@Override
	public AjaxMsg queryTeamLeagueForMap(Map<String, Object> maps, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = teamLeagueCount(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = teamInfoMapper.queryTeamLeagueForMap(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	private int teamLeagueCount(Map<String, Object> maps) {
		return teamInfoMapper.teamLeagueCount(maps);
	}

	@Override
	public AjaxMsg queryRecommendation(Map<String, Object> params,
			PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = teamInfoMapper.recommendationCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			datas = teamInfoMapper.queryRecommendation(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg saveRecommendation(String teamIds,String userId) {
		String tids[] = teamIds.split(",");
		if(tids!=null&&tids.length>0){
			for (String tid : tids) {
				Map<String, Object> rec = new HashMap<String,Object>();
				rec.put("id", UUIDGenerator.getUUID());
				rec.put("teaminfo_id", tid);
				rec.put("user_id", userId);
				teamInfoMapper.saveRecommendation(rec);
			}
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg updateRecommendation(Map<String, Object> maps) {
		teamInfoMapper.updateRecommendation(maps);
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg deleteRecommendation(String id) {
		teamInfoMapper.deleteRecommendation(id);
		return AjaxMsg.newSuccess();
	}

}
