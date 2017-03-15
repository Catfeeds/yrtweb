package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.admin.FeedBackBsMapper;
import com.yt.framework.service.admin.FeedBackBsService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service(value="feedBackBsService")
public class FeedBackBsServiceImpl implements  FeedBackBsService{
	
	protected static Logger logger = LogManager.getLogger(FeedBackBsServiceImpl.class);
	
	@Autowired
	private FeedBackBsMapper feedBackBsMapper;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public AjaxMsg queryForPageForMap(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = count(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = feedBackBsMapper.queryForPageForMap(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public int count(Map<String, Object> params) {
		return feedBackBsMapper.count(params);
	}

	@Override
	public AjaxMsg changeStatus(String id) {
		if(StringUtils.isNotBlank(id)){
			feedBackBsMapper.changeStatus(id);
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}
}
