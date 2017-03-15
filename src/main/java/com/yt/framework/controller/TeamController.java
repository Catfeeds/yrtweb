package com.yt.framework.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.persistent.entity.AgentInfo;
import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.LeagueMarket;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;
import com.yt.framework.persistent.entity.TeamActiveCode;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamInvite;
import com.yt.framework.persistent.entity.TeamLeague;
import com.yt.framework.persistent.entity.TeamLoanPlayer;
import com.yt.framework.persistent.entity.TeamNotice;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.TeamPlayerWage;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.Visitor;
import com.yt.framework.persistent.entity.WagePayrollVO;
import com.yt.framework.persistent.entity.WagePlayerVO;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.persistent.enums.VisitorEnum.VISTORTYPE;
import com.yt.framework.service.AgentInfoService;
import com.yt.framework.service.AutoInfoMationService;
import com.yt.framework.service.BabyInService;
import com.yt.framework.service.BabyService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.LeagueMarketService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.MessageService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.TeamLoanPlayerService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.VisitorService;
import com.yt.framework.service.admin.ActiveCodeService;
import com.yt.framework.service.admin.AdminEventRecordService;
import com.yt.framework.service.admin.QuanLeagueService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.URLHelper;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.file.ImageUtils;
import com.yt.framework.utils.file.UploadUtils;
import com.yt.framework.utils.gson.JSONUtils;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;
import com.yt.framework.utils.tag.FileUtilsTag;

import nl.justobjects.pushlet.util.Log;

/**
 * 俱乐部
 * 
 * @autor bo.xie
 * @date2015-8-3下午2:46:36
 */
