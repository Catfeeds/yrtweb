package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.admin.ResourcesMapper;
import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.service.admin.ResourcesService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service(value="resourcesService")
public class ResourcesServiceImpl implements ResourcesService{
	
	protected static Logger logger = LogManager.getLogger(ResourcesServiceImpl.class);
	
	@Autowired
	private ResourcesMapper resourcesMapper;

	@Override
	public AjaxMsg queryResources(Map<String, Object> params,
			PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = queryResourcesCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = resourcesMapper.queryResources(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public int queryResourcesCount(Map<String, Object> params) {
		return resourcesMapper.queryResourcesCount(params);
	}

	@Override
	public AjaxMsg saveOrUpdate(Resources resources,String flag) {
		Resources res = getResources(resources.getRes_id());
		int num = 0;
		if(res!=null&&"2".equals(flag)){
			num = resourcesMapper.update(resources);
		}else if(res==null&&"1".equals(flag)){
			num = resourcesMapper.save(resources);
		}else{
			return AjaxMsg.newError().addMessage("资源ID重复");
		}
		if(num>0){
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg delete(String id) {
		int num = resourcesMapper.delete(id);
		if(num>0){
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<Resources> queryParents() {
		return resourcesMapper.queryParents();
	}

	@Override
	public Resources getResources(String id) {
		return resourcesMapper.getResources(id);
	}

	@Override
	public AjaxMsg getLastRes(String pval) {
		if(StringUtils.isBlank(pval)){
			pval = null;
		}
		Resources res =resourcesMapper.getLastRes(pval); 
		return AjaxMsg.newSuccess().addData("res", res);
	}

}
