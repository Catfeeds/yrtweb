package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.News;
import com.yt.framework.service.admin.AdminNewsService;
import com.yt.framework.utils.AjaxMsg;

@Service(value="amdinNewsService")
public class AdminNewsServiceImpl extends BaseAdminServiceImpl<News> implements AdminNewsService {
	
	protected static Logger logger = LogManager.getLogger(AdminNewsServiceImpl.class);

	@Override
	public List<Map<String, Object>> queryTeamInfoByNid(String newsId) {
		return newsMapper.queryTeamInfoByNid(newsId);
	}

	@Override
	public AjaxMsg saveNewsTeam(String newsId,
			List<Map<String, Object>> newsteams) {
		newsMapper.deleteNewsTeam(newsId);
		if(newsteams!=null&&newsteams.size()>0){
			for (Map<String, Object> map : newsteams) {
				newsMapper.saveNewsTeam(map);
			}
		}
		return AjaxMsg.newSuccess();
	}

}