@Controller
@RequestMapping(value = "/team/")
public class TeamController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(TeamController.class);
	@Autowired
	AdminEventRecordService eventRecordService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private AgentInfoService agentInfoService;
	@Autowired
	AutoInfoMationService autoInfoMationService;
	@Autowired
	UserService userService;
	@Autowired
	private TeamInviteService teamInviteService;
	@Autowired
	private VisitorService visitorService;
	@Autowired
	private PlayerInfoService playerInfoService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private BabyInService babyInService;
	@Autowired
	private LeagueService leagueService;
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	@Autowired
	private UserAmountService userAmountService;
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private LeagueMarketService leagueMarketService;
	@Autowired
	private BabyService babyService;
	@Autowired
	private ActiveCodeService activeCodeService;
	@Autowired
	private TeamLoanPlayerService teamLoanPlayerService;
	
	/**
	 * 更改logo
	 * @autor gl
	 * @return String
	 */
	@RequestMapping(value="changeTeamImg")
	public String changeHeadImg(){
		return "team/logo_img";
	}
	@RequestMapping(value="/secTeam")
	@ResponseBody
	public String secTeam(){
		return AjaxMsg.newSuccess().toJson();
	}
	/**
	 * <p>Description: 判断是否可以创建俱乐部</p>
	 * @Author zhangwei
	 * @Date 2015年12月7日 下午4:09:00
	 * @return
	 */
	@RequestMapping(value="/checkIfCreateClub")
	@ResponseBody
	public String checkIfCreateClub(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String user_id = super.getUserId();
		PlayerInfo pi = playerInfoService.getPlayerInfoByUserId(user_id);
		if(pi==null){
			return msg.addMessage("只有球员才能创建俱乐部！").toJson();
		}else{
			return AjaxMsg.newSuccess().toJson();
		}
	}
	
	@RequestMapping(value = "saveLogoImg")
	@ResponseBody
	public String saveHeadImg(HttpServletRequest request){
		
		String head_img = request.getParameter("head_img");
		String x = request.getParameter("x");
		String y = request.getParameter("y");
		String widthx = request.getParameter("width");
		String heighty = request.getParameter("height");
		try {
			if(StringUtils.isNotBlank(head_img)){
				File file = new File(fileRepository.getRealPath(head_img));
				if (file.exists()) {
					String type = ImageKit.getImageFormat(file);
					String srcPath = UploadUtils.generateFilename("headImg/team", type);
					srcPath = fileRepository.getRealPath(srcPath);
			        BufferedImage bufferedImage = ImageIO.read(file);
			        int width = bufferedImage.getWidth();
			        int height = bufferedImage.getHeight();

			        int rotate = 0;

			        if (rotate == -90 || rotate == -270) {
			            width = bufferedImage.getHeight();
			            height = bufferedImage.getWidth();
			        }
			        bufferedImage = ImageKit.rotateImage(rotate, bufferedImage);
			        ImageKit.abscut(bufferedImage, srcPath, type, (int) Double.parseDouble(x), (int) Double.parseDouble(y), (int) Double.parseDouble(widthx), (int) Double.parseDouble(heighty), width, height);
			        String filename = UploadUtils.generateFilename("headImg/team", type);
			        String newSrc = fileRepository.getRealPath(filename);
			        newSrc = ImageKit.zipImage(srcPath, type,newSrc);
			        ImageKit.delFile(fileRepository.getRealPath(head_img));
			        ImageKit.delFile(srcPath);
			        return AjaxMsg.newSuccess().addData("filename", filename).toJson();
		        }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return AjaxMsg.newError().addMessage("上传的头像不存在").toJson();
	}
	
	/**
	 * 编辑俱乐部信息
	 * 
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-8-3下午3:48:45
	 */
	@RequestMapping(value = "info/**")
	public String teamInfo(Model model, HttpServletRequest request) {
		try {
			String user_id = super.getUserId();
			List<Map<String,Object>> needImagesList = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> remarkImagesList = new ArrayList<Map<String,Object>>();
			//update by gl 将普通用户创建俱乐部和俱乐部修改属性 的url分开
			String[] paths = URLHelper.getPaths(request);
			int len = paths.length;
			if(len==3){
				String teamId = paths[2];
				TeamInfo team_info = teamInfoService.getTeamInfoByUserId(user_id);
				if(team_info!=null&&(team_info.getId().equals(teamId))){
					TeamLeague teamLeague = leagueService.getTeamLeague(team_info.getId());
					if(null != teamLeague && StringUtils.isNotBlank(teamLeague.getId())){
 						model.addAttribute("tl",0);
					}else{
						model.addAttribute("tl",1);
					}
					model.addAttribute("team", team_info);
					String remarkImages = team_info.getRemark_images();
					if(StringUtils.isNotBlank(remarkImages)){
						String remarkImg[] = remarkImages.split(",");
						for (int i = 0; i < remarkImg.length; i++) {
							Map<String,Object> map = new HashMap<String,Object>();
							map.put("remark_link", remarkImg[i].toString());
							remarkImagesList.add(map);
						}
					}
					model.addAttribute("remarkImagesList", remarkImagesList);
				}else{
					return ""; //防止用户直接在URL中填写俱乐部ID
				}
			}
			int needNumImg = 4-remarkImagesList.size();
			if(needNumImg > 0 ){
				for (int i = 0; i < needNumImg; i++) {
					Map<String,Object> map = new HashMap<String,Object>();
					needImagesList.add(map);
				}
			}
			model.addAttribute("user_id", user_id);
			model.addAttribute("needImagesList",needImagesList);
			//update by gl
			AjaxMsg msg = userService.getFocusUsersNoPage(user_id);
			request.setAttribute("players", msg.getData("data"));
			return "team/team_info_new";
		} catch (Exception e) {
			return "error/404";
		}
	}

	/**
	 * 俱乐部搜索结果
	 * 
	 * @param request
	 * @param pageModel
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午5:26:52
	 */
	@RequestMapping(value = "searchTeam")
	public String searchTeam(HttpServletRequest request, PageModel pageModel, TeamInfo teamInfo) {
		Map<String, Object> params = Maps.newHashMap();
		String login_user_id = this.getUserId();
		try {
			BeanUtils.object2Map(params, teamInfo);
			params.put("order_str", request.getParameter("order_str"));
			params.put("order_type", request.getParameter("order_type"));
			params.put("is_focus", request.getParameter("is_focus"));
			params.put("beginSumballs", request.getParameter("beginSumballs"));
			params.put("endSumballs", request.getParameter("endSumballs"));
			params.put("beginScore", request.getParameter("beginScore"));
			params.put("endScore", request.getParameter("endScore"));
			AjaxMsg msg = AjaxMsg.newSuccess();
			params.put("user_id", login_user_id);
			msg = teamInfoService.queryForPageForMap(params, pageModel);
			request.setAttribute("rf", msg.getData("page"));
			request.setAttribute("params", params);
			//System.out.println(msg.toJson());
		} catch (Exception e) {
			return "error/404";
		}
		return "team/result_team";
	}

	/**
	 * 保存或者更新俱乐部信息
	 * 
	 * @param id
	 *            俱乐部ID
	 * @param logo
	 *            logo图片
	 * @param name
	 *            名字
	 * @param ball_format
	 *            赛制
	 * @param play_position
	 *            常踢球地点
	 * @param play_time
	 *            常踢球时间
	 * @param allow
	 *            是否允许所有人加入
	 * @param is_pk
	 *            是否开启对战邀请
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午4:11:19
	 */
	@RequestMapping(value = "saveOrUpdate")
	@ResponseBody
	public String saveTeamInfo(HttpServletRequest request, TeamInfo ti) {
		String logoType = request.getParameter("logoType");
		if(!"1".equals(logoType)){
			ti.setLogo(ImageUtils.subResouceUrl(ti.getLogo(), "resources")); // 消除logo中指定目录名
		}
		String id = ti.getId();
		AjaxMsg msg = AjaxMsg.newError();
		String user_id = super.getUserId();
		String name = ti.getName();
		Map<String,Object> map = Maps.newHashMap();
		map.put("name", name);
		try {
			if (StringUtils.isBlank(id)) {
				if(StringUtils.isNotBlank(name)){
					int count = teamInfoService.teamExistByTeamName(name);
					if(count>0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.names")).toJson();	
				}
				//added by bo.xie 只有球员才能创建俱乐部，首页判断用户是否是球员	start
				PlayerInfo pi = playerInfoService.getPlayerInfoByUserId(user_id);
				if(pi==null)return msg.addMessage("只有球员才能创建俱乐部！").toJson();
				//added by bo.xie 只有球员才能创建俱乐部，首页判断用户是否是球员	end
				ti.setUser_id(user_id);
				ti.setScore(13);//added by gl 创建俱乐部 活跃度默认10;
				ti.setImage_count(5);
				ti.setVideo_count(2);
				try {
					msg = teamInfoService.saveTeam(ti,request);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				TeamInfo old_ti = teamInfoService.getEntityById(ti.getId());
				String old_logo = old_ti.getLogo();
				String new_logo = ti.getLogo();
				String old_imgs = old_ti.getRemark_images();
				String new_imgs = ti.getRemark_images();
				if(StringUtils.isNotBlank(name)&&!old_ti.getName().equals(name)){
					int count = teamInfoService.teamExistByTeamName(name);
					if(count>0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.names")).toJson();	
				}
				old_ti.setSim_name(ti.getSim_name());
				old_ti.setLogo(ti.getLogo());
				old_ti.setName(ti.getName());
				old_ti.setBall_format(ti.getBall_format());
				old_ti.setPlay_position(ti.getPlay_position());
				old_ti.setPlay_time(ti.getPlay_time());
				old_ti.setAllow(ti.getAllow());
				old_ti.setIs_pk(ti.getIs_pk());
				old_ti.setProvince(ti.getProvince());
				old_ti.setCity(ti.getCity());
				old_ti.setRemark(ti.getRemark());
				old_ti.setRemark_images(ti.getRemark_images());
				if(!old_logo.equals(new_logo)){
					if(!new_logo.contains("images")){
						int result = OSSClientFactory.uploadFile(new_logo, new File(fileRepository.getRealPath(new_logo)));
						if(result == Global.SUCCESS){
							ImageKit.delFile(fileRepository.getRealPath(new_logo));
						}else{
							return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
						}
					}
					if(!old_logo.contains("images")){
						OSSClientFactory.deleteFile(old_logo);
					}
				}
				if(StringUtils.isNotBlank(old_imgs)){
					List<String> oldImgs = Lists.newArrayList(old_imgs.split(","));
					List<String> ss1 = new ArrayList<String>();
					ss1.addAll(oldImgs);
					if(StringUtils.isNotBlank(new_imgs)){
						List<String> newImgs = Lists.newArrayList(new_imgs.split(","));
						oldImgs.removeAll(newImgs);//缺少的
						newImgs.removeAll(ss1);//多出来的
						if(oldImgs!=null&&oldImgs.size()>0){
							for (String oi : oldImgs) {
								OSSClientFactory.deleteFile(oi);
							}
						}
						if(newImgs!=null&&newImgs.size()>0){
							for (String ni : newImgs) {
								int flag = OSSClientFactory.uploadFile(ni, new File(fileRepository.getRealPath(ni)));
								if(flag == Global.SUCCESS){
									ImageKit.delFile(fileRepository.getRealPath(ni));
								}
							}
						}
					}else{
						for (String oi : oldImgs) {
							OSSClientFactory.deleteFile(oi);
						}
					}
				}else{
					if(StringUtils.isNotBlank(new_imgs)){
						List<String> newImgs = Lists.newArrayList(new_imgs.split(","));
						if(newImgs!=null&&newImgs.size()>0){
							for (String ni : newImgs) {
								int flag = OSSClientFactory.uploadFile(ni, new File(fileRepository.getRealPath(ni)));
								if(flag == Global.SUCCESS){
									ImageKit.delFile(fileRepository.getRealPath(ni));
								}
							}
						}
					}
				}
				msg = teamInfoService.update(old_ti);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}	
		return msg.addData("user_id", user_id).toJson();
	}
	

	/**
	 * 俱乐部列表页面
	 * 
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午5:22:39
	 */
	@RequestMapping(value = "/list")
	public String teamListPage(Model model,HttpServletRequest request) {
		String name = request.getParameter("name");
		if(null != name && !name.equals("")){
			request.setAttribute("name", name);
		}
		String user_id = super.getUserId();
		TeamInfo ti = teamInfoService.getTeamInfoByUserId(user_id);
		model.addAttribute("ti", ti);
		return "team/team_list";
	}
	
	
	/**
	 * 俱乐部列表页面中推荐俱乐部
	 * @autor gl
	 * @return
	 */
	@RequestMapping(value = "/queryRecommends")
	public String queryRecommends(HttpServletRequest request, PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		AjaxMsg msg = teamInfoService.queryRecommends(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		return "team/team_recommendations";
	}

	/**
	 * 俱乐部列表数据
	 * 
	 * @param request
	 * @param pageModel
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午5:26:52
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "listDatas")
	public @ResponseBody String teamListDatas(HttpServletRequest request, PageModel pageModel) {
		Map<String, Object> params = Maps.newHashMap();
		params.put("name", request.getParameter("name"));
		params.put("sumballs", request.getParameter("sumballs"));
		params.put("ball_format", request.getParameter("ball_format"));
		params.put("play_time", request.getParameter("play_time"));
		params.put("city", request.getParameter("city"));
		params.put("orderSumballs", request.getParameter("orderSumballs"));
		params.put("orderWin", request.getParameter("orderWin"));

		// 排序方式，默认按俱乐部创建时间排序
		params.put("orderNum", request.getParameter("orderNum"));
		AjaxMsg msg = teamInfoService.queryForPage(params, pageModel);
		System.out.println(msg.toJson());
		return msg.toJson();
	}

	/**
	 * 俱乐部成员列表数据(分页)
	 * @param request
	 * @param pageModel
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午5:26:52
	 */
	@RequestMapping(value = "teamPlayerList")
	public String teamPlayerListDatas(HttpServletRequest request,PageModel pageModel) {
		String login_user_id = this.getUserId();
		boolean transferFlag = false;//定向购买对象判断标志 true:可购买  false：不可购买
		boolean loanFlag = false;//租借对象判断标志 true:可租借  false：不可以租借
		
		String teaminfo_id = BeanUtils.nullToString(request.getParameter("teaminfo_id"));
		Map<String,Object>maps = Maps.newHashMap();
		TeamInfo buyTeam = teamInfoService.getTeamInfoByPUserID(login_user_id);
		if(null != buyTeam){
			maps.put("buy_teaminfo_id", buyTeam.getId());
			//登录用户俱乐部与当前用户俱乐部是否相同俱乐部,用户判断定向购买和租借
			if(!buyTeam.getId().equals(teaminfo_id)){
				transferFlag = teamInviteService.checkIfTransferShow(buyTeam.getId());
				loanFlag = teamLoanPlayerService.checkIfLoanShow(buyTeam.getId());
			}
		}
		
		if (StringUtils.isNotBlank(teaminfo_id)){
			maps.put("teaminfo_id", teaminfo_id);
			AjaxMsg msg = teamInfoService.getTeamPlayerList(maps,pageModel);
			request.setAttribute("team_players", msg.getData("page"));
			request.setAttribute("teaminfo_id", teaminfo_id);
		}
		request.setAttribute("transferFlag", transferFlag);
		request.setAttribute("loanFlag", loanFlag);
		return "team/player/teamplayer";
	}

	/**
	 * 退出球队
	 * 
	 * @param teaminfo_id
	 *            球队ID
	 * @return player_id 球员用户ID
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-8-10上午11:19:32
	 */
	@RequestMapping(value = "outTeam")
	public @ResponseBody String outTeamForPlayer(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String player_id = request.getParameter("player_id");// 球员用户ID
		if (StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id))
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt")).toJson();
		AjaxMsg msg = AjaxMsg.newError();
		try {
			msg = teamInfoService.outTeam(teaminfo_id, player_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg.toJson();
	}

	/**
	 * 加入俱乐部
	 * 
	 * @param teaminfo_id
	 *            球队ID
	 * @return player_id 球员用户ID
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-9-6上午11:37:53
	 */
	@RequestMapping(value = "joinTeam")
	public @ResponseBody String joinTeamForPlayer(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String player_id = request.getParameter("player_id");// 球员用户ID
		String session_player_id = this.getUserId();
		AjaxMsg msg = AjaxMsg.newSuccess();
		try{
			if(StringUtils.isBlank(session_player_id)){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.login")).toJson();
			}else{
				//判断球队是否开启加入球员设置
				TeamInfo t = teamInfoService.getEntityById(teaminfo_id);
				if(t.getAllow().intValue() == 0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.team.noallow")).toJson();
				//判断球员是否被拉入黑名单
				int i = teamInfoService.ifBlackPlayer(teaminfo_id, session_player_id);
				if(i == 1) return  AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.black")).toJson();
				//added by bo.xie 只有球员才能加入俱乐部，首页判断用户是否是球员	start
				PlayerInfo pi = playerInfoService.getPlayerInfoByUserId(session_player_id);
				if(pi==null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.team.noplayer")).toJson();
				//added by bo.xie 只有球员才能加入俱乐部，首页判断用户是否是球员	end
				msg = teamInfoService.joinTeam(teaminfo_id, session_player_id);
			}
		}catch(Exception e){
			e.printStackTrace();
			return msg.addMessage("").toJson();
		}
		return msg.toJson();
	}

	/**
	 * 球员拉入黑名单
	 * 
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-10上午11:37:53
	 */
	@RequestMapping(value = "defriendPlayer")
	public @ResponseBody String defriendPlayer(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String player_id = request.getParameter("player_id");// 球员用户ID
		AjaxMsg msg = AjaxMsg.newError();
		try {
			if (StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id)){
				return AjaxMsg.newError().addMessage("球队或球员不存在").toJson();
			}
			msg = teamInfoService.defriendPlayer(teaminfo_id, player_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg.toJson();
	}

	/**
	 * 踢出黑名单
	 * 
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter * @date2015-8-10 下午5:37:53
	 */
	@RequestMapping(value = "kickBlackPlayer")
	public @ResponseBody String kickBlackPlayer(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String player_id = request.getParameter("player_id");// 球员用户ID
		if (StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id))
			return AjaxMsg.newError().addMessage("球队或球员不存在").toJson();
		AjaxMsg msg = teamInfoService.kickfriendPlayer(teaminfo_id, player_id);
		return msg.toJson();
	}

	/**
	 * 踢出球队
	 * 
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter * @date2015-8-11 上午11:37:53
	 */
	@RequestMapping(value = "kickTeam")
	public @ResponseBody String kickTeam(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String player_id = request.getParameter("player_id");// 球员用户ID
		if (StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id))
			return AjaxMsg.newError().addMessage("球队或球员不存在").toJson();
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = teamInfoService.kickTeam(teaminfo_id, player_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg.toJson();
	}

	/**
	 * 黑名单列表
	 * 
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter * @date2015-8-11 上午11:37:53
	 */
	@RequestMapping(value = "black/{toPage}")
	public String blackListDatas(HttpServletRequest request, @PathVariable String toPage, PageModel pageModel) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String user_id = request.getParameter("user_id");// 球队队长id
		if (StringUtils.isBlank(teaminfo_id))
			return AjaxMsg.newError().addMessage("球队不存在").toJson();
		AjaxMsg msg = teamInfoService.blackList(teaminfo_id, pageModel);
		request.setAttribute("rf", msg.getData("data"));
		request.setAttribute("teaminfo_id", teaminfo_id);
		request.setAttribute("user_id", user_id);
		return "team/black/" + toPage;
	}

	/**
	 * 黑名单页面
	 * 
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter * @date2015-8-11 上午11:37:53
	 */
	@RequestMapping(value = "blacklist/blacklist")
	public String toBlackPage(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String user_id = request.getParameter("user_id");// 球队ID
		request.setAttribute("teaminfo_id", teaminfo_id);
		request.setAttribute("user_id", user_id);
		return "team/black/blackplayerlist";
	}

	/**
	 * 球员身份变更
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter * @date2015-8-11 上午11:37:53
	 */
	@RequestMapping(value = "changeRole")
	public @ResponseBody String changeRole(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String player_id = request.getParameter("player_id");// 球员ID
		String type = request.getParameter("type");
		if (StringUtils.isBlank(player_id))
			return AjaxMsg.newError().addMessage("球员不存在").toJson();
		AjaxMsg msg = AjaxMsg.newError();
		try {
			msg = teamInfoService.checkCaptain(teaminfo_id, player_id,
					Integer.valueOf(type),request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return msg.toJson();
	}

	/**
	 * 邀请加入俱乐部
	 * 
	 * @param reques
	 * @return
	 * @autor ylt
	 * @parameter jsonPlayer:
	 *            {"user":[{"player_id":"1"},{"player_id":"2"},{"player_id":"2"}
	 *            ]} @date2015-8-11 上午11:37:53
	 */
	@RequestMapping(value = "invitePlayer")
	public @ResponseBody String invitePlayer(HttpServletRequest request) {
		AjaxMsg msg = AjaxMsg.newError();
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		String player_id = request.getParameter("player_id");
		String jsonPlayer = request.getParameter("jsonPlayer");// 球员ID
		if (StringUtils.isBlank(teaminfo_id) || StringUtils.isBlank(player_id))
			return AjaxMsg.newError().addMessage("球队或球员不存在").toJson();
		// 获取球队信息
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(player_id);
		if (teamInfo == null)
			return AjaxMsg.newError().addMessage("球队不存在").toJson();
		try {
			ObjectMapper mapper = new ObjectMapper();
			JsonNode node = mapper.readTree(jsonPlayer);
			String userJson = node.get("user").toString();
			JsonNode nodeUser = mapper.readTree(userJson);
			for (int i = 0; i < nodeUser.size(); i++) {
				// 获取球员签约经济人，若球员有经纪人则发送消息对象为经纪人和球员
				String user_id = nodeUser.get(i).get("player_id").getTextValue(); // 球员Id
				AgentInfo agentInfo = agentInfoService.currentSignPlayer(user_id);
				if (agentInfo != null && StringUtils.isNotBlank(agentInfo.getId())) {
					// 经纪人消息发送
					Message ta = new Message();
					ta.setId(UUIDGenerator.getUUID());
					ta.setUser_id(agentInfo.getUser_id());
					ta.setCreate_time(new Date());
					ta.setType(SystemEnum.SYSTYPE.TTPA.toString());
					ta.setContent(teamInfo.getName() + "俱乐部邀请您加入");
					ta.setS_user_id(player_id);
					ta.setStatus(0);
					msg = messageService.save(ta);
				}
				// 球员消息发送
				Message t = new Message();
				t.setId(UUIDGenerator.getUUID());
				t.setUser_id(nodeUser.get(i).get("player_id").getTextValue());
				t.setCreate_time(new Date());
				t.setType(SystemEnum.SYSTYPE.TTPA.toString());
				t.setContent(teamInfo.getName() + "俱乐部邀请您加入");
				t.setS_user_id(player_id);
				t.setStatus(0);
				msg = messageService.save(t);
			}
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage("邀请加入失败,请联系管理员处理").toJson();
		}
		return msg.toJson();
	}

	/**
	 * 邀请加入俱乐部确认
	 * 
	 * @param teaminfo_id
	 *            球队ID
	 * @return player_id 球员用户ID
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-10上午11:37:53
	 */
	@RequestMapping(value = "joinTeamForMessage")
	public @ResponseBody String joinTeamForMessage(HttpServletRequest request) {
		AjaxMsg msg = AjaxMsg.newError();
		String captain_id = request.getParameter("captain_id");// 队长用户ID
		String player_id = request.getParameter("player_id");// 球员用户ID
		if (StringUtils.isBlank(captain_id) || StringUtils.isBlank(player_id))
			return AjaxMsg.newError().addMessage("球员不存在").toJson();
		// 获取邀请人所在球队信息
		try{
			TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(captain_id);
			if (teamInfo != null && StringUtils.isNotBlank(teamInfo.getId())) {
				msg = teamInfoService.joinTeam(teamInfo.getId(), player_id);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return msg.toJson();
	}

	/**
	 * 俱乐部邀战列表搜索
	 * 
	 * @param request
	 * @param pageModel
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午5:26:52
	 */
	@RequestMapping(value = "searchInviteDatas")
	public @ResponseBody String searchInviteDatas(HttpServletRequest request, PageModel pageModel) {
		Map<String, Object> params = Maps.newHashMap();
		pageModel.setPageSize(6);
		params.put("user_id", getUserId());
		params.put("name", request.getParameter("name"));
		params.put("sumballs", request.getParameter("sumballs"));
		params.put("ball_format", request.getParameter("ball_format"));
		params.put("play_time", request.getParameter("play_time"));
		params.put("city", request.getParameter("city"));
		params.put("orderSumballs", request.getParameter("orderSumballs"));
		params.put("orderWin", request.getParameter("orderWin"));
		AjaxMsg msg = teamInfoService.searchInviteTeam(params, pageModel);
		System.out.println(msg.toJson());
		return msg.toJson();
	}

	/**
	 * 俱乐部创建人信息
	 * 
	 * @param request
	 * @param pageModel
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午5:26:52
	 */
	@RequestMapping(value = "getCaption")
	public @ResponseBody String getCaption(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");// 球队ID
		if (StringUtils.isBlank(teaminfo_id))
			return AjaxMsg.newError().addMessage("球队不存在").toJson();
		AjaxMsg msg = teamInfoService.getCaption(teaminfo_id);
		return msg.toJson();
	}

	/**
	 * 关注俱乐部
	 * 
	 * @param f_teaminfo_id
	 *            俱乐部
	 * @param f_type
	 *            0:非俱乐部，1 俱乐部
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-12下午5:43:15
	 */
	@RequestMapping(value = "focusTeam")
	public @ResponseBody String focusTeam(HttpServletRequest request, Focus focus) {
		String user_id = super.getUserId();
		int count = teamInfoService.getFocusTeams(user_id,focus.getF_teaminfo_id());
		if(count > 0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.focused")).toJson(); 
		focus.setUser_id(user_id);
		focus.setStatus(0);
		focus.setF_type(1);
		AjaxMsg msg = teamInfoService.saveFocus(focus);
		return msg.toJson();
	}

	/**
	 * 取消关注
	 * 
	 * @param f_teaminfo_id
	 *            被关注用户ID
	 * @param type
	 *            0:非俱乐部 1：俱乐部 默认为0
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-8-12下午6:01:04
	 */
	@RequestMapping(value = "cancel")
	public @ResponseBody String cancelFocusUser(HttpServletRequest request) {
		String user_id = super.getUserId();
		String f_teaminfo_id = request.getParameter("f_teaminfo_id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		if (StringUtils.isNotBlank(f_teaminfo_id)) {
			msg = teamInfoService.deleteFocus(user_id, f_teaminfo_id);
		} else {
			return AjaxMsg.newError().addMessage("球队不存在").toJson();
		}
		return msg.toJson();
	}

	/**
	 * 俱乐部详情页面
	 * 
	 * @param model
	 * @param request
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-9-7上午11:09:33
	 */
	
	@RequestMapping(value = "guide")
	public String teamGuide(Model model){
		String login_user_id = super.getUserId();
		TeamInfo team_info = teamInfoService.getTeamInfoByUserId(login_user_id);
		if(team_info!=null){
			return "redirect:/team/detail";
		}else{
			TeamPlayer teamPlayer = teamInfoService.getTeamPlayerByUserId(login_user_id);
			if(teamPlayer!=null){
				TeamInfo t = teamInfoService.getEntityById(teamPlayer.getTeaminfo_id());
				return "redirect:/team/detail/"+t.getUser_id()+".html";
			}else{
				model.addAttribute("user_id", login_user_id);
				model.addAttribute("team", team_info);
				// 显示创建俱乐部引导页面
				return "team/team_guide";
			}
		}
	}
	
	@RequestMapping(value = "detail")
	public String teamDeatailPage(Model model,HttpServletRequest request,HttpServletResponse resp){
		String login_user_id = super.getUserId();
		TeamInfo team_info = teamInfoService.getTeamInfoByUserId(login_user_id);
		//update by bo.xie 个人账户转俱乐部账户	start
//		AjaxMsg msg_user = userAmountService.getByUserId(team_info.getUser_id());
//		model.addAttribute("userAmount",msg_user.getData("data"));
		UserAmount userAmount = userAmountService.getUserAmountByTeamInfoID(team_info.getId());
		model.addAttribute("userAmount",userAmount);
		//update by bo.xie 个人账户转俱乐部账户	end
		model.addAttribute("user_id", login_user_id);
		model.addAttribute("team", team_info);
		//added by bo.xie 判断该俱乐部是否报名联赛start
		Boolean tl_flag = Boolean.FALSE;//为加入联赛
		TeamLeague tl= leagueService.getTeamLeague(team_info.getId());
		if(null!=tl)tl_flag = Boolean.TRUE;
		model.addAttribute("tl_flag", tl_flag);
		//added by bo.xie 判断该俱乐部是否报名联赛end
		// 若不是，判断该用户是否已加入其他俱乐部，若没有加入，显示申请加入按钮
		if (StringUtils.isNotBlank(login_user_id)) {
			TeamInfo login_ti = teamInfoService.getTeamInfoByUserId(login_user_id);
			int playerCount = teamInfoService.teamPlayerCount(login_ti.getId());
			int babyCount = teamInfoService.teamBabyCount(login_ti.getId());
			int priceCount = teamInfoService.teamPlayerPrice(team_info.getId());
			model.addAttribute("priceCount",priceCount);
			model.addAttribute("playerCount",playerCount);
			model.addAttribute("babyCount",babyCount);
			if (login_ti != null) {// 不为null,说明该登录用户是俱乐部队长
				model.addAttribute("is_team", Boolean.TRUE);
				model.addAttribute("fq_login_ti", login_ti);// 发起挑战俱乐部
				// 判断是否与该俱乐部正在约战中
				TeamInvite team_inv = teamInviteService.getInviteByTeam(login_ti.getId(), team_info.getId());
				if (team_inv != null)
					model.addAttribute("is_invite", Boolean.TRUE);

				AjaxMsg msg = userService.getFocusUsersNoPage(login_user_id);
				model.addAttribute("players", msg.getData("data"));
			} else {
				// 判断当前登录用户是否已加入该俱乐部
				TeamPlayer tp = teamInfoService.getTeamPlayerInfoByIds(login_user_id, team_info.getId());
				if (tp != null) {// 不为null,说明该用户已经加入该俱乐部
					model.addAttribute("is_join", Boolean.TRUE);
				}
			}
			
			//登陆用户为当前俱乐部管理员
			if(login_user_id.equals(team_info.getUser_id())){
				Map<String,Object> map = Maps.newHashMap();
				map.put("teaminfo_id", team_info.getId());
				map.put("status","1");
				AjaxMsg msg = babyInService.queryBabyTeamForMap(map, new PageModel());
				model.addAttribute("babyTeams", msg.getData("page"));
				TeamLeague teamLeague = leagueService.getTeamLeague(team_info.getId());
				model.addAttribute("teamLeague", teamLeague);
			}
		}
		Map<String, Object> re_map = teamInfoService.getTeamAbilityScore(team_info.getId());
		model.addAttribute("re_map", re_map); 
		return "team/team_newDetails";
		//return "team/team_details";
	}
	
	@RequestMapping(value = "detail/{user_id}")
	public String teamDeatailPage(Model model, HttpServletRequest request,@PathVariable String user_id) {
		String login_user_id = super.getUserId();// 当前登录者用户ID
		if (StringUtils.isBlank(user_id)) {
			return "";
		}
		TeamInfo team_info = teamInfoService.getTeamInfoByUserId(user_id);
		//update by bo.xie 个人账户转俱乐部账户	start
//		AjaxMsg msg_user = userAmountService.getByUserId(team_info.getUser_id());
//		model.addAttribute("userAmount",msg_user.getData("data"));
		UserAmount userAmount = userAmountService.getUserAmountByTeamInfoID(team_info.getId());
		model.addAttribute("userAmount",userAmount);
		//update by bo.xie 个人账户转俱乐部账户	end
		int playerCount = teamInfoService.teamPlayerCount(team_info.getId());
		int babyCount = teamInfoService.teamBabyCount(team_info.getId());
		int priceCount = teamInfoService.teamPlayerPrice(team_info.getId());
		model.addAttribute("priceCount",priceCount);
		model.addAttribute("playerCount",playerCount);
		model.addAttribute("babyCount",babyCount);
		model.addAttribute("user_id", user_id);
		model.addAttribute("team", team_info);
		if (team_info == null) {
			// 没有就到404
			return "";
		}
		//added by bo.xie 判断该俱乐部是否报名联赛start
			Boolean tl_flag = Boolean.FALSE;//为加入联赛
			TeamLeague tl= leagueService.getTeamLeague(team_info.getId());
			if(null!=tl)tl_flag = Boolean.TRUE;
			model.addAttribute("tl_flag", tl_flag);
		//added by bo.xie 判断该俱乐部是否报名联赛end
		
		
		// 若当前登录者id与俱乐部user_id不相等，需要判断当前用户是否已关注该俱乐部、是否已加入该俱乐部。
		// 当前用户是否是其他俱乐部队长，若是则展示挑战按钮，隐藏申请加入按钮；
		// 若不是，判断该用户是否已加入其他俱乐部，若没有加入，显示申请加入按钮
		if (StringUtils.isNotBlank(login_user_id)&& !login_user_id.equals(user_id)) {
			Visitor visitor = visitorService.getVisitor(login_user_id, team_info.getId(),"1");
			if(visitor == null){
				visitor = new Visitor();
				visitor.setId(UUIDGenerator.getUUID());
				visitor.setP_visitor_id(team_info.getId());
				visitor.setVisitor_id(login_user_id);
				visitor.setVisit_time(new Date());
				visitor.setVisit_url(VISTORTYPE.CLUB.toString());
				visitor.setVisit_type("1");
				visitor.setT_visit_count(1);
				visitor.setVisit_count(1);
				visitorService.save(visitor);
			}else{
				visitor.setT_visit_count(visitor.getT_visit_count()+1);
				visitor.setVisit_count(visitor.getVisit_count()+1);
				visitorService.update(visitor);
			}
			
			TeamInfo login_ti = teamInfoService.getTeamInfoByUserId(login_user_id);
			if (login_ti != null) {// 不为null,说明该登录用户是俱乐部队长
				model.addAttribute("is_team", Boolean.TRUE);
				model.addAttribute("fq_login_ti", login_ti);// 发起挑战俱乐部
				// 判断是否与该俱乐部正在约战中
				TeamInvite team_inv = teamInviteService.getInviteByTeam(login_ti.getId(), team_info.getId());
				if (team_inv != null)
					model.addAttribute("is_invite", Boolean.TRUE);

			} else {
				// 判断当前登录用户是否已加入该俱乐部
				TeamPlayer tp = teamInfoService.getTeamPlayerInfoByIds(login_user_id, team_info.getId());
				if (tp != null) {// 不为null,说明该用户已经加入该俱乐部
					model.addAttribute("is_join", Boolean.TRUE);
				}
			}
			//判断该用户是否是本俱乐部队长
			if(login_user_id.equals(team_info.getUser_id())){
				Map<String,Object> map = Maps.newHashMap();
				map.put("teaminfo_id", team_info.getId());
				map.put("status","1");
				AjaxMsg msg = babyInService.queryBabyTeamForMap(map, new PageModel());
				model.addAttribute("babyTeams", msg.getData("page"));
				TeamLeague teamLeague = leagueService.getTeamLeague(team_info.getId());
				model.addAttribute("teamLeague", teamLeague);
			}
			// 判断当前用户是否关注该俱乐部
			Focus focus = userService.getFocusByIds(login_user_id, team_info.getId());
			if (focus != null) {// 该用户已经关注该俱乐部
				model.addAttribute("is_focus", Boolean.TRUE);
			}
		} else {
			AjaxMsg msg = userService.getFocusUsersNoPage(user_id);
			model.addAttribute("players", msg.getData("data"));
		}
		Map<String, Object> re_map = teamInfoService.getTeamAbilityScore(team_info.getId());
		model.addAttribute("re_map", re_map);
		//return "team/team_details";
		return "team/team_newDetails";
	}
	
	/**
	 * 通过俱乐部ID进入俱乐部主页
	 * @param model
	 * @param request
	 * @param user_id
	 * @return
	 */
	@RequestMapping(value = "tdetail/{team_id}")
	public String teamDeatailPageByTeam(Model model, HttpServletRequest request,@PathVariable String team_id) {
		String login_user_id = super.getUserId();// 当前登录者用户ID
		TeamInfo team_info = teamInfoService.getEntityById(team_id);
		//update by bo.xie 个人账户转俱乐部账户	start
//		AjaxMsg msg_user = userAmountService.getByUserId(team_info.getUser_id());
//		model.addAttribute("userAmount",msg_user.getData("data"));
		UserAmount userAmount = userAmountService.getUserAmountByTeamInfoID(team_info.getId());
		model.addAttribute("userAmount",userAmount);
		//update by bo.xie 个人账户转俱乐部账户	end
		int playerCount = teamInfoService.teamPlayerCount(team_id);
		int babyCount = teamInfoService.teamBabyCount(team_info.getId());
		int priceCount = teamInfoService.teamPlayerPrice(team_info.getId());
		model.addAttribute("priceCount",priceCount);
		model.addAttribute("playerCount",playerCount);
		model.addAttribute("babyCount",babyCount);
		if (team_info == null) {
			// 没有就到404
			return "error/404";
		}		
		String user_id = team_info.getUser_id();
		model.addAttribute("user_id", user_id);
		model.addAttribute("team", team_info);
		//added by bo.xie 判断该俱乐部是否报名联赛start
		Boolean tl_flag = Boolean.FALSE;//为加入联赛
		TeamLeague tl= leagueService.getTeamLeague(team_info.getId());
		if(null!=tl)tl_flag = Boolean.TRUE;
		model.addAttribute("tl_flag", tl_flag);
		//added by bo.xie 判断该俱乐部是否报名联赛end
		

		// 若当前登录者id与俱乐部user_id不相等，需要判断当前用户是否已关注该俱乐部、是否已加入该俱乐部。
		// 当前用户是否是其他俱乐部队长，若是则展示挑战按钮，隐藏申请加入按钮；
		// 若不是，判断该用户是否已加入其他俱乐部，若没有加入，显示申请加入按钮
		if (StringUtils.isNotBlank(login_user_id) && !login_user_id.equals(user_id)) {
			Visitor visitor = visitorService.getVisitor(login_user_id, team_info.getId(),"1");
			if(visitor == null){
				visitor = new Visitor();
				visitor.setId(UUIDGenerator.getUUID());
				visitor.setP_visitor_id(team_info.getId());
				visitor.setVisitor_id(login_user_id);
				visitor.setVisit_time(new Date());
				visitor.setVisit_url(VISTORTYPE.CLUB.toString());
				visitor.setVisit_type("1");
				visitor.setT_visit_count(1);
				visitor.setVisit_count(1);
				visitorService.save(visitor);
			}else{
				visitor.setT_visit_count(visitor.getT_visit_count()+1);
				visitor.setVisit_count(visitor.getVisit_count()+1);
				visitorService.update(visitor);
			}
			
			TeamInfo login_ti = teamInfoService.getTeamInfoByUserId(login_user_id);
			if (login_ti != null) {// 不为null,说明该登录用户是俱乐部队长
				model.addAttribute("is_team", Boolean.TRUE);
				model.addAttribute("fq_login_ti", login_ti);// 发起挑战俱乐部
				// 判断是否与该俱乐部正在约战中
				TeamInvite team_inv = teamInviteService.getInviteByTeam(login_ti.getId(), team_info.getId());
				if (team_inv != null)
					model.addAttribute("is_invite", Boolean.TRUE);

			} else {
				// 判断当前登录用户是否已加入该俱乐部
				TeamPlayer tp = teamInfoService.getTeamPlayerInfoByIds(login_user_id, team_info.getId());
				if (tp != null) {// 不为null,说明该用户已经加入该俱乐部
					model.addAttribute("is_join", Boolean.TRUE);
				}
			}
			//判断该用户是否是本俱乐部队长
			if(login_user_id.equals(team_info.getUser_id())){
				Map<String,Object> map = Maps.newHashMap();
				map.put("teaminfo_id", team_info.getId());
				map.put("status","1");
				AjaxMsg msg = babyInService.queryBabyTeamForMap(map, new PageModel());
				model.addAttribute("babyTeams", msg.getData("page"));
				TeamLeague teamLeague = leagueService.getTeamLeague(team_info.getId());
				model.addAttribute("teamLeague", teamLeague);
			}
			// 判断当前用户是否关注该俱乐部
			Focus focus = userService.getFocusByIds(login_user_id, team_info.getId());
			if (focus != null) {// 该用户已经关注该俱乐部
				model.addAttribute("is_focus", Boolean.TRUE);
			}
		} else {
			AjaxMsg msg = userService.getFocusUsersNoPage(user_id);
			model.addAttribute("players", msg.getData("data"));
		}
		Map<String, Object> re_map = teamInfoService.getTeamAbilityScore(team_info.getId());
		model.addAttribute("re_map", re_map);
		return "team/team_newDetails";
	}
	
	@RequestMapping(value = "dissolve")
	public @ResponseBody String dissolveTeam(HttpServletRequest request) {
		String user_id = super.getUserId();
		String team_id = request.getParameter("team_id");// 获取俱乐部ID
		AjaxMsg msg = AjaxMsg.newError();
		try {
			msg = teamInfoService.dissolveTeam(user_id,team_id,request);
		} catch (Exception e) {
			return "error/404";
		}
		return msg.toJson();
	}

	/**
	 * 俱乐部发送好友邀请
	 * 
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-8-5下午4:11:19
	 */
	@RequestMapping(value = "sendJoinMsg")
	@ResponseBody
	public String sendJoinMsg(HttpServletRequest request) {
		String players = request.getParameter("players");
		String teaminfo_name = request.getParameter("teaminfo_name");
		String teaminfo_id = request.getParameter("teaminfo_id");
		if(StringUtils.isBlank(players)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.noapply")).toJson();
		String[] ids = players.split(",");
		AjaxMsg msg = AjaxMsg.newSuccess();
		String user_id = super.getUserId();
		try {
			if (ids.length > 0) {
				for (String playerId : ids) {
						messageResourceService.saveMessage(new Object[]{teaminfo_name},
								SystemEnum.SYSTYPE.TTPA.toString(), "user.team.request", playerId, teaminfo_id, teaminfo_id,3);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.addMessage(messageResourceService.getMessage("system.success")).toJson();
	}

	/**
	 * 历史比赛记录
	 * 
	 * @param model
	 * @param request
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-9-11下午4:18:24
	 */
	@RequestMapping(value = "hisGames")
	public String historyGames(Model model, HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");
		model.addAttribute("teaminfo_id", teaminfo_id);
		return "team/game/his_games";
	}

	/**
	 * 历史比赛记录数据
	 * @param model
	 * @param request
	 * @return
	 * @autor bo.xie
	 * @parameter *
	 * @date2015-9-11下午4:43:12
	 */
	@RequestMapping(value = "gameDatas")
	public String game_datas(Model model, HttpServletRequest request, PageModel pageModel) {
		String oth_user_id = request.getParameter("oth_user_id");//第三方用户ID
		String teaminfo_id = request.getParameter("teaminfo_id");
		String type = request.getParameter("type");
//		AjaxMsg msg = teamInfoService
//				.loadHistoryTeamGame(StringUtils.isNotBlank(teaminfo_id) ? teaminfo_id : null, pageModel);
		if(StringUtils.isNotBlank(teaminfo_id)){
			AjaxMsg msg = teamInviteService.historyGameMap(teaminfo_id,new Integer(1),pageModel);
			if (msg.isSuccess()) {
				model.addAttribute("rf", msg.getData("data"));
			}
		}
		model.addAttribute("teaminfo_id", teaminfo_id);
		model.addAttribute("type", type);
		model.addAttribute("oth_user_id", oth_user_id);
		return "team/game/new_game_datas";
		//return "team/game/game_datas";
	}
	
	/**
	 * 更多比赛历程
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="gameLists")
	public String gameDataListPage(Model model, HttpServletRequest request, PageModel pageModel){
		String teaminfo_id = request.getParameter("teaminfo_id");
		String user_id = request.getParameter("other_user_id");
		model.addAttribute("teaminfo_id", teaminfo_id);
		model.addAttribute("user_id", user_id);
		TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
		model.addAttribute("teamInfo", teamInfo);
		return "team/game/game_datas_list";
	}

	/**
	 * 俱乐部成员列表
	 * 
	 * @param model
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-9-11下午4:43:12
	 */
	@RequestMapping(value = "playerList")
	public String playerList(HttpServletRequest request, PageModel pageModel) {
		String teaminfo_id = request.getParameter("teaminfo_id");
		if (StringUtils.isBlank(teaminfo_id))
			return AjaxMsg.newError().addMessage("球队不存在").toJson();
		TeamInfo teamInfo =  teamInfoService.getEntityById(teaminfo_id);
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("teaminfo_id", teaminfo_id);
		AjaxMsg msg = teamInfoService.getTeamPlayerList(maps,null);
		AjaxMsg loanmsg = teamLoanPlayerService.queryForPageForMap(maps, null);
		request.setAttribute("team_players", msg.getData("page"));
		request.setAttribute("team_loan_players", loanmsg.getData("page"));
		request.setAttribute("user_id", teamInfo.getUser_id());
		request.setAttribute("teaminfo_id", teaminfo_id);
		System.out.println(msg.toJson());
		return "team/player/teamplayerlist";
	}
	
	/**
	 * 取消副队长资格
	 * @param model
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-9-11下午4:43:12
	 */
	@RequestMapping(value = "cancelRole")
	@ResponseBody
	public String cancelRole(HttpServletRequest request) {
		String player_id = request.getParameter("player_id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		AjaxMsg msg = AjaxMsg.newSuccess();
		if (StringUtils.isBlank(player_id) || StringUtils.isBlank(teaminfo_id)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nopandt")).toJson();
		try {
			msg = teamInfoService.checkCaptain(teaminfo_id, player_id, 3, request);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		
		return msg.toJson();
	}
	
	/**
	 * 编辑公告
	 * @param model
	 * @param request
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-9-11下午4:43:12
	 */
	@RequestMapping(value = "editNotice")
	@ResponseBody
	public String editNotice(HttpServletRequest request) {
		String teaminfo_id = request.getParameter("teaminfo_id");
		String notice = request.getParameter("notice");
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = teamInfoService.updateNotice(teaminfo_id, notice.trim());
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 俱乐部购买激活码
	 * @return
	 */
	@RequestMapping(value="buyCode")
	public @ResponseBody String buyActiveCodeForPlayer(HttpServletRequest request){
		String user_id = super.getUserId();
		//俱乐部ID
		String teaminfo_id = request.getParameter("teaminfo_id");
		//激活码单价
		String price = request.getParameter("price");
		String count = request.getParameter("count");
		String total = request.getParameter("total");
		String league_id = request.getParameter("league_id");
		
		if(StringUtils.isBlank(price)||StringUtils.isBlank(count)||StringUtils.isBlank(teaminfo_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		if(Integer.valueOf(total) > Integer.valueOf(count)) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.upcode")).toJson();
		
		AjaxMsg msg = teamInfoService.buyActiveCode(price, user_id, teaminfo_id,Integer.valueOf(total),league_id);
		return msg.toJson();
	}
	
	/**
	 * 俱乐部购买激活码
	 * @return
	 */
	@RequestMapping(value="toBuyCode")
	public String toBuyCode(Model model,HttpServletRequest request){
		String user_id = super.getUserId();
		//俱乐部ID
		String teaminfo_id = BeanUtils.nullToString(request.getParameter("teaminfo_id"));
		//获取俱乐部当前所在联赛
		TeamLeague teamLeague = leagueService.getTeamLeague(teaminfo_id);
		if(teamLeague != null ){
			ActiveCode activeCode = activeCodeService.getActiveCodeByTeam(teamLeague.getLeague_id(),teaminfo_id);
			//获取俱乐部当前联赛邀请码数量
			List<TeamActiveCode> codeList = teamInfoService.getTeamActiveCodeByLeague(teaminfo_id,teamLeague.getLeague_id());
			//update by bo.xie 个人账户转俱乐部账户	start
			UserAmount userAmount = userAmountService.getUserAmountByTeamInfoID(teaminfo_id);
			model.addAttribute("userAmount",userAmount);
			//update by bo.xie 个人账户转俱乐部账户	end
			int count = activeCode.getCode_count();
			if(!codeList.isEmpty()){
				 count = count - codeList.size();
			}
			model.addAttribute("count",count);
			model.addAttribute("codeList",codeList);
			model.addAttribute("league_id",teamLeague.getLeague_id());
			model.addAttribute("activeCode",activeCode);
		}
		model.addAttribute("teaminfo_id",teaminfo_id);
		return "team/code/buycode";
	}
	
	/**
	 * 查询俱乐部图片或视频
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="queryTeamImages")
	@ResponseBody
	public String queryTeamImages(HttpServletRequest request,PageModel pageModel){
		String team_id = request.getParameter("team_id");
		String type = request.getParameter("type");
		String uid = getUserId();
		int isme = 0;
		AjaxMsg msg = AjaxMsg.newError();
		try {
			if(StringUtils.isNotBlank(team_id)){
				TeamInfo team = teamInfoService.getEntityById(team_id);
				if(team!=null){
					if(StringUtils.isNotBlank(team.getUser_id())&&uid!=null&&(uid.equals(team.getUser_id()))){
						isme = 1;
					}
					ImageVideo iv = new ImageVideo();
					iv.setLogin_user_id(uid);
					iv.setUser_id(team_id);
					iv.setRole_type(SystemEnum.IMAGE.TEAM.toString());
					iv.setF_status(1);
					iv.setType(type);
					msg = imageVideoService.searchImageVideos(iv, pageModel);
				}
			}
			msg.addData("isme", isme);
			return msg.toJson();
		} catch (Exception e) {
			msg.addData("isme", isme);
			return msg.toJson();
		}
	}
	
	@RequestMapping(value="/showCenter")
	@ResponseBody  
	public String showCenter(HttpServletRequest request){
		String team_id = request.getParameter("team_id");
		String id = request.getParameter("id");
		String type = request.getParameter("type");
		String state = request.getParameter("state");
		AjaxMsg msg = imageVideoService.updateShowCenter(team_id,id,type,state);
		return msg.toJson();
	}
	
	/**
	 * 加载公告信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/loadNotice")
	public String loadNotice(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = Maps.newHashMap();
		String teaminfo_id = request.getParameter("teaminfo_id");
		params.put("teaminfo_id", teaminfo_id);
		AjaxMsg msg = teamInfoService.queryNoticeForPage(params,pageModel);
		request.setAttribute("notices", msg.getData("page"));
		return "team/notice/notice";
	}
	
	/**
	 * 加载公告信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/showNotice")
	public String showNotice(HttpServletRequest request){
		String id = request.getParameter("id");
		String tid = request.getParameter("teaminfo_id");
		String uid = getUserId();
		int isme = 0;
		TeamNotice teamNotice = new TeamNotice();
		teamNotice = teamInfoService.getNoticeById(id);
		teamNotice.setCheck_count(teamNotice.getCheck_count()+1);
		teamNotice.setSort(1);
		try {
			teamInfoService.updateTeamNotice(teamNotice);
		} catch (Exception e) {
			e.printStackTrace();
		}
		TeamInfo team = teamInfoService.getEntityById(tid);
		if(team!=null){
			if(StringUtils.isNotBlank(team.getUser_id())&&uid!=null&&(uid.equals(team.getUser_id()))){
				isme = 1;
			}
		}
		request.setAttribute("isme", isme);
		request.setAttribute("notice", teamNotice);
		return "team/notice/showNotice";
	}
	
	/**
	 * 添加公告页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addNoticePage")
	public String addNoticePage(HttpServletRequest request){
		String id = request.getParameter("id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		TeamNotice teamNotice = new TeamNotice();
		teamNotice = teamInfoService.getNoticeById(id);
		request.setAttribute("notice", teamNotice);
		request.setAttribute("teaminfo_id", teaminfo_id);
		return "team/notice/addNotice";
	}
	
	/**
	 * 添加公告页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveNotice")
	@ResponseBody
	public String saveNotice(HttpServletRequest request,TeamNotice teamNotice){
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			if(StringUtils.isBlank(teamNotice.getId())){
				msg = teamInfoService.saveTeamNotice(teamNotice);
			}else{
				msg = teamInfoService.updateTeamNotice(teamNotice);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}	
		return msg.toJson();
	}
	/**
	 * <p>Description:加载通知列表 </p>
	 * @Author zhangwei
	 * @Date 2015年12月2日 下午2:36:01
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="/loadNoticeList")
	public String loadNoticeList(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = Maps.newHashMap();
		String team_id = request.getParameter("team_id");
		params.put("teaminfo_id", team_id);
		AjaxMsg msg = teamInfoService.queryNoticeForPage(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "team/notice/noticelist";
	}
	
	@RequestMapping(value="/deleteNotice")
	@ResponseBody
	public String deleteNotice(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = teamInfoService.deleteNotice(id);
		return msg.toJson();
	}
	
	/**
	 * 俱乐部详情视频
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/videos")
	public String team_videos(HttpServletRequest request){
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		request.setAttribute("user_img", user_img);
		return "team/videos";
	}
	
	/**
	 * 跳转球衣号码选择界面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toNumPage")
	public String toNumPage(HttpServletRequest request){
		String teaminfo_id = BeanUtils.nullToString(request.getParameter("teaminfo_id"));
		String loanPlayer = BeanUtils.nullToString(request.getParameter("loanPlayer"));
		if(StringUtils.isNotBlank(loanPlayer)){
			String id = BeanUtils.nullToString(request.getParameter("id"));
			TeamLoanPlayer teamLoanPlayer = teamLoanPlayerService.getEntityById(id);
			request.setAttribute("teamLoanPlayer", teamLoanPlayer);
		}else{
			String user_id = BeanUtils.nullToString(request.getParameter("user_id"));
			TeamPlayer teamPlayer = teamInfoService.getTeamPlayerByUserId(user_id);
			request.setAttribute("teamPlayer", teamPlayer);
		}
		request.setAttribute("teaminfo_id", teaminfo_id);
		return "team/player/player_num";
	}
	
	/**
	 * 修改球衣号码
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/updateNum")
	@ResponseBody
	public String updateNum(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String id = request.getParameter("id");
		String num = request.getParameter("num");
		String type = request.getParameter("type");
		try {
			if(type.equals("loan")){	
				msg = teamLoanPlayerService.updateNum(id,Integer.parseInt(num));
			}else{
				msg = teamInfoService.updateNum(id,Integer.parseInt(num));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * <p>Description: 俱乐部精彩图片</p>
	 * @Author zhangwei
	 * @Date 2015年11月30日 下午5:00:56
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/images")
	public String images(HttpServletRequest request,ImageVideo iv,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		String uid = getUserId();
		iv.setLogin_user_id(uid);
		int isme = 0;
		TeamInfo team = teamInfoService.getEntityById(iv.getUser_id());
		AjaxMsg msg = AjaxMsg.newError();
		if(team!=null){
			if(StringUtils.isNotBlank(team.getUser_id())&&uid!=null&&(uid.equals(team.getUser_id()))){
				isme = 1;
			}
			iv.setF_status(1);
			msg = imageVideoService.searchImageVideos(iv, pageModel);
		}
		params.put("isme", isme);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "team/team_images"; 
	}
	
	/**
	 * Description: 跳转球员出售界面
	 * @Author ylt
	 * @Date 2015年11月30日 下午5:00:56
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toSellPage")
	public String toSellPage(HttpServletRequest request){
		String id = request.getParameter("id");
		Map<String,Object> maps = teamInfoService.getTeamPlayerMap(id);
		String user_id = BeanUtils.nullToString(maps.get("user_id"));
		if(StringUtils.isNotBlank(user_id)){  
			LeagueMarket leagueMarket = leagueMarketService.getMarketUser(user_id, 0);
			request.setAttribute("leagueMarket", leagueMarket);
		}
		request.setAttribute("player", maps);
		return "team/player/player_sell"; 
	}
	
	/**
	 * 判断是否是联赛俱乐部
	 * @param request
	 * @return
	 */
	@RequestMapping(value="isLeagueTeam")
	public @ResponseBody String isLeagueTeam(HttpServletRequest request){
		String id = request.getParameter("id");
		Map<String,Object> maps = teamInfoService.getTeamPlayerMap(id);
		if(null==maps)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		
		String teaminfo_id = String.valueOf(maps.get("teaminfo_id"));
		
		TeamLeague tl = leagueService.getTeamLeague(teaminfo_id);
		if(tl==null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.team_sale")).toJson();
		
		return AjaxMsg.newSuccess().toJson();
	}
	
	
	/**
	 * Description: 球员出售
	 * @Author ylt
	 * @Date 2015年11月30日 下午5:00:56
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/sellPlayer")
	@ResponseBody
	public String sellPlayer(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		String price = request.getParameter("price");
		String if_one = BeanUtils.nullToString(request.getParameter("if_one"));
		Map<String,Object> param = Maps.newHashMap();
		param.put("user_id", user_id);
		param.put("price", price);
		param.put("if_one", if_one);
		try {
			return teamInfoService.salePlayer(param).toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
	}
	
	/**
	 * 取消挂牌
	 * @param request
	 * @return
	 */
	@RequestMapping(value="cancelSale")
	public @ResponseBody String cancelSalePlayer(HttpServletRequest request){
		String id = request.getParameter("id");
		Map<String,Object> param = Maps.newHashMap();
		param.put("id", id);
		return teamInfoService.cancelSalePlayer(param).toJson();
	}

	/**
	 * 奖金发放
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wage")
	public String wagePage(HttpServletRequest request){
		String login_user_id = super.getUserId();// 当前登录者用户ID
		String teaminfo_id = request.getParameter("teaminfo_id");
		
		TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
		if(teamInfo.getUser_id().equals(login_user_id)){
			request.setAttribute("teamManage", true);
			//update by bo.xie 个人账户转俱乐部账户 start
				//UserAmount ua = userAmountService.getUserAmountByUserId(login_user_id);
			UserAmount ua =userAmountService.getUserAmountByTeamInfoID(teaminfo_id);
			//update by bo.xie 个人账户转俱乐部账户 end
			request.setAttribute("userAmount", ua);
		}
		
		
		List<TeamPlayerWage> _plist = teamInfoService.getTeamPlayer(teaminfo_id);
		request.setAttribute("_plist", _plist);
		request.setAttribute("teaminfo_id", teaminfo_id);
		return "team/team_wage";
	}
	
	/**
	 * 更新球员工资表
	 * @param request
	 * @param pjson
	 * @return
	 */
	@RequestMapping(value="/wagePayrollSave")
	@ResponseBody
	public String wagePayrollSave(HttpServletRequest request,@RequestBody String pjson){
		String login_user_id = super.getUserId();// 当前登录者用户ID
		if(login_user_id==null){
			return AjaxMsg.newError().addMessage("未登录").toJson(); 
		}
		
		Map<String,String> map = JSONUtils.json2Map(pjson);
		map.put("login_user_id", login_user_id);
		
		return teamInfoService.wagePayrollSave(map).toJson();
	}
	/**
	 * 确认发送
	 * @param request
	 * @param pjson
	 * @return
	 */
	@RequestMapping(value="/wagePayrollSend")
	@ResponseBody
	public String wagePayrollSend(HttpServletRequest request,@RequestBody String pjson){
		String login_user_id = super.getUserId();// 当前登录者用户ID
		if(login_user_id==null){
			return AjaxMsg.newError().addMessage("未登录").toJson(); 
		}
		
		Map<String,String> map = JSONUtils.json2Map(pjson);
		map.put("login_user_id", login_user_id);
		try{
			return teamInfoService.wagePayrollSend(map).toJson();
		}catch(Exception e){
			logger.error("=================send salary error======================");
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson(); 
		}
		
	}
	/**
	 * 新工资表
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wagePayroll")
	public String wagePayroll(HttpServletRequest request){
		String login_user_id = super.getUserId();// 当前登录者用户ID
		String teaminfo_id = request.getParameter("teaminfo_id");
		String event_id = request.getParameter("event_id");
		List<WagePlayerVO> wpList = new ArrayList<WagePlayerVO>();
		WagePayrollVO wagePayroll = new WagePayrollVO();
		
		TeamInfo teamInfo = teamInfoService.getEntityById(teaminfo_id);
		if(teamInfo.getUser_id().equals(login_user_id)){
			request.setAttribute("teamManage", true);
			UserAmount ua =userAmountService.getUserAmountByTeamInfoID(teaminfo_id);
			request.setAttribute("userAmount", ua);
		}
		request.setAttribute("sendStatus", true);
		SalaryMsg salaryMsg = null;
		
		
		List<SalaryMsg> salaryMsgList = leagueService.getSalaryMsg(event_id, teaminfo_id);//查询俱乐部工资表
		if(salaryMsgList.size()>0){
			salaryMsg = salaryMsgList.get(0);
		}
		if(salaryMsg!=null){
			League league = leagueService.getEntityById(salaryMsg.getLeague_id());//查询联赛名称
			AdminEventRecord ff = eventRecordService.getEntityById(event_id);//查询赛事信息
			if(league!=null){
				wagePayroll.setSeason(league.getName());
			}
			if(salaryMsg.getStatus()==0){
				request.setAttribute("sendStatus", false);
			}
			
			wagePayroll.setRound("第"+ff.getRounds()+"轮");
			wagePayroll.setDynamic_id("");
			wagePayroll.setSalary_msg_id(salaryMsg.getId());
			wagePayroll.setHome_team_id(ff.getM_teaminfo_id());
			wagePayroll.setHome_team_name(ff.getM_team_name());
			wagePayroll.setHome_team_score(""+ff.getM_score());
			wagePayroll.setVisiting_team_score(""+ff.getG_score());
			wagePayroll.setVisiting_team_name(ff.getG_team_name());
			wagePayroll.setVisiting_team_id(ff.getG_teaminfo_id());
			wagePayroll.setHome_team_src("/resources/images/08(50x50).png");
			wagePayroll.setVisiting_team_src("/resources/images/08(50x50).png");

			TeamInfo hTeamInfo = teamInfoService.getEntityById(ff.getM_teaminfo_id());
			if(hTeamInfo!=null&&Common.isNotEmpty(hTeamInfo.getLogo())){
				wagePayroll.setHome_team_src(FileUtilsTag.headPath()+hTeamInfo.getLogo());
			}
			TeamInfo vTeamInfo = teamInfoService.getEntityById(ff.getG_teaminfo_id());
			if(vTeamInfo!=null&&Common.isNotEmpty(vTeamInfo.getLogo())){
				wagePayroll.setVisiting_team_src(FileUtilsTag.headPath()+vTeamInfo.getLogo());
			}
			
			List<SalaryRecord> salaryRecordList = leagueService.getSalaryRecord(salaryMsg.getId());//查询应发工资成员表
			List<TeamPlayer> teamPlayerList = teamInfoService.getTeamPlayersByTeamInfoId(teaminfo_id);//俱乐部查询球员
			List<QUserData> qUserDataList = leagueService.getQuserData(event_id);//查询联赛统计信息
			BigDecimal base_sum =new BigDecimal(0);
			BigDecimal bonus_sum =new BigDecimal(0);
			for(SalaryRecord sr:salaryRecordList){
				WagePlayerVO wagePlayerVO = new WagePlayerVO();
				wagePlayerVO.setId(sr.getId());
				wagePlayerVO.setPlayer_id(sr.getUser_id());
				wagePlayerVO.setWages_should(sr.getSalary());
				wagePlayerVO.setBonus_amount(sr.getBonus());
				
				if(wagePlayerVO.getBonus_amount()!=null)bonus_sum = bonus_sum.add(wagePlayerVO.getBonus_amount());
				if(wagePlayerVO.getWages_should()!=null)base_sum = base_sum.add(wagePlayerVO.getWages_should());
				
				User user = userService.getEntityById(wagePlayerVO.getPlayer_id());//查询球员姓名
				wagePlayerVO.setPlayer_name(user.getUsername());
				
				for(TeamPlayer tp:teamPlayerList){
					if(wagePlayerVO.getPlayer_id().equals(tp.getUser_id())){
						wagePlayerVO.setUniform_number(tp.getPlayer_num());
					}
				}
				for(QUserData qu:qUserDataList){
					if(wagePlayerVO.getPlayer_id().equals(qu.getRel_palyer_id())){
						wagePlayerVO.setPlaying_time(qu.getDurtime());
						wagePlayerVO.setGoal_number(""+qu.getJinqiu_num());
					}
				}
				
				
				wagePlayerVO.setTotal_distribution(0);
				wpList.add(wagePlayerVO);
			}
			wagePayroll.setPlayer_count(""+wpList.size());
			wagePayroll.setWage_base_sum(base_sum.toString());
			wagePayroll.setWage_bonus_sum(bonus_sum.toString());
		}else{
			wagePayroll.setSeason("...");
			wagePayroll.setRound("...");
			wagePayroll.setDynamic_id("");
			wagePayroll.setHome_team_id("");
			wagePayroll.setHome_team_name("...");
			wagePayroll.setHome_team_score("0");
			wagePayroll.setHome_team_src("/resources/images/08(50x50).png");
			wagePayroll.setVisiting_team_src("/resources/images/08(50x50).png");
			wagePayroll.setVisiting_team_score("0");
			wagePayroll.setVisiting_team_name("...");
			wagePayroll.setVisiting_team_id("");

			WagePlayerVO wagePlayerVO = new WagePlayerVO();
			wagePlayerVO.setBonus_amount(null);
			wagePlayerVO.setGoal_number("-");
			wagePlayerVO.setPlayer_id("-");
			wagePlayerVO.setPlayer_name("..");
			wagePlayerVO.setPlaying_time("..");
			wagePlayerVO.setTotal_distribution(0);
			wagePlayerVO.setUniform_number("..");
			wagePlayerVO.setWages_should(null);
			wpList.add(wagePlayerVO);
		}
		
		
		request.setAttribute("wagePlayerList", wpList);
		request.setAttribute("wagePayroll", wagePayroll);
		request.setAttribute("teaminfo_id", teaminfo_id);
		return "team/team_payroll";
	}
	

	@RequestMapping(value="/wageSave")
	@ResponseBody
	public String wageSave(HttpServletRequest request,@RequestBody String pjson){
		String login_user_id = super.getUserId();// 当前登录者用户ID
		if(login_user_id==null){
			return AjaxMsg.newError().addMessage("未登录").toJson(); 
		}
		
		Map<String,String> map = JSONUtils.json2Map(pjson);
		map.put("login_user_id", login_user_id);
		
		return teamInfoService.wageSave(map).toJson();
	}
	
	/**
	 * 宝贝窗口
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/openGameBaby")
	public String openGameBaby(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		String teaminfo_id = request.getParameter("teaminfo_id");
		BabyInfo babyInfo = babyService.getBabyInfoByUserId(user_id);
		AjaxMsg msg = teamInviteService.allMatchGame(teaminfo_id);
		User user = userService.getEntityById(user_id);
		request.setAttribute("teaminfo_id", teaminfo_id);
		request.setAttribute("babyInfo", babyInfo);
		request.setAttribute("user", user);
		request.setAttribute("listGame", msg.getData("matchGames"));
		return "team/baby/cheerbaby";
	}
	
	/**
	 * 平台用户为俱乐部账户充值
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="payForTeam")
	public @ResponseBody String payRecordTeam(Model model,HttpServletRequest request) throws Exception{
		String user_id =super.getUserId();
		String teaminfo_id = request.getParameter("teaminfo_id");
		String amount = request.getParameter("amount");
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(teaminfo_id)||StringUtils.isBlank(amount))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("teaminfo_id", teaminfo_id);
		maps.put("amount", amount);
		AjaxMsg msg = teamInfoService.payForTeam(maps);
		return msg.toJson();
	}
	
	/**
	 * 俱乐部充值前十条信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="tamount")
	public @ResponseBody String teamAmountDeatail(HttpServletRequest request){
		String teaminfo_id = request.getParameter("teaminfo_id");
		UserAmount userAmount = userAmountService.getUserAmountByTeamInfoID(teaminfo_id);
		Map<String,Object> params = Maps.newHashMap();
		params.put("teaminfo_id", teaminfo_id);
		List<Map<String,Object>> re_tAmounts = userAmountService.loadAmountDetail(params);
		return AjaxMsg.newSuccess().addData("datas", re_tAmounts).addData("teamSumAmount", userAmount).toJson();
	}
	
	/**
	 * 检测俱乐部名和简称是否重名
	 * @param request
	 * @return
	 */
	@RequestMapping(value="checkTeamNameAgain")
	@ResponseBody
	public String checkTeamNameAgain(HttpServletRequest request){
		String user_id = getUserId();
		String name = request.getParameter("name");
		String sim_name = request.getParameter("sim_name"); 
		TeamInfo team = teamInfoService.getTeamInfoByUserId(user_id);
		if(StringUtils.isNotBlank(name)){
			TeamInfo old_ti = teamInfoService.getEntityById(team.getId());
			if(StringUtils.isNotBlank(name)&&!old_ti.getName().equals(name)){
				int count = teamInfoService.teamExistByTeamName(name);
				if(count>0) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.names")).toJson();	
			}
		}else if(StringUtils.isNotBlank(sim_name)){
			AjaxMsg msg =  teamInfoService.checkSimNameAgain(sim_name,team.getId());
			if(msg.isError()){return msg.toJson(); }
		}
		return AjaxMsg.newSuccess().toJson();
	}
	
	/**
	 * 修改俱乐部名字
	 * @param request
	 * @return
	 */
	@RequestMapping(value="changeTeamName")
	@ResponseBody
	public String changeTeamName(HttpServletRequest request){
		String user_id = getUserId();
		String name = request.getParameter("name");
		String sim_name = request.getParameter("sim_name"); 
		TeamInfo team = teamInfoService.getTeamInfoByUserId(user_id);
		team.setName(name);
		team.setSim_name(sim_name);
		AjaxMsg msg = teamInfoService.updateTeamName(team);
		return msg.toJson();
	}
	
	@RequestMapping(value="teamPayHtml")
	@ResponseBody
	public String teamPayHtml(HttpServletRequest request){
		String user_id = getUserId();
		TeamInfo team = teamInfoService.getTeamInfoByUserId(user_id);
		request.setAttribute("team", team);
		return "team/team_pay";
	}
	
}
