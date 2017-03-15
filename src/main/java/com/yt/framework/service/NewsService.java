package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.persistent.entity.News;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 联赛新闻
 * @author bo.xie
 *
 */
public interface NewsService extends BaseService<News> {

	/**
	 * 获取所有新闻信息
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg loadAllNews(Map<String,Object> maps,PageModel pageModel);
}
