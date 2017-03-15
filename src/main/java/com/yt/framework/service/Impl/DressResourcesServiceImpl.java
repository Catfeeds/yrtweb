package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.DressResources;
import com.yt.framework.service.DressResourcesService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: DressResourcesServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月17日 下午3:33:33 
 */
@Service(value="dressResourcesService")
public class DressResourcesServiceImpl extends BaseServiceImpl<DressResources> implements DressResourcesService{
	
	protected static Logger logger = LogManager.getLogger(DressResourcesServiceImpl.class);

	@Override
	public AjaxMsg queryMyDressRes(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = dressResourcesMapper.dresCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = dressResourcesMapper.queryMyDressRes(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public AjaxMsg updateDress(String userId, String dr_id) {
		String errorMsg="";
		if(StringUtils.isNotBlank(userId)&&StringUtils.isNotBlank(dr_id)){
			DressResources dr = dressResourcesMapper.getEntityById(dr_id);
			if(dr!=null){
				dressupMapper.updateDressupStatusOff(userId);
				dressupMapper.updateDressupStatusOn(userId,dr_id);
				return AjaxMsg.newSuccess();
			}else{
				errorMsg = "该皮肤不存在";
			}
		}
		return AjaxMsg.newError();
	}

}
