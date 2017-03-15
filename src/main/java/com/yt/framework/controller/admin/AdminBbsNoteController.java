package com.yt.framework.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.controller.BaseController;
import com.yt.framework.controller.BbsNoteController;
import com.yt.framework.persistent.entity.BbsLeader;
import com.yt.framework.persistent.entity.BbsNote;
import com.yt.framework.persistent.entity.BbsPlate;
import com.yt.framework.persistent.entity.BbsTip;
import com.yt.framework.service.BbsNoteService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
/**
 * 
 * <p>
 * 后台操作
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月8日 下午3:02:10
 * @version
 */
@RequestMapping(value="/admin/bbs/")
@Controller
public class AdminBbsNoteController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(BbsNoteController.class);
	@Autowired
	BbsNoteService bbsNoteService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   }  
	/**
	 * <p>Description: 分页查询论坛举报信息</p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午4:20:58
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value = "queryBbsTipsList")
	public String queryBbsTipsList(HttpServletRequest request,PageModel pageModel,Model model){
		String status = request.getParameter("status");
		String type = request.getParameter("type");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", status);
		params.put("type", type);
		AjaxMsg msg = bbsNoteService.queryTipsForPageSign(params,pageModel);
		if(msg.isSuccess()){
			model.addAttribute("page", msg.getData("page"));
			model.addAttribute("params", params);
		}
		return "admin/bbs/tip_list";
	}
	
	/**
	 * <p>Description: 修改举报状态</p>
	 * @Author zhangwei
	 * @Date 2016年1月8日 下午2:26:36
	 * @param request
	 * @return
	 */
	@RequestMapping(value="updateBbsTipStatus")
	@ResponseBody
	public String updateBbsTipStatus(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String id = request.getParameter("id");
		String statusStr = request.getParameter("status");
		
		BbsTip tip = bbsNoteService.getTipById(id);
		if(tip != null){
			int status = Integer.parseInt(statusStr);
			tip.setStatus(status);
			msg = bbsNoteService.updateBbsTip(tip);
		}else{
			msg = msg.addMessage("举报信息无效");
		}
		return msg.toJson();
	}
	
	@RequestMapping(value="noteList")
	public String noteListDataPage(Model model,HttpServletRequest request,PageModel pageModel){
		String plate_id = request.getParameter("plate_id");//板块ID
		String title = request.getParameter("title");//搜索主题
		String usernick = request.getParameter("usernick");//用户昵称
		String show = request.getParameter("show");//是否展示 1：展示 2：不展示
		String if_del = request.getParameter("if_del");//是否删除 1：删除 2：未删除
		String status = request.getParameter("status");//status LOCK:锁定帖,UNLOCK:开放贴,PICK：精华帖 , UNPICK：非精华帖
		Map<String,Object> map = Maps.newHashMap();
		map.put("plate_id", plate_id);
		map.put("title", title);
		map.put("usernick", usernick);
		map.put("show", show);
		map.put("status", status);
		map.put("if_del", StringUtils.isBlank(if_del)?"2":if_del);
		AjaxMsg msg = bbsNoteService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("page", msg.getData("page"));
			model.addAttribute("params", map);
		}
		return "admin/bbs/note_list";
	}
	
	/**
	 * <p>Description: 根据举报id获取举报相关信息</p>
	 * @Author zhangwei
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="getBbsTipById")
	public String getBbsTipById(HttpServletRequest request,Model model){
		String id = request.getParameter("id");
		AjaxMsg msg = bbsNoteService.getBbsTipById(id);
		if(msg.isSuccess()){
			BbsTip tip = (BbsTip) msg.getData("data");
			if(tip.getFloor_num() == null){
				tip.setFloor_num(1);
			}
			model.addAttribute("tip", tip);
		}
		return "admin/bbs/tip_form";
	}
	/**
	 * <p>Description:设置帖子是否置顶,是否精华，是否锁定，是否可见 </p>
	 * @Author zhangwei
	 * @Date 2016年1月9日 下午3:04:28
	 * @param request
	 * @return
	 */
	@RequestMapping(value="setNoteIfStatus")
	@ResponseBody
	public String setNoteTop(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String id = request.getParameter("id");
		String type = request.getParameter("type");//要设置的类型 例如：if_top，if_show，if_pick，if_reply，if_lock,if_del
		String statusStr = request.getParameter("status");//要设置字段的值
		String plate_id = request.getParameter("plate_id");//版块id
		
		if(type.equals("if_top")){
			int count = bbsNoteService.queryBbsNoteTopCount(plate_id);
			if(count >= 10){
				msg = msg.addMessage("置顶帖子不能超过十个");
				return msg.toJson();
			}
		}
		
		if(StringUtils.isNotBlank(id) && StringUtils.isNotBlank(type) && StringUtils.isNotBlank(statusStr)){
			BbsNote note = bbsNoteService.getEntityById(id);
			int status = Integer.parseInt(statusStr);
			if(note != null){
				note = new BbsNote();
				note.setId(id);
				if(type.equals("if_top")){
					note.setIf_top(status);
				}
				else if(type.equals("if_show")){
					note.setIf_show(status);
				}
				else if(type.equals("if_pick")){
					note.setIf_pick(status);
				}
				else if(type.equals("if_reply")){
					note.setIf_reply(status);
				}
				else if(type.equals("if_lock")){
					note.setIf_lock(status);
				}
				else if(type.equals("if_del")){
					note.setIf_del(status);
				}
				msg = bbsNoteService.updateBbsNoteIf(note);
			}
		}else{
			msg = msg.addMessage("要置顶的id跟类型及状态不能为空");
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 查询板块分类列表</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="plateList")
	public String plateList(HttpServletRequest request){
		AjaxMsg msg = bbsNoteService.queryPlateList();
		request.setAttribute("pMap", msg.getData("pMap"));
		return "admin/bbs/note_plate";
	}
	
	/**
	 * <p>Description: 跳转板块页面</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="plateForm")
	public String plateForm(HttpServletRequest request){
		String type = BeanUtils.nullToString(request.getParameter("type"));
		String id = BeanUtils.nullToString(request.getParameter("id"));
		if(StringUtils.isNotBlank(id)){
			BbsPlate plate = bbsNoteService.getPlateById(id);
			request.setAttribute("plateForm", plate);
		}
		request.setAttribute("type", type);
		return "admin/bbs/plate_form";
	}
	
	/**
	 * <p>Description: 保存板块</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveOrUpdatePlate")
	@ResponseBody
	public String saveOrUpdatePlate(HttpServletRequest request,BbsPlate bbsPlate){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			if(StringUtils.isBlank(bbsPlate.getId())){
				bbsPlate.setId(UUIDGenerator.getUUID());
				msg = bbsNoteService.savePlate(bbsPlate);
			}else{
				msg = bbsNoteService.updatePlate(bbsPlate);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 删除板块</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="delPlate")
	@ResponseBody
	public String delPlate(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isNotBlank(id)){
			try {
				msg = bbsNoteService.deletePlate(id);
			} catch (Exception e) {
				e.printStackTrace();
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 版主列表</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="leaderList")
	public String leaderList(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		String plate_id = BeanUtils.nullToString(request.getParameter("plate_id"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isNotBlank(id)){
			msg = bbsNoteService.queryLeaderList(id);
			request.setAttribute("leaders", msg.getData("rf"));
		}
		request.setAttribute("plate_id", plate_id);
		return "admin/bbs/leader_list";
	}
		
	/**
	 * <p>Description: 版主列表</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="leaderForm")
	public String leaderForm(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		String plate_id = BeanUtils.nullToString(request.getParameter("plate_id"));
		if(StringUtils.isNotBlank(id)){
			BbsLeader bbsLeader = bbsNoteService.getBbsLeaderById(id);
			request.setAttribute("leaderForm", bbsLeader);
		}
		BbsPlate bbsPlate = bbsNoteService.getPlateById(plate_id);
		request.setAttribute("bbsPlate", bbsPlate);
		return "admin/bbs/leader_form";
	}
	
	/**
	 * <p>Description: 添加版主</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveOrUpdateLeader")
	@ResponseBody
	public String saveOrUpdateLeader(HttpServletRequest request,BbsLeader bbsLeader){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			if(StringUtils.isNotBlank(bbsLeader.getId())){
				msg = bbsNoteService.updateBbsLeader(bbsLeader);
			}else{
				bbsLeader.setId(UUIDGenerator.getUUID());
				bbsNoteService.saveBbsLeader(bbsLeader);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 删除版主</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="deleteLeader")
	@ResponseBody
	public String deleteLeader(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String id = BeanUtils.nullToString(request.getParameter("id"));
		try {
			msg = bbsNoteService.deleteBbsLeader(id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 选择版主</p>
	 * @Author ylt
	 * @Date 2016年1月8日 下午4:59:33
	 * @param request
	 * @return
	 */
	@RequestMapping(value="userDialog")
	public String userDialog(HttpServletRequest request){
		return "admin/bbs/user_dialog";
	}
	
}
