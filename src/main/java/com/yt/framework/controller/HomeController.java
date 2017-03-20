package com.yt.framework.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.persistent.entity.News;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserRole;
import com.yt.framework.service.BabyService;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.IndexService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageRecordsService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserProductService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.tag.FileUtilsTag;

/**
 *
 *@autor bo.xie
 *@date2015-7-21下午2:31:28
 */
@Controller
public class HomeController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(HomeController.class);
	
	@Autowired
	private DynamicService dynamicService;
	@Autowired
	private MessageRecordsService messageRecordsService;
	@Autowired
	private UserProductService userProductService;
	@Autowired
	private TeamInviteService teamInviteService;
	@Autowired
	private BabyService baseService;
	@Autowired
	private LeagueService leagueService;
	//new 
	@Autowired
	private IndexService indexService;
	
	@Autowired
	private ImageVideoService imageVideoService;
	@Autowired
	private UserAmountService userAmountService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private PlayerInfoService playerInfoService;
	
	
	/**
	 * 首页
	 * @autor gl
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/")
	public String index(HttpServletRequest request){
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		List<League> leagueList = leagueService.getLeagues();
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("if_use", "1");
		List<Map<String, Object>> banners = indexService.queryIndexBanners(params);
		//中奖列表
		List<Map<String, Object>> win_users = userProductService.queryWinUsers();
		//账号宇贝
		String user_id = (String) Common.getCurrentSessionValue(request, "session_user_id");
		logger.info("user_id-----"+user_id);
		if(user_id==null||user_id.length()==0){
			request.setAttribute("real_amount", 0);
		}else{
			UserAmount uas = userAmountService.getUserAmountByUserId(user_id);
			request.setAttribute("real_amount", uas.getReal_amount().longValue());
		}
		//总比赛场数
		int leagueRecords = leagueService.queryLeagueRecords();
		//总比赛场数
		int teamRecords = teamInfoService.queryTeamRecords();
		//球员人数
		int playerRecords = playerInfoService.queryPlayerRecords();
		//商品人数
		int productRecords = userProductService.queryProductRecords();
		//首页视频list
		List<ImageVideo> imageVideoList= imageVideoService.queryIndexVideo();
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(ImageVideo imageVideo : imageVideoList){
			imageVideo.setF_src(FileUtilsTag.headPath()+imageVideo.getF_src());
			imageVideo.setV_cover(FileUtilsTag.headPath()+imageVideo.getV_cover());
			imageVideo.setCreate_timeS(df.format(imageVideo.getCreate_time()));
		}
		request.setAttribute("leagueRecords", leagueRecords);
		request.setAttribute("teamRecords", teamRecords);
		request.setAttribute("playerRecords", playerRecords);
		request.setAttribute("productRecords", productRecords);
		request.setAttribute("imageVideoList", imageVideoList);
		request.setAttribute("leagueList", leagueList);
		request.setAttribute("user_img", user_img);
		request.setAttribute("banners", banners);
		request.setAttribute("win_users", win_users);
		return "index";
	}
	/**
	 * 登出操作
	 *@param request
	 *@return 回到首页
	 *@autor bo.xie
	 *@date2015-7-23下午6:22:56
	 */
	@RequestMapping(value="/loginOut")
	public String loginOut(HttpServletRequest request){
		Common.removeSessionValue("session_user_id");
		Common.removeSessionValue("session_usernick");
		return "redirect:/"; //update by gl
	}
	/**
	 * <p>Description: 首页精彩图片</p>
	 * @Author zhangwei
	 * @Date 2015年11月27日 下午3:41:28
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/imagess")
	public String images(HttpServletRequest request){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "image");
		AjaxMsg msg = indexService.queryImageOrVideos(params, null);
		request.setAttribute("images", msg.getData("page"));
		return "index/images"; 
	}
	
	/**
	 * <p>Description:首页精彩视频列表 </p>
	 * @Author zhangwei
	 * @Date 2015年11月27日 下午3:42:18
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="/videos")
	public String videos(HttpServletRequest request,PageModel pageModel){
		String title = request.getParameter("title");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "video");
		params.put("userId", getUserId());
		if(StringUtils.isNotBlank(title)) params.put("title", title);
		AjaxMsg msg = indexService.queryImageOrVideos(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "index/videos"; 
	}
	
	/**
	 * 首页球员
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/players")
	public String indexPlayers(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "player");
		AjaxMsg msg = indexService.queryPlayers(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "index/players";
	}
	
	/**
	 * <p>Description: 首页宝贝</p>
	 * @Author zhangwei
	 * @Date 2015年11月27日 下午3:43:39
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="/babys")
	public String indexBabys(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("type", "baby");
		AjaxMsg msg = indexService.queryBabys(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "index/babys";
	}
	
	/**
	 * 首页讯息
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="/hotNews")
	public String indexNews(HttpServletRequest request,PageModel pageModel){
		String type = request.getParameter("type");
		String page = request.getParameter("page");
		String model_id = request.getParameter("model_id");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("model_id", model_id);
		AjaxMsg msg = indexService.queryNews(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("type",type);
		return "index/"+page;
	}
	/**
	 * 讯息列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/news")
	public String newsList(HttpServletRequest request){
		String model_id = request.getParameter("model_id");
		if(StringUtils.isNotBlank(model_id)){
			request.setAttribute("model_id", model_id);
		}
		List<League> leagueList = leagueService.getLeagues();
		request.setAttribute("leagueList", leagueList);
		return "index/newslist";
	}
	@RequestMapping(value="/news/{nid}")
	public String newsDetails(HttpServletRequest request,@PathVariable("nid") String nid){
		News news = indexService.getNewsById(nid);
		if(news!=null){
			//新闻状态  是否发布 0 未发布 1 发布
			Integer n_state = news.getN_state();
			boolean flag = true;
			//如果新闻未发布需要管理员身份才能访问
			if(n_state==0){
				flag = false;
				UserRole user = getUser();
				if(user!=null){
					Set<Role> roles = user.getRoles();
					for (Role role : roles) {
						String str = role.getRole_str();
						if(str.contains("ADMIN")){
							flag = true;
							break;
						}
					}
				}
			}
			if(flag){
				request.setAttribute("news", news);
				return "index/news_detail";
			}
		}
		return "";
	}
	
	
	/**
	 * 首页视频和图片列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/indexIvList")
	public String indexIvList(HttpServletRequest request){
		String type = request.getParameter("type");
		String page = "";
		if("videolist".equals(type)||"imagelist".equals(type)){
			page = "index/"+type;
		}
		String user_img = "headImg/headimg.png";
		if(getUser()!=null){
			user_img = getUser().getHead_icon();
		}
		request.setAttribute("user_img", user_img);
		return page;
	}
	/**
	 * <p>Description: 查询图片或者视频列表信息</p>
	 * @Author zhangwei
	 * @Date 2015年11月28日 下午3:09:33
	 * @param request
	 * @param imageVideo
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="/queryImagesOrVideos")
	public String queryImagesOrVideos(HttpServletRequest request,ImageVideo imageVideo,PageModel pageModel){
		imageVideo.setLogin_user_id(getUserId());
		String page = request.getParameter("page");
		if(StringUtils.isBlank(imageVideo.getOrderby())){
			imageVideo.setOrderby("index");
		}
		AjaxMsg ajaxMsg = imageVideoService.searchImageVideos(imageVideo, pageModel);
		request.setAttribute("page", ajaxMsg.getData("page"));
		try {
			Map<String, Object> params = BeanUtils.object2Map(imageVideo);
			request.setAttribute("params", params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index/"+page;
	}
	
	/**
	 * 
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-7-21下午3:45:25
	 */
	@RequestMapping(value="/old")
	public String indexPage(Model model,HttpServletRequest request){
//		List<Map<String, Object>> images = commonService.queryIndexImages();
//		request.setAttribute("images", images);
		
		//added by bo.xie 宝贝图片展示
		Map<String,Object> map = Maps.newHashMap();
		map.put("start", 0);
		map.put("rows", 4);
		List<Map<String,Object>> reMaps = baseService.loadRecommendBabyImages(map);
		model.addAttribute("reMaps", reMaps);
		return "old_index";
	}
	
	/**首页动态消息 
	 *@param model
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-21下午3:45:25
	 */
	@RequestMapping(value="queryNewMsgRecord")
	@ResponseBody
	public String queryNewMsgRecord(HttpServletRequest request){
		AjaxMsg msg = messageRecordsService.queryNewMsgRecord();
		return msg.toJson();
	}
	
	/**
	 * 首页球员动态
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/queryIvComments")
	public String queryHotDynamic(HttpServletRequest request){
		List playerList = dynamicService.queryHotDynamicList(null);
		request.setAttribute("players", playerList);
		return "index/player";
	}
	
	/**
	 * 俱乐部动态
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-18下午5:26:52
	 */
	@RequestMapping(value="teamDynamicList")
	public String teamDynamicList(HttpServletRequest request){
		List teamList = dynamicService.queryHotTeamDynamicList(null);
		request.setAttribute("teams", teamList);
		return "index/team";
	}
	
	/**
	 * 热门比赛
	 *@param request
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-14下午5:26:52
	 */
	@RequestMapping(value="queryHotGame")
	public String queryHotGame(HttpServletRequest request){
		List gameList = teamInviteService.queryHotGameList(null);
		request.setAttribute("games", gameList);
		return "index/game";
	}
	
	/**
	 * 更多列表
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午2:34:25
	 */
	@RequestMapping(value="/more/{type}")
	public String moreDynamics(Model model,HttpServletRequest request,@PathVariable("type")String type){
		model.addAttribute("type", type);
		return "index/more_dynamics";
	}
	
	/**
	 * 更多列表数据
	 *@param model
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-22下午2:59:19
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="more_datas")
	public String moreDatas(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String type = request.getParameter("type");
		pageModel.setPageSize(10);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		int totalCount = 0;
		List datas = Lists.newArrayList();
		if(type.equals("1")){
			datas = teamInviteService.queryHotGameList(maps);
			totalCount = teamInviteService.queryHotGameCount(maps);
		}else if(type.equals("2")){
			datas = dynamicService.queryHotTeamDynamicList(maps);
			totalCount = dynamicService.queryHotTeamDynamicCount(maps);
		}else if(type.equals("3")){
			datas = dynamicService.queryHotDynamicList(maps);
			totalCount = dynamicService.queryHotDynamicCount(maps);
		}
		pageModel.setTotalCount(totalCount);
		pageModel.setItems(datas);
		model.addAttribute("pageModel", pageModel);
		model.addAttribute("type", type);
		return "index/datas";
	}
	
	@RequestMapping(value="/doorCode")
	public String doorCode(Model model,HttpServletRequest request,HttpServletResponse response){
		String doorCode = request.getParameter("doorCode");
		if(StringUtils.isNotBlank(doorCode)){//校验门令是否正确
			if(doorCode.equals("yrt2015")){
				Common.setSessionValue("ACTIVECODE", Common.toIpAddr(request));
				return "redirect:/";
			}else{
				model.addAttribute("error", "门令输入错误！");
			}
		}
		return "doorCode";
	}
	
	@RequestMapping(value="/event")
	public String event(Model model,HttpServletRequest request,HttpServletResponse response){
		return "common/big_event";
	}
	
}
