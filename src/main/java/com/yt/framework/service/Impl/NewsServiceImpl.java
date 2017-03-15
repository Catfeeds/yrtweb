package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.News;
import com.yt.framework.service.NewsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service("newsService")
public class NewsServiceImpl extends BaseServiceImpl<News>implements NewsService {
	protected static Logger logger = LogManager.getLogger(NewsServiceImpl.class);

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg loadAllNews(Map<String, Object> maps, PageModel pageModel) {
		int totalCount = newsMapper.loadAllNewsCount(maps);
		pageModel.setTotalCount(totalCount);
		maps.put("start", pageModel.getFirstNum());
		maps.put("rows", pageModel.getPageSize());
		List<Map<String,Object>> news = newsMapper.loadAllNews(maps);
		pageModel.setItems(news);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}


}
