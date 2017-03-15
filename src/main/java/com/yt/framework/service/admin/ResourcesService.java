package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: ResourcesService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年7月23日 下午4:00:00 
 */
public interface ResourcesService {

	public AjaxMsg queryResources(Map<String, Object> params,PageModel pageModel);
	
	public int queryResourcesCount(Map<String, Object> params);
	
	public AjaxMsg saveOrUpdate(Resources resources,String flag);
	
	public AjaxMsg delete(String id);
	
	public List<Resources> queryParents();
	
	public Resources getResources(String id);

	public AjaxMsg getLastRes(String pval);
}
