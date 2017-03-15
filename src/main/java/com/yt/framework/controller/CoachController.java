package com.yt.framework.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.CoachCareer;
import com.yt.framework.persistent.entity.CoachHonor;
import com.yt.framework.persistent.entity.CoachInfo;
import com.yt.framework.service.CoachCareerService;
import com.yt.framework.service.CoachHonorService;
import com.yt.framework.service.CoacheInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 *教练员
 *@autor bo.xie
 *@date2015-8-6下午4:35:13
 */
@Controller
@RequestMapping(value="/coach/")
public class CoachController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(CoachController.class);

	@Autowired
	private CoacheInfoService coacheInfoServer;
	@Autowired
	private CoachHonorService coachHonorServer;
	@Autowired
	private CoachCareerService coachCareerServer;
	
	/**
	 * 教练基本信息页面
	 */
	@RequestMapping(value="info")
	public String coachInfo(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		String type = request.getParameter("type");
		String str_oth_user_id = request.getParameter("oth_user_id");
		String oth_user_id = StringUtils.isNotBlank(str_oth_user_id)?str_oth_user_id:"";
		//获取教练基本信息
		CoachInfo coachInfo = coacheInfoServer.getCoachInfoByUserId(oth_user_id);
		model.addAttribute("coach", coachInfo);
		model.addAttribute("oth_user_id", oth_user_id);
		if(StringUtils.isNotBlank(type)&&type.equals("edit")&& user_id.equals(oth_user_id)){
			return "center/coach/coach_editinfo";
		}
//		//获取教练所获荣誉
//		List<CoachHonor> honors = coachHonorServer.getCoachHonorsByUserId(user_id);
//		//获取教练所有任职经历
//		List<CoachCareer> careers = coachCareerServer.getCoachCareerListByUserId(user_id);
		
//		model.addAttribute("honors", honors);
//		model.addAttribute("careers", careers);
		return "center/coach/coach_info";
	}
	
	/**
	 * 教练员荣誉
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-31下午5:10:05
	 */
	@RequestMapping(value="honors")
	public String coachHonorData(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		String type = request.getParameter("type");
		String str_oth_user_id = request.getParameter("oth_user_id");
		String oth_user_id = StringUtils.isNotBlank(str_oth_user_id)?str_oth_user_id:null;
		//获取教练所获荣誉
		List<CoachHonor> honors = coachHonorServer.getCoachHonorsByUserId(oth_user_id);
		model.addAttribute("honors", honors);
		model.addAttribute("oth_user_id", oth_user_id);
		if(StringUtils.isNotBlank(type)&&type.equals("edit")&&user_id.equals(oth_user_id)){
			return "center/coach/coach_edithonors";
		}
		return "center/coach/coach_honors";
	}
	
	/**
	 * 教练员任职经历
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-31下午5:10:19
	 */
	@RequestMapping(value="careers")
	public String coachCareers(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		String type = request.getParameter("type");
		String str_oth_user_id = request.getParameter("oth_user_id");
		String oth_user_id = StringUtils.isNotBlank(str_oth_user_id)?str_oth_user_id:null;
		//获取教练所有任职经历
		List<CoachCareer> careers = coachCareerServer.getCoachCareerListByUserId(oth_user_id);
		model.addAttribute("careers", careers);
		model.addAttribute("oth_user_id", oth_user_id);
		if(StringUtils.isNotBlank(type)&& type.equals("edit")&&oth_user_id.equals(user_id)){
			return "center/coach/coach_editcareers";
		}
		return "center/coach/coach_careers";
	}
	
	/**
	 * 保存或更新教练信息
	 *@param is_player 是否有球员经历
	 *@param cer_no 证书编号
	 *@param in_team 所属俱乐部
	 *@param stars 所属培养球星 
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-6下午5:14:39
	 */
	@RequestMapping(value="saveOrUpdate")
	public @ResponseBody String saveOrUpdateCoachInfo(HttpServletRequest request,CoachInfo coachInfo){
		String id = coachInfo.getId();
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id)){
			String user_id = super.getUserId();
			coachInfo.setUser_id(user_id);
			//update by gl 保存经济人信息后增加教练权限
			try {
				msg = coacheInfoServer.saveCoache(coachInfo,request);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//update by gl 
		}else{
			msg = coacheInfoServer.update(coachInfo);
		}
		System.out.println(msg.toJson());
		return msg.toJson();
	}
	
	/**
	 * 保存或更新教练荣誉
	 *@return
	 *@param name 荣誉名称
	 *@param images_url 荣誉图片
	 *@param describle 荣誉描述
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-7上午11:57:40
	 */
	@RequestMapping(value="saveOrUpdateHonor")
	public @ResponseBody String saveOrUpdateHonor(HttpServletRequest request,CoachHonor coachHonor){
		String id = coachHonor.getId();
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id)){
			String user_id = super.getUserId();
			coachHonor.setUser_id(user_id);
			coachHonor.setId(UUIDGenerator.getUUID());
			msg = coachHonorServer.save(coachHonor);
		}else{
			msg = coachHonorServer.update(coachHonor);
		}
		return msg.toJson();
	}
	
	/**
	 * 保存或更新教练任职经历
	 *@param request
	 *@param coachCareer
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-7下午5:12:28
	 */
	@RequestMapping(value="saveOrUpdateCareer")
	public @ResponseBody String saveOrUpdateCareer(HttpServletRequest request,CoachCareer coachCareer){
		//TODO 日历控件为添加，传递时间字符串会报错，与实体对象属性不一致
		String bg_time = request.getParameter("bt");
		String end_time = request.getParameter("et");
		String pattern = "yyyy-MM-dd";
		Date bg = Common.parseStringDate(bg_time, pattern);
		Date ed = Common.parseStringDate(end_time, pattern);
		coachCareer.setBg_time(bg);
		coachCareer.setEd_time(ed);
		String id = coachCareer.getId();
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id)){
			String user_id = super.getUserId();
			coachCareer.setUser_id(user_id);
			coachCareer.setId(UUIDGenerator.getUUID());
			msg = coachCareerServer.save(coachCareer);
		}else{
			msg = coachCareerServer.update(coachCareer);
		}
		return msg.toJson();
	}
	
	/**
	 * 删除荣誉
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-31下午6:20:25
	 */
	@RequestMapping(value="deleteCoach")
	public @ResponseBody String deleteCoach(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id))return msg.addMessage("删除失败！").toJson();
		msg = coachHonorServer.delete(id);
		return msg.toJson();
	}
	
	/**
	 * 删除经历
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-31下午6:22:10
	 */
	@RequestMapping(value="deleteCareer")
	public @ResponseBody String deleteCareer(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id))return msg.addMessage("删除失败！").toJson();
		msg = coachCareerServer.delete(id);
		return msg.toJson();
	}
	
	/**
	 * 教练员列表页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-1上午11:20:51
	 */
	@RequestMapping(value="listPage")
	public String listPage(Model model,HttpServletRequest request){
		model.addAttribute("usernick", request.getParameter("usernick"));
		return "coach_listPage"; 
	}
	
	/**
	 * 教练员列表数据
	 *@param model
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-1下午2:10:08
	 */
	@RequestMapping(value="listdata")
	public String listData(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> map = Maps.newHashMap();
			map.put("province", request.getParameter("province"));
			map.put("city", request.getParameter("city"));
			map.put("in_team", request.getParameter("in_team"));
			map.put("usernick", request.getParameter("usernick"));
		AjaxMsg msg = coachCareerServer.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "coach_listData";
	}
}
