package com.yt.framework.controller;

import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BbsAccessories;
import com.yt.framework.persistent.entity.BbsAccessoriesList;
import com.yt.framework.persistent.entity.BbsChargeInfo;
import com.yt.framework.persistent.entity.BbsNote;
import com.yt.framework.persistent.entity.BbsPraise;
import com.yt.framework.persistent.entity.BbsTip;
import com.yt.framework.persistent.entity.BbsVote;
import com.yt.framework.service.BbsNoteService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.DownLoad;
import com.yt.framework.utils.NumUtil;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.file.FileRepository;

/**
 *用户操作
 *@autor ylt
 *@date2015-8-31下午5:16:49
 */
@RequestMapping(value="/bbs")
@Controller
public class BbsNoteController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(BbsNoteController.class);
	
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	@Autowired
	BbsNoteService bbsNoteService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	
	/**
	 * 发起投票页面
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="toVotePage")
	public String toVotePage(HttpServletRequest request) {
		String plate_id = BeanUtils.nullToString(request.getParameter("plate_id"));
		request.setAttribute("plate_id", plate_id);
		return "bbs/vote/voteForm";
	}
	
	/**
	 * 发起投票
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="saveVote")
	public String saveVote(HttpServletRequest request,BbsVote bbsVote,BbsNote bbsNote) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		String []names = request.getParameterValues("name");
		try {
			bbsVote.setUser_id(this.getUserId());
			bbsNote.setUser_id(this.getUserId());
			msg = bbsNoteService.saveVote(bbsVote,bbsNote,names);
			request.setAttribute("plate_id", bbsNote.getPlate_id());
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return "bbs/redirect_page";
	}
	
	/**
	 * 更新投票数据
	 * @autor ylt
	 * @parameter *
	 * @date2015-10-14下午3:48:45
	 */
	@RequestMapping(value="updateVote")
	public String updateVote(HttpServletRequest request) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		String user_id = this.getUserId();
		String []ids = request.getParameterValues("d_id");
		try {
			msg = bbsNoteService.updateVote(ids,user_id);
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return "bbs/redirect_page";
	}
	
	
	/**
	 * 更新贴子页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="editnote/{note_id}")
	public String publishNote(@PathVariable("note_id") String note_id,Model model,HttpServletRequest request){
		//回去贴子内容
		BbsNote bbsNote = bbsNoteService.getEntityById(note_id);
		//获取贴子附件
		List<BbsAccessories> bbsAccessories = bbsNoteService.getBbsAccessoriesByNoteId(note_id);
		BigDecimal sumAmount = new BigDecimal(0);
		if(bbsAccessories.size()>0){
			for (BbsAccessories acc : bbsAccessories) {
				sumAmount=sumAmount.add(acc.getPrice());
			}
		}
		model.addAttribute("sumAmount", sumAmount);
		model.addAttribute("bbsNote", bbsNote);
		model.addAttribute("bbsAccessories", bbsAccessories);
		return "bbs/publish_note";
	}
	/**
	 * 发布贴子、更新贴子
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveOrUpNote")
	public @ResponseBody String saveOrUpdateNote(HttpServletRequest request,BbsAccessoriesList list){
		String user_id = super.getUserId();
		Map<String,Object> params = Maps.newHashMap();
		params.put("user_id", user_id);
		params.put("note_id", request.getParameter("note_id"));//贴子ID
		params.put("ac_id", request.getParameter("ac_id"));//附件ID
		params.put("plate_id", request.getParameter("plate_id"));//板块ID
		params.put("title", request.getParameter("title"));
		params.put("content", request.getParameter("content"));
		params.put("pre_content", request.getParameter("pre_content"));
		if(BeanUtils.nullToString(request.getParameter("content")).indexOf("img")>0){
			params.put("if_image", 1);
		}else{
			params.put("if_image", 2);
		}
		if(BeanUtils.nullToString(request.getParameter("content")).indexOf("video")>0
		  ||BeanUtils.nullToString(request.getParameter("content")).indexOf("embed")>0){
			params.put("if_video", 1);
		}else{
			params.put("if_video", 2);
		}
		params.put("type", request.getParameter("type"));//贴子类型 1：普通 2：投票
		params.put("charge", request.getParameter("charge"));//下载附件是否收费  1:收费 
		params.put("reply_look", request.getParameter("reply_look"));//内容是否回复可见 1：需回复可见 
		System.out.println(list);
		AjaxMsg msg;
		try {
			msg = bbsNoteService.saveOrUpdateNote(params,list.getAttrcs());
		} catch (Exception e) {
			e.printStackTrace();
			msg = AjaxMsg.newError();
		}
		return msg.toJson();
	}
	
	/**
	 * 保存更新贴子回复
	 * @param request
	 * @return
	 */
	@RequestMapping(value="noteReply")
	public @ResponseBody String saveNoteReply(HttpServletRequest request){
		String user_id = super.getUserId();
		Map<String,Object> params = Maps.newHashMap();
		params.put("user_id", user_id);
		params.put("reply_id", request.getParameter("reply_id"));//回复贴子ID
		params.put("note_id", request.getParameter("note_id"));//贴子ID
		params.put("content", request.getParameter("content"));//回复内容
		
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = bbsNoteService.saveOrUpateBbsNoteReplay(params);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 论坛列表
	 * @param model
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="list")
	public String notePage(Model model,HttpServletRequest request){
		PageModel pageModel = new PageModel();
		pageModel.setPageSize(10);
		String plate_id = request.getParameter("plate_id");//板块ID
		String status = request.getParameter("status");//status LOCK:锁定帖,UNLOCK:开放贴,PICK：精华帖 , UNPICK：非精华帖
		String if_del = request.getParameter("if_del");//add gl
		
		Map<String,Object> map = Maps.newHashMap();
		map.put("show", 1);
		if(StringUtils.isNotBlank(if_del)&&"1".equals(if_del)){
			map.put("if_del", 1);
		}else{
			map.put("if_del", 2);
		}
		map.put("plate_id", plate_id);
		map.put("status", status);
		if(!"PICK".equals(status)&&!"1".equals(if_del)){//update gl
			map.put("top", 1);
			AjaxMsg msg = bbsNoteService.queryForPageForMap(map, pageModel);
			if(msg.isSuccess()){
				model.addAttribute("topdatas", msg.getData("page"));
			}
		}
		
		//判断是否版主 add by ylt
		String user_id = this.getUserId();
		if(StringUtils.isNotBlank(user_id)){
			boolean ifLeader = bbsNoteService.ifLeader(user_id,BeanUtils.nullToString(plate_id));
			request.setAttribute("ifLeader", ifLeader);	
		}else{
			if("1".equals(if_del)){//add gl 不是版主不能进回收站
				return "";
			}
			request.setAttribute("ifLeader", false);	
		}
		model.addAttribute("if_del", if_del);
		model.addAttribute("status", status);
		model.addAttribute("plate_id", plate_id);
		return "bbs/note_list";
	}
	
	@RequestMapping(value="toMyBbsNotelist")
	public String toMyBbsNotelist(Model model,HttpServletRequest request){
		String focus = request.getParameter("focus");
		String plate_id = request.getParameter("plate_id");//板块ID
		String my = super.getUserId();
		//判断是否版主 add by ylt
		String user_id = this.getUserId();
		if(StringUtils.isNotBlank(user_id)){
			boolean ifLeader = bbsNoteService.ifLeader(user_id,BeanUtils.nullToString(plate_id));
			request.setAttribute("ifLeader", ifLeader);	
		}else{
			request.setAttribute("ifLeader", false);	
		}
		if(StringUtils.isNotBlank(my)){
			model.addAttribute("focus", focus);
			model.addAttribute("my", "my");
			model.addAttribute("plate_id", plate_id);
			return "bbs/note_list";
		}
		return "";
	}
			
	/**
	 * <p>Description: 查询我的跟我关注的用户的帖子</p>
	 * @Author zhangwei
	 * @Date 2016年1月13日 下午4:35:56
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="myBbsNotelist")
	public String myBbsNotelist(Model model,HttpServletRequest request,PageModel pageModel){
		String plate_id = request.getParameter("plate_id");//板块ID
		String my = super.getUserId();
		String focus = request.getParameter("focus");
		String title = request.getParameter("title");//搜索主题
		String status = request.getParameter("status");//status LOCK:锁定帖,UNLOCK:开放贴,PICK：精华帖 , UNPICK：非精华帖
		Map<String,Object> map = Maps.newHashMap();
		
		map.put("focus", focus);
		map.put("user_id", my);
		map.put("if_del", 2);
		map.put("show", 1);
		map.put("plate_id", plate_id);
		map.put("title", title);
		map.put("status", status);
		String user_id = this.getUserId();
		if(StringUtils.isNotBlank(user_id)){
			boolean ifLeader = bbsNoteService.ifLeader(user_id,BeanUtils.nullToString(plate_id));
			request.setAttribute("ifLeader", ifLeader);	
		}else{
			request.setAttribute("ifLeader", false);	
		}
		AjaxMsg msg = bbsNoteService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		model.addAttribute("focus", focus);
		model.addAttribute("my", "my");
		return "bbs/note_my_list_datas";
	}
	
	
	/**
	 * 论坛列表数据
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="listData")
	public String noteDatas(Model model,HttpServletRequest request,PageModel pageModel){
		String plate_id = request.getParameter("plate_id");//板块ID
		String title = request.getParameter("title");//搜索主题
		//String show = request.getParameter("show");//是否展示 1：展示 2：不展示
		String status = request.getParameter("status");//status LOCK:锁定帖,UNLOCK:开放贴,PICK：精华帖 , UNPICK：非精华帖
		String if_del = request.getParameter("if_del");//add gl
		String if_show = request.getParameter("if_show");//add gl
		Map<String,Object> map = Maps.newHashMap();
		map.put("plate_id", plate_id);
		map.put("title", title);
		if(StringUtils.isNotBlank(if_del)&&"1".equals(if_del)){//update gl
			if(StringUtils.isNotBlank(if_show)&&"2".equals(if_show)){
				map.put("show", 2);
			}else{
				map.put("if_del", 1);
			}
		}else{
			map.put("show", 1);
			map.put("if_del", 2);
			if(!"PICK".equals(status)){
				map.put("top", 2);
			}
			map.put("status", status);
		}
		String user_id = this.getUserId();
		if(StringUtils.isNotBlank(user_id)){
			boolean ifLeader = bbsNoteService.ifLeader(user_id,BeanUtils.nullToString(plate_id));
			request.setAttribute("ifLeader", ifLeader);	
		}else{
			request.setAttribute("ifLeader", false);	
		}
		AjaxMsg msg = bbsNoteService.queryForPageForMap(map, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("rf", msg.getData("page"));
		}
		return "bbs/note_list_datas";
	}
	/**
	 * 帖子详情
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="noteDetails/{note_id}")
	public String noteDetails(HttpServletRequest request,@PathVariable String note_id,PageModel pageModel){
		String user_id = super.getUserId();
		Map<String, Object> note = bbsNoteService.getBbsNoteById(note_id,user_id);
		String page = request.getParameter("page");
		String see_lz = request.getParameter("seeLz");
		String if_del = note.get("if_del").toString();
		String if_show = note.get("if_show").toString();
		boolean flag = true;
		
		//判断是否版主 add by ylt update gl
		if(StringUtils.isNotBlank(user_id)){
			boolean ifLeader = bbsNoteService.ifLeader(user_id,BeanUtils.nullToString(note.get("plate_id")));
			request.setAttribute("ifLeader", ifLeader);		
		}else{
			if("1".equals(if_del)||"2".equals(if_show)){
				flag = false;
				request.setAttribute("info", messageResourceService.getMessage("bbs.note.isdel"));
			}
			request.setAttribute("ifLeader", false);	
		}
		
		
		if(note!=null&&flag){
			if(StringUtils.isNotBlank(page)){
				pageModel.setCurrentPage(NumUtil.String2Num(page, 1));
			}
			pageModel.setPageSize(10);
			String lz_id = BeanUtils.nullToString(note.get("user_id"));//楼主ID
			Map<String, Object> params = new HashMap<String,Object>();
			params.put("note_id", note_id);
			params.put("lz_id", lz_id);
			params.put("see_lz", see_lz);
			params.put("user_id", getUserId());//当前登录用户ID
			pageModel = bbsNoteService.queryBbsNoteReplys(params,pageModel);
			
			//added by bo.xie 判断当前用户是否已购买该贴子附件 start
			if(StringUtils.isNotBlank(user_id)){
				AjaxMsg msg = bbsNoteService.getBbsChargeInfoByIds(user_id, note_id);
				if(msg.isSuccess()){
					List<BbsChargeInfo> chargeInfo =  (List<BbsChargeInfo>) msg.getData("data");
					request.setAttribute("charinfo", chargeInfo);
					List<String>aceids = bbsNoteService.getAccIDFromBbsCharge(user_id, note_id);
					request.setAttribute("aceids", aceids);
				}
				//获取当前用户回复该贴子次数
				int replyCount = bbsNoteService.getBbsNoteReplyCountByIds(note_id, user_id);
				request.setAttribute("replyCount", replyCount);
			}
			//added by bo.xie 判断当前用户是否已购买该贴子附件 end
			//added by bo.xie 查询贴子是否有附件 start
			List<BbsAccessories> aces = bbsNoteService.getBbsAccessoriesByNoteId(note_id);
			if(aces.size()>0){
				for (BbsAccessories ace : aces) {
					//获取已购买该贴子附件总数
					int buyCount = bbsNoteService.getBuyBbsChargeCountByIDs(note_id, ace.getId());
					ace.setBuyCount(buyCount);
				}
				request.setAttribute("aces", aces);
			}
			//判断帖子是否投票帖
			if(BeanUtils.nullToString(note.get("type")).equals("2")){
				AjaxMsg vMsg = bbsNoteService.getVoteDataByNoteId(note_id);
				List<Map<String,Object>> voteList = (List<Map<String, Object>>) vMsg.getData("datas");
				int voteCount = 0 ;
				for (Map<String, Object> map : voteList) {
					voteCount += (int) map.get("vote_count");
				}
				boolean ifVote = bbsNoteService.checkIfVote(note_id,user_id);
				request.setAttribute("voteCount", voteCount);
				request.setAttribute("voteList", voteList);
				request.setAttribute("ifVote", ifVote);
				
			}
			
			//added by bo.xie 查询贴子是否有附件 end
			request.setAttribute("note", note);
			request.setAttribute("see_lz", see_lz);
			request.setAttribute("page", pageModel);
			return "bbs/note_details";
		}
		return "";
	}
	
	@RequestMapping(value="/getNoteReply")
	@ResponseBody 
	public String getNoteReply(HttpServletRequest request){
		String rid = request.getParameter("rid");
		AjaxMsg msg = bbsNoteService.getBbsNoteReplyById(rid);
		return msg.toJson();
	}
	
	/**
	 * 点赞或点踩
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/praise")
	@ResponseBody 
	public String praise(HttpServletRequest request,BbsPraise praise){
		try {
			praise.setUser_id(getUserId());
			AjaxMsg msg = bbsNoteService.updatePraise(praise);
			return msg.toJson();
		} catch (Exception e) {
			return AjaxMsg.newError().toJson();
		}
	}
	
	/**
	 * 购买贴子附件
	 * @param request
	 * @return
	 */
	@RequestMapping(value="buyNoteAcc")
	public @ResponseBody String buyNoteAccessories(HttpServletRequest request){
		String user_id = super.getUserId();
		String note_id = request.getParameter("note_id");//贴子ID
		String amount = request.getParameter("amount");//附件售价
		String acc_id = request.getParameter("acc_id");//附件ID
		
		Map<String,Object> map = Maps.newHashMap();
		map.put("user_id", user_id);
		map.put("note_id", note_id);
		map.put("amount", amount);
		map.put("acc_id", acc_id);
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = bbsNoteService.saveChargeInfo(map);
		} catch (Exception e) {
			msg = AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
			logger.error("error is = " + e.getMessage());
		}
		return msg.toJson();
	}
	
	/**
	 * 编辑帖子里删除附件
	 * @param request
	 * @return
	 */
	@RequestMapping(value="deleteAccessories")
	@ResponseBody
	public String deleteAccessories(HttpServletRequest request){
		String aid = request.getParameter("aid");
		AjaxMsg msg = bbsNoteService.deleteAccessories(aid);
		return msg.toJson();
	}
	
	/**
	 * <p>Description: 添加举报信息</p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午4:51:57
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveBbsTip")
	@ResponseBody
	public String saveBbsTip(HttpServletRequest request,BbsTip bbsTip){
		
		if(StringUtils.isBlank(bbsTip.getType())||StringUtils.isBlank(bbsTip.getNote_id()))
		return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		
		AjaxMsg msg = AjaxMsg.newError();
		BbsTip tip = new BbsTip();
		tip.setUser_id(super.getUserId());
		tip.setB_user_id(bbsTip.getB_user_id());
		tip.setContent(bbsTip.getContent());
		tip.setNote_id(bbsTip.getNote_id());
		tip.setNote_reply_id(bbsTip.getNote_reply_id());
		tip.setType(bbsTip.getType());
		tip.setStatus(2);//未处理
		msg = bbsNoteService.saveBbsTip(tip);
		
		return msg.toJson();
	}
	/**
	 * <p>Description:判断该用户在某帖子下的某一楼层是否投诉过 </p>
	 * @Author zhangwei
	 * @Date 2016年1月11日 下午4:01:21
	 * @param request
	 * @return
	 */
	@RequestMapping(value="ifHasBbsTip")
	@ResponseBody
	public String ifHasBbsTip(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String note_id = request.getParameter("note_id");
		String note_reply_id = request.getParameter("note_reply_id");
		String b_user_id = request.getParameter("b_user_id");
		String floor_num = request.getParameter("floor_num");
		Map<String,Object> map = Maps.newHashMap();
		map.put("note_id", note_id);
		map.put("note_reply_id", note_reply_id);
		map.put("user_id", super.getUserId());
		map.put("b_user_id", b_user_id);
		map.put("floor_num", floor_num);
		
		int count = bbsNoteService.queryTipsCountByReplyIdAndNoteId(map);
		if(count >=1){
			msg.addMessage("您已经举报过该用户，无需再举报");
		}else{
			msg = AjaxMsg.newSuccess();
		}
		return msg.toJson();
	}
	
	/**
	 * 下载附件
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="download")
	public void downloadFile(HttpServletRequest request,HttpServletResponse response){
		String file_url = request.getParameter("file_url");
		String file_name = request.getParameter("file_name");
		String ac_id = request.getParameter("ac_id");
		if(StringUtils.isBlank(file_url)||StringUtils.isBlank(file_url)){
			logger.error("附件下载参数不全！");
		}
		AjaxMsg msg = AjaxMsg.newError();
		String path = request.getContextPath();
		File file = new File(fileRepository.getRealPath(path+file_url));
		msg = DownLoad.download(file, file_name, response);
		if(msg.isSuccess()){
			//更新下载次数
			msg = bbsNoteService.updateBbsAccessories(ac_id);
			if(msg.isError()){
				logger.error("更新附件下载次数失败！");
			}
		}
	}
	
	/**
	 * 删除用户贴子（虚拟删除）
	 * @param request
	 * @return
	 */
	@RequestMapping(value="deleteNote")
	public @ResponseBody String deleteNoteBYOwner(HttpServletRequest request){
		String user_id = super.getUserId();
		String plate_id = request.getParameter("plate_id");//版块ID
		String note_id = request.getParameter("note_id");//贴子ID
		AjaxMsg msg = bbsNoteService.deleteNoteBYOwner(user_id, plate_id, note_id);
		return msg.toJson();
	}
	
	/**
	 * 保存用户投票信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="saveVoteClick")
	public @ResponseBody String saveVoteClick(HttpServletRequest request){
		String user_id = super.getUserId();
		String ids = request.getParameter("ids");//版块ID
		String note_id = request.getParameter("note_id");//贴子ID
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = bbsNoteService.saveVoteClick(ids,user_id,note_id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 删除用户对贴子的回复
	 * @param request
	 * @return
	 */
	@RequestMapping(value="deleteNoteReply")
	public @ResponseBody String deleteNoteReply(HttpServletRequest request){
		String user_id = super.getUserId();
		String reply_id = request.getParameter("reply_id");//贴子回复ID
		String plate_id = request.getParameter("plate_id");//版块ID
		String note_id = request.getParameter("note_id");//贴子ID
		AjaxMsg msg = bbsNoteService.deleteNoteReply(reply_id, user_id, plate_id, note_id);
		return msg.toJson();
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
		if(type.equals("if_top") && statusStr.equals("1")){
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
}
