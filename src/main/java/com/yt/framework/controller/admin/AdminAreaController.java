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
import com.yt.framework.persistent.entity.SysArea;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminSysAreaService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;

/**
 * 后台区域管理
 * @author ylt
 * @date 2015年10月12日10:41:41
 */
@Controller
@RequestMapping(value="/admin/area/")
public class AdminAreaController {
	
	private static Logger logger = LogManager.getLogger(AdminAreaController.class);
	
	@Autowired
	private AdminSysAreaService adminSysAreaService;
	@Autowired
	private MessageResourceService messageResourceService;
	/**
	 * 保存区域信息
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveSysArea")
	@ResponseBody
	public String saveSysArea(HttpServletRequest request,SysArea sysArea) {
		 AjaxMsg msg = AjaxMsg.newSuccess();
			try{
				if(sysArea == null || null == sysArea.getId()){	
					msg = adminSysAreaService.saveSysArea(sysArea);
				}else{
					msg = adminSysAreaService.updateSysArea(sysArea);
				}
			}catch(Exception e){
				e.printStackTrace();
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
		return msg.toJson();
	}
	
	/**
	 * 查询区域列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="sysAreaList")
	public String sysAreaList(HttpServletRequest request,PageModel pageModel) {
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("parent_code", StringUtils.isNotBlank(request.getParameter("parent_code")));
		AjaxMsg msg = adminSysAreaService.queryForPage(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		return "admin/area/list"; 
	}
	
	/**
	 * 编辑或者保存区域
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="sysAreaForm")
	public String sysAreaForm(HttpServletRequest request){
		String id = request.getParameter("id");
		SysArea sysAreaForm = new SysArea();
		if(StringUtils.isNotBlank(id)){
			sysAreaForm = adminSysAreaService.getEntityById(Long.valueOf(id));
		}
		request.setAttribute("sysAreaForm", sysAreaForm);
		return "admin/area/sysAreaForm"; 
	}
	
	/**
	 * 删除节点
	 * @param request
	 * @param 
	 * @return msg
	 */
	@RequestMapping(value="delSysArea")
	@ResponseBody
	public String delSysArea(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String area_code = BeanUtils.nullToString(request.getParameter("area_code"));
		try{
			List<Map<String, Object>> datas =  adminSysAreaService.querySysArea(area_code);
			if(datas.isEmpty()){
				SysArea sysArea = adminSysAreaService.getAreaByCode(area_code);
				msg = adminSysAreaService.delSysArea(sysArea);
			}
		}catch(Exception e){
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson(); 
	}
	
	/**
	 * 区域列表
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="sysAreaTree")
	@ResponseBody
	public List<SysArea> sysAreaTree(HttpServletRequest request) {
		String area_code = BeanUtils.nullToString(request.getParameter("area_code"));
		if(StringUtils.isBlank(area_code)){
			area_code = "all";
		}
		return  adminSysAreaService.sysAreaList(area_code);
	}
	
	/**
	 * 区域添加页面
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="toAddTreePage")
	public String toAddTreePage(HttpServletRequest request) {
		String area_code = BeanUtils.nullToString(request.getParameter("area_code"));
		String opt = BeanUtils.nullToString(request.getParameter("opt"));
		if(opt.equals("edit")){
			SysArea sysArea = adminSysAreaService.getAreaByCode(area_code);
			request.setAttribute("sysAreaForm", sysArea);
		}
		request.setAttribute("area_code", area_code);
		return  "admin/area/sysAreaForm";
	}
	
}	
