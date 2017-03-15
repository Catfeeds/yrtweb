package com.yt.framework.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BabyIn;
import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.persistent.entity.BabyScore;
import com.yt.framework.persistent.entity.GiftVO;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.PriceSlave;
import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.BabyCheerService;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.BabyScoreService;
import com.yt.framework.service.BabyService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PriceSlaveService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ReturnJosnMsg;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.gson.JSONUtils;

/**
 *足球宝贝基本信息
 *@autor bo.xie
 *@date2015-9-24下午6:46:06
 */
@Controller
@RequestMapping(value="/baby/")
public class BabyInfoController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(BabyInfoController.class);

	@Autowired
	private BabyService babyService;
	@Autowired
	private BabyInService babyInService;
	@Autowired
	private UserService userService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private BabyScoreService babyScoreService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private BabyCheerService babyCheerService;
	@Autowired
	private TeamInviteService teamInviteService;
	@Autowired
	private PriceSlaveService priceSlaveService;
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private UserAmountService userAmountService;
	
	/**
	 * 宝贝详情页面
	 * @param model
	 * @param request
	 * @param baby_id
	 * @return
	 */
	@RequestMapping(value="base/{type}/{baby_id}")
	public String baseInfo(Model model,HttpServletRequest request,@PathVariable("baby_id")String baby_id,@PathVariable("type")String type){
		//获取宝贝基本信息
		BabyInfo babyInfo = new BabyInfo();
		if(type.equals("baby")){
			babyInfo = babyService.getEntityById(baby_id);
		}else{
			babyInfo = babyService.getBabyInfoByUserId(baby_id);
		}
		if(babyInfo!=null){
			//宝贝用户ID
			String user_id =  babyInfo.getUser_id();
			//宝贝用户信息
			User user = userService.getEntityById(user_id);
			//宝贝图片信息
			List<Map<String,Object>> images = babyService.loadAllBabyImageByUserId(user_id, SystemEnum.IMAGE.BABY.toString());
			//宝贝视频信息
			List<Map<String,Object>> videos = babyService.loadAllBabyVideoByUserId(user_id,  SystemEnum.IMAGE.BABY.toString());
			//获取宝贝已助威比赛场数跟已代言俱乐部个数
			Map<String,Object> icCount = babyService.getInviteAndCheerCount(user_id);
			//获取宝贝已代言俱乐部信息
			TeamInfo baby_teamInfo = babyService.getTeamInfoByUserId(user_id);
			
			//added by bo.xie 获取宝贝当前身价 start
			PriceSlave ps = priceSlaveService.getPriceSlaveByUserAndType(user_id, "6");
			model.addAttribute("ps", ps);
			//added by bo.xie 获取宝贝当前身价 end
			
			model.addAttribute("babyInfo", babyInfo);
			model.addAttribute("baby_user_id", babyInfo.getUser_id());
			model.addAttribute("images", images);
			model.addAttribute("videos", videos);
			model.addAttribute("icCount", icCount);
			model.addAttribute("user", user);
			model.addAttribute("baby_teamInfo", baby_teamInfo);
			
			String login_user_id = super.getUserId();//当前登录者ID
			if(StringUtils.isNotBlank(login_user_id)){
				//判断当前登录用户是否已关注此宝贝,focusCount>0已关注
				int focusCount = userService.isOnFocusById(login_user_id, babyInfo.getUser_id());
				model.addAttribute("focusCount", focusCount);
				//判断当前登录者是否是俱乐部队长
				TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(login_user_id);
				BabyIn old_babyIn = new BabyIn();
				if(teamInfo!=null){
					old_babyIn = babyInService.getBabyInInfo(babyInfo.getUser_id(), teamInfo.getId(), "3");
					//获取球队助威球赛信息
					List<TeamGame> listGame = teamInviteService.loadTeamGameByTeamId(teamInfo.getId());
					if(!listGame.isEmpty()){
						model.addAttribute("listGame", listGame);
						model.addAttribute("if_gm",Boolean.TRUE);
					}
				}
				Boolean isOwn = Boolean.FALSE;//是否是本人进入该页面 false 不是本人
				if(login_user_id.equals(babyInfo.getUser_id()))isOwn = Boolean.TRUE;
				model.addAttribute("isOwn", isOwn);
				
				Boolean flag =Boolean.FALSE;//是否已邀请过该足球宝贝入驻false 没有邀请
				if(old_babyIn!=null&&old_babyIn.getId()!=null)flag = Boolean.TRUE;
				//判断当前登录用户是否已对该宝贝进行评分操作
				Boolean is_pj = Boolean.FALSE;//未进行评价
				BabyScore babyScore = babyScoreService.getBabyScoreByIds(babyInfo.getUser_id(), login_user_id);
				if(babyScore!=null)is_pj = Boolean.TRUE;
				Map<String,Object> map = Maps.newHashMap();
				map.put("user_id", user_id);
				map.put("status", new Integer(3));
				int in_count = babyInService.count(map);
				map.put("status", "0");
				int cheer_count = babyCheerService.count(map);
				model.addAttribute("info_count", in_count + cheer_count);
				
				model.addAttribute("is_pj", is_pj);
				model.addAttribute("flag", flag);
				model.addAttribute("teamInfo", teamInfo);
				
				
			}
		}else{
			return "error/404";
		}
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		request.setAttribute("user_img", user_img);
		return "baby/baseInfo";
	}
	
	/**
	 * 编辑宝贝基本信息
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="editInfo")
	public String editBabyInfo(Model model,HttpServletRequest request){
		User user = super.getUser();
		String user_id = user.getId();
		AjaxMsg msg = babyService.getByUserId(user_id);
		if(msg.isSuccess()){
			BabyInfo babyInfo = (BabyInfo) msg.getData("data");
			model.addAttribute("baby", babyInfo);
			model.addAttribute("user", user);
			//宝贝图片信息
			List<Map<String,Object>> images = babyService.loadAllBabyImageByUserId(babyInfo.getUser_id(), SystemEnum.IMAGE.BABY.toString());
			model.addAttribute("images", images);
			//added by bo.xie 获取宝贝当前身价 start
			PriceSlave ps = priceSlaveService.getPriceSlaveByUserAndType(user_id, "6");
			model.addAttribute("ps", ps);
			//added by bo.xie 获取宝贝当前身价 end
			
		}
	/*	Map<String,Object> map = Maps.newHashMap();
		map.put("user_id", user_id);
		map.put("status", new Integer(3));
		int in_count = babyInService.count(map);
		map.put("status", "0");
		int cheer_count = babyCheerService.count(map);
		model.addAttribute("info_count", in_count + cheer_count);*/
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		request.setAttribute("user_img", user_img);
		return "baby/editBaseInfo";
	}
	
	/**
	 * 宝贝图片批量上传页面
	 * @autor gl
	 * @return upload_baby.jsp
	 */ 
	@RequestMapping(value="uploadImageHtml")
	public String uploadImageHtml(HttpServletRequest request){
		String role_type = SystemEnum.IMAGE.BABY.toString();
		request.setAttribute("role_type", role_type);
		return "baby/upload_baby";
	}
	
	/**
	 * 宝贝视频批量上传页面
	 * @autor gl
	 * @return upload_baby.jsp
	 */ 
	@RequestMapping(value="uploadVideoHtml")
	public String uploadVideoHtml(HttpServletRequest request){
		String role_type = SystemEnum.IMAGE.BABY.toString();
		request.setAttribute("role_type", role_type);
		return "baby/upload_baby_video";
	}
	
	/**
	 * 保存宝贝图片
	 * @autor gl
	 * @return AjaxMsg
	 */ 
	@RequestMapping(value="saveBabyImages")
	@ResponseBody
	public String saveBabyImages(HttpServletRequest request,String baby_image){
		String type = request.getParameter("type");
		String userId = getUserId();
		AjaxMsg msg = babyService.saveBabyImages(userId, baby_image,type);
		return msg.toJson();
	}
	
	/**
	 * 查询宝贝图片
	 * @autor gl
	 * @return AjaxMsg
	 */ 
	@RequestMapping(value="queryBabyImages")
	@ResponseBody
	public String queryBabyImages(HttpServletRequest request,PageModel pageModel){
		String type = request.getParameter("type");
		String userId = getUserId();
		/*Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", userId);
		params.put("type", type);
		AjaxMsg msg = babyService.queryBabyImages(params, pageModel);*/
		ImageVideo iv = new ImageVideo();
		iv.setUser_id(userId);
		iv.setRole_type(SystemEnum.IMAGE.BABY.toString());
		iv.setF_status(1);
		iv.setType(type);
		AjaxMsg msg = imageVideoService.searchImageVideos(iv, pageModel);
		return msg.toJson();
	}
	/**
	 * 删除宝贝图片
	 * @autor gl
	 * @return AjaxMsg
	 */ 
	@RequestMapping(value="deleteBabyImg")
	@ResponseBody
	public String deleteBabyImg(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = babyService.deleteBabyImg(id);
		return msg.toJson();
	}
	
	/**
	 * 宝贝基本信息
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-25上午11:37:11
	 */
	@RequestMapping(value="info")
	public String babyInfo(Model model,HttpServletRequest request){
		User user = super.getUser();
		AjaxMsg msg = babyService.getByUserId(user.getId());
		if(msg.isSuccess()){
			BabyInfo baby = (BabyInfo) msg.getData("data");
			model.addAttribute("baby", baby);
		}
		model.addAttribute("user", user);
		return "baby/info";
	}
	
	//判断当前登录者是否是足球宝贝
	@RequestMapping(value="isBaby")
	public @ResponseBody String isBaby(HttpServletRequest request){
		String user_id = super.getUserId();
		User user = userService.getEntityById(user_id);
		//首页判断是否是女性，只有女性才能成为宝贝
		if(user.getSex()!=null && user.getSex().equals(1)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.sex")).toJson();
		}
		AjaxMsg msg = babyService.getByUserId(user.getId());
		if(msg.isSuccess()){
			BabyInfo baby = (BabyInfo) msg.getData("data");
			if(baby==null){//没有成为宝贝返回成功状态
				return AjaxMsg.newSuccess().toJson();
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.isexist")).toJson();
			}
		}
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 保存或者更新
	 *@param request
	 *@param babyInfo
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-25上午11:37:07
	 */
	@RequestMapping(value="saveOrUpdate")
	public @ResponseBody String saveOrUpdate(HttpServletRequest request,BabyInfo babyInfo){
		try {
			String price = request.getParameter("price");
			if(StringUtils.isBlank(price))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.price")).toJson();
			AjaxMsg msg = babyService.saveOrUpdateInfo(babyInfo,request);//update by gl  2015.10.9 16:19 添加用户宝贝角色
			return msg.toJson();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().toJson();
		}
	}
	
	/**
	 * 宝贝搜索列表
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-6上午11:37:11
	 */
	@RequestMapping(value="searchGirl")
	public String searchGirl(HttpServletRequest request,PageModel pageModel){
		String usernick = request.getParameter("usernick");
		String city = request.getParameter("city");
		String height = request.getParameter("height");
		String score = request.getParameter("score");
		String status = request.getParameter("status");
		Map<String, Object> maps = Maps.newHashMap();
		maps.put("usernick", usernick);
		maps.put("city", city);
		maps.put("height", height);
		maps.put("score", score);
		maps.put("status", status);
		maps.put("if_del", "0");
		pageModel.setPageSize(12);
		AjaxMsg msg = babyService.queryForPageForMap(maps, pageModel);
		request.setAttribute("rf", msg.getData("page"));
		return "baby/result_baby";
	}
	
	/**
	 * 宝贝搜索页面
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-06上午11:37:11
	 */
	@RequestMapping(value="toSearch")
	public String toSearch(Model model,HttpServletRequest request){
		model.addAttribute("usernick", request.getParameter("usernick"));
		return "baby/babylist";
	}
	
	/**
	 * 宝贝邀请页面
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-10-06上午11:37:11
	 */
	@RequestMapping(value="toTeamBaby")
	public String toTeamBaby(Model model,HttpServletRequest request){
		return "baby/babyteamlist";
	}
	
	/**
	 * 保存对宝贝的评分
	 * @return
	 */
	@RequestMapping(value="inScore")
	public @ResponseBody String saveBabyScore(HttpServletRequest request){
		//当前登录者ID
		String login_user_id = super.getUserId();
		//宝贝用户ID
		String baby_user_id = request.getParameter("user_id");
		//当前评分
		String score = request.getParameter("score");
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(baby_user_id))return msg.addMessage(messageResourceService.getMessage("user.baby.notfind")).toJson();
		BabyScore bs = new BabyScore();
		bs.setUser_id(baby_user_id);
		bs.setP_user_id(login_user_id);
		bs.setScore(Double.valueOf(score));
		bs.setId(UUIDGenerator.getUUID());
		msg = babyScoreService.save(bs);
		//评分成功，更新babyinfo表中score分数字段值
		if(msg.isSuccess()){
			AjaxMsg baby_msg = babyService.getByUserId(baby_user_id);
			if(baby_msg.isSuccess()){
				BabyInfo babyInfo = (BabyInfo) baby_msg.getData("data");
				Double new_score = babyScoreService.getBabyScoreAveByBabyUserID(baby_user_id);
				babyInfo.setScore(new_score);
				babyService.update(babyInfo);
			}
		return msg.addMessage(messageResourceService.getMessage("system.success")).toJson();
		}
		return msg.toJson();
	}

	/**
	 * 
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getGiftList")
	@ResponseBody
	public String getGiftList(HttpServletRequest request, HttpSession session) {
		return JSONUtils.bean2json(GiftVO.getAllGiftList());
	}

	/**
	 * 
	 * @param request
	 * @param pjson
	 * @return
	 */
	@RequestMapping(value = "/buyGift")
	@ResponseBody
	public String buyGift(HttpServletRequest request, @RequestBody String pjson) {
		ReturnJosnMsg ajaxMsg = ReturnJosnMsg.newError();
		Map<String, String> map = JSONUtils.json2Map(pjson);
		String login_user_id = super.getUserId();
		map.put("login_user_id", login_user_id);
		ajaxMsg = babyService.buyGift(map);
		return ajaxMsg.toJson();
	}
	
	@RequestMapping(value = "/getReceiveGiftList/{user_id}")
	@ResponseBody
	public String getReceiveGiftList(HttpServletRequest request, HttpSession session,@PathVariable String user_id) {
		List<GiftVO> ls = babyService.getReceiveGiftList(user_id);
		
		return JSONUtils.bean2json(ls);
	}
}
