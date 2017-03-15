package com.yt.framework.service.admin;

import java.util.Map;

import com.yt.framework.persistent.entity.DressResources;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: DressResourcesService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月17日 下午3:33:46 
 */
public interface DressResourcesBsService extends BaseService<DressResources>{

	/**
	 * 添加或修改皮肤属性
	 * @param role
	 * @return AjaxMsg
	 */
	public AjaxMsg saveOrUpdate(DressResources dres);

	public AjaxMsg queryResources(Map<String, Object> params,
			PageModel pageModel);

}
