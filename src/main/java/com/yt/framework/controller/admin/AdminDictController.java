package com.yt.framework.controller.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.SysDictService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 后台字典管理
 * @author ylt
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/dict/")
public class AdminDictController {
	
	private static Logger logger = LogManager.getLogger(AdminDictController.class);
	
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private MessageResourceService messageResourceService;
	/**
	 * 保存配置
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveDict")
	@ResponseBody
	public String saveDict(HttpServletRequest request,SysDict sysDict) {
		 AjaxMsg msg = AjaxMsg.newSuccess();
			try{
				if(sysDict == null || null == sysDict.getId()){	
					msg = sysDictService.saveDict(sysDict);
				}else{
					msg = sysDictService.updateDict(sysDict);
				}
			}catch(Exception e){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
		return msg.toJson();
	}
	
	/**
	 * 竞拍市场配置里列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="dictList")
	public String dictList(HttpServletRequest request,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("dict_column", request.getParameter("dict_column"));
		maps.put("dict_desc", request.getParameter("dict_desc"));
		if(StringUtils.isNotBlank(request.getParameter("parent_id"))){
			maps.put("parent_id", Long.valueOf(request.getParameter("parent_id")));
		}
		AjaxMsg msg = sysDictService.queryForPage(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		return "admin/dict/list"; 
	}
	
	/**
	 * 市场配置创建页面
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="dictForm")
	public String dictForm(HttpServletRequest request){
		String id = request.getParameter("id");
		SysDict sysDict = new SysDict();
		if(StringUtils.isNotBlank(id)){
			sysDict = sysDictService.getEntityById(Long.valueOf(id));
		}
		request.setAttribute("dictForm", sysDict);
		return "admin/dict/dictForm"; 
	}
	
	/**
	 * 竞拍市场配置里列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="dictTree")
	@ResponseBody
	public List<SysDict> dictTree(HttpServletRequest request,PageModel pageModel) {
		return sysDictService.allDict();
	}
}	
