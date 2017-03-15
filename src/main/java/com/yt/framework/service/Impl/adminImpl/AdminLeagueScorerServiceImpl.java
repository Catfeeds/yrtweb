package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.EventRecord;
import com.yt.framework.persistent.entity.LeagueScorer;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.service.admin.AdminLeagueScorerService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;

@Service(value="adminLeaueScorerService")
public class AdminLeagueScorerServiceImpl extends BaseAdminServiceImpl<LeagueScorer> implements AdminLeagueScorerService {
	
	protected static Logger logger = LogManager.getLogger(AdminLeagueScorerServiceImpl.class);

	@Override
	public AjaxMsg updateScorer(String league_id) throws Exception {
		//查询该联赛下球员数据
		List<Map<String, Object>> users = leagueScorerMapper.queryQUserData(league_id);
		if(users!=null&&users.size()>0){
			for (Map<String, Object> user : users) {
				String group_id = user.get("group_id").toString();
				String user_id = user.get("rel_palyer_id").toString();
				String teaminfo_id = user.get("teaminfo_id").toString();
				String jinqiu_nums = user.get("jinqiu_nums").toString();
				String shemen_nums = user.get("shemen_nums").toString();
				String shezheng_nums = user.get("shezheng_nums").toString();
				String shangchang_num = user.get("shangchang_num").toString();
				if(Integer.parseInt(jinqiu_nums.substring(0,jinqiu_nums.indexOf(".")))>0){
					LeagueScorer ls = leagueScorerMapper.getLeagueScorer(league_id,group_id,user_id);
					int goal = Integer.parseInt(jinqiu_nums.substring(0,jinqiu_nums.indexOf(".")));
					int sm = Integer.parseInt(shemen_nums.substring(0,shemen_nums.indexOf(".")));
					int sz = Integer.parseInt(shezheng_nums.substring(0,shezheng_nums.indexOf(".")));
					int sc = Integer.parseInt(shangchang_num);
					if(ls!=null){
						ls.setGoal(goal);
						ls.setShemen_num(sm);
						ls.setShezheng_num(sz);
						ls.setShangchang_num(sc);
						ls.setTeam_id(teaminfo_id);
						update(ls);
					}else{
						ls = new LeagueScorer();
						ls.setId(UUIDGenerator.getUUID());
						ls.setLeague_id(league_id);
						ls.setGroup_id(group_id);
						ls.setUser_id(user_id);
						ls.setGoal(goal);
						ls.setShemen_num(sm);
						ls.setShezheng_num(sz);
						ls.setShangchang_num(sc);
						ls.setTeam_id(teaminfo_id);
						ls.setS_sort(0);
						save(ls);
					}
				}
			}
		}
		return AjaxMsg.newSuccess();
	}

}
