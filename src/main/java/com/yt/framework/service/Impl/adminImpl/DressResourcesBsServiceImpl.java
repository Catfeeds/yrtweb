package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.DressResources;
import com.yt.framework.service.Impl.BaseServiceImpl;
import com.yt.framework.service.admin.DressResourcesBsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * @Title: DressResourcesServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月17日 下午3:33:33 
 */
@Service(value="dressResourcesBsService")
public class DressResourcesBsServiceImpl extends BaseServiceImpl<DressResources> implements DressResourcesBsService{
	
	protected static Logger logger = LogManager.getLogger(DressResourcesBsServiceImpl.class);

	@Override
	public AjaxMsg saveOrUpdate(DressResources dres) {
		if(dres!=null){
			String id = dres.getId();
			if(StringUtils.isNotBlank(id)){
				dressResourcesMapper.update(dres);
			}else{
				dres.setId(UUIDGenerator.getUUID());
				dressResourcesMapper.save(dres);
			}
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryResources(Map<String, Object> params,
			PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = dressResourcesMapper.queryCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = dressResourcesMapper.queryResources(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}


}
