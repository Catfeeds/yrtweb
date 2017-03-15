package com.yt.framework.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Maps;
import com.yt.framework.service.BabyService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 宝贝首页
 * @author bo.xie
 * @data 2015年10月8日15:14:33
 */
@Controller
@RequestMapping(value="/babyIhome/")
public class BabyHomeController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(BabyHomeController.class);
	
	@Autowired
	private BabyService baseService;

	/**
	 * 宝贝首页
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="index")
	public String indexPage(Model model,HttpServletRequest request){
		Map<String,Object> map = Maps.newHashMap();
		map.put("start", 0);
		map.put("rows", 8);
		List<Map<String,Object>> reMaps = baseService.loadRecommendBabyImages(map);
		model.addAttribute("reMaps", reMaps);
		return "baby/index";
	}
	
	/**
	 * 宝贝首页顶部数据
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="topDatas")
	public String recommendData(Model model,HttpServletRequest request,PageModel pageModel){
		/*Map<String,Object> map = Maps.newHashMap();
		map.put("is_index", 1);
		map.put("show_num", 1);
		pageModel.setPageSize(8);
		AjaxMsg msg = baseService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}*/
		Map<String,Object> map = Maps.newHashMap();
		map.put("start", 0);
		map.put("rows", 8);
		List<Map<String,Object>> reMaps = baseService.loadRecommendBabyImages(map);
		model.addAttribute("reMaps", reMaps);
		return "baby/indexTopDatas";
	}
	
	/**
	 * 宝贝首页中部数据
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="middleDatas")
	public String middledData(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> map = Maps.newHashMap();
		pageModel.setPageSize(23);
		map.put("if_del","0");
		AjaxMsg msg = baseService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "baby/indexMiddleDatas";
	}
	
	/**
	 * 宝贝首页底部数据
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="bottomDatas")
	public String bottomData(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> map = Maps.newHashMap();
		pageModel.setPageSize(6);
		map.put("if_del","0");
		AjaxMsg msg = baseService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "baby/indexbottomDatas";
	}
	
}
