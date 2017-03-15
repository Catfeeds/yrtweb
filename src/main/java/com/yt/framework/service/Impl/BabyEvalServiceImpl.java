package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.BabyEval;
import com.yt.framework.service.BabyEvalService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: BabyInServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author ylt
 * @date 2015年9月24日 下午3:58:34 
 */
@Service(value="babyEvalService")
public class BabyEvalServiceImpl extends BaseServiceImpl<BabyEval> implements BabyEvalService{
	
	protected static Logger logger = LogManager.getLogger(BabyEvalServiceImpl.class);

	@Override
	public AjaxMsg queryForPageForMap(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = babyEvalMapper.queryForPageForMapCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = babyEvalMapper.queryForPageForMap(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

}
