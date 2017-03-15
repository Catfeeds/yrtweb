package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.ImageVideoLeague;
import com.yt.framework.service.ImageVideoLeagueService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service("imageVideoLeagueService")
public class ImageVideoLeagueServiceImpl extends BaseServiceImpl<ImageVideoLeague>implements ImageVideoLeagueService {
	
	protected static Logger logger = LogManager.getLogger(ImageVideoLeagueServiceImpl.class);

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadAllLeaguePhotosVideos(Map<String, Object> maps,PageModel pageModel) {
//		params.put("start",pageModel.getFirstNum());
//		params.put("rows",pageModel.getPageSize());
		if(pageModel!=null){
			maps.put("start",pageModel.getFirstNum());
			maps.put("rows",pageModel.getPageSize());
		int	totalCount = imageVideoLeagueMapper.getAllLeaguePhotosCount(maps);
			pageModel.setTotalCount(totalCount);
		}else{
			pageModel = new PageModel();
		}
		List<Map<String,Object>> photos = imageVideoLeagueMapper.loadAllLeaguePhotos(maps);
		pageModel.setItems(photos);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

}
