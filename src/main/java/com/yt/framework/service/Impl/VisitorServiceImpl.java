package com.yt.framework.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.Visitor;
import com.yt.framework.service.VisitorService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 登陆访问用户操作
 *@autor ylt
 *@date2015-8-31下午2:09:06
 */
@Service(value="visitorService")
public class VisitorServiceImpl extends BaseServiceImpl<Visitor> implements VisitorService{
	
	protected static Logger logger = LogManager.getLogger(VisitorServiceImpl.class);
	
	@Override
	public AjaxMsg queryForPageList(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = Lists.newArrayList();
		List<Integer> visitCount = Lists.newArrayList();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = count(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = baseMapper.queryForPage(params);
			pageModel.setItems(datas);
			visitCount = visitorMapper.visitCount(params);
			return AjaxMsg.newSuccess().addData("page", pageModel).addData("visitCount", visitCount);
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public Visitor getVisitor(String visitor_id,String p_visitor_id,String visit_type) {
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("visitor_id",visitor_id);
		maps.put("p_visitor_id", p_visitor_id);
		maps.put("visit_type", visit_type);
		return visitorMapper.getVisitor(maps);
	}
	
}
