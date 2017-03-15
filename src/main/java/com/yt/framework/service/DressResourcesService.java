package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.persistent.entity.DressResources;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: DressResourcesService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月17日 下午3:33:46 
 */
public interface DressResourcesService extends BaseService<DressResources>{

	/**
	 * 查询已拥有皮肤
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryMyDressRes(Map<String, Object> params, PageModel pageModel);

	public AjaxMsg updateDress(String userId, String dr_id);

}
