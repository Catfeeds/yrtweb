package com.yt.framework.controller;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.ComparatorDynamicMsg;
import com.yt.framework.persistent.entity.Dynamic;
import com.yt.framework.persistent.entity.DynamicMsg;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.ConstantEnum.MsgType;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.EhCache;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.ReturnJosnMsg;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.gson.JSONUtils;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;

/**
 * 
 * @author YJH
 *
 * 2015年11月11日
 */
@Controller
@RequestMapping(value="/dynamicv1")
public class DynamicV1Controller extends BaseController{
	
	private static Logger logger = LogManager.getLogger(DynamicV1Controller.class);
	
	@Autowired
	private DynamicService dynamicService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private UserAmountService userAmountService;
	
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	@Autowired
	private MessageResourceService messageResourceService;

	/**
	 * 动态主页
	 * @return dynamic.jsp
	 */
	@RequestMapping(value="")
	public String dynamic(HttpServletRequest request){
		String userid=getUserId();
		List<DynamicMsg> topDy =dynamicService.queryTopDynamics(2); 
		String _toPage=request.getParameter("to_page");
		if(_toPage==null){
			_toPage="news";
		}
		request.setAttribute("_userid", userid);
		request.setAttribute("_toPage", _toPage);
		request.setAttribute("_topDy", topDy);
		return "dynamic/dynamicV1";
	}
	

	/**
	 * 保存动态
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveDyn")
	@ResponseBody
	public String saveDyn(HttpServletRequest request,Dynamic dynamic){
		ReturnJosnMsg retmsg = ReturnJosnMsg.newError();
		String userid=getUserId();
		if(userid==null){
			retmsg.setMessage("发送失败,未登录");
			return retmsg.toJson(); 
		}
		dynamic.setUser_id(userid);
		dynamic.setType(0);//设置type为个人动态
		dynamic.setCreate_time(new Date());
		if(null == dynamic.getId() || "".equals(dynamic.getId())){
			dynamic.setId(UUIDGenerator.getUUID());
		}
		String imgStr = dynamic.getImage();
		if(StringUtils.isNotBlank(imgStr)){
			String[] imgs = imgStr.split(",");
			for (String img : imgs) {
				if(StringUtils.isNotBlank(img.trim())){
					int result = OSSClientFactory.uploadFile(img, new File(fileRepository.getRealPath(img)));
					if(result == Global.SUCCESS){
						ImageKit.delFile(fileRepository.getRealPath(img));
					}else{
						return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
					}
				}
			}
		}
		AjaxMsg msg = dynamicService.save(dynamic);
		if(MsgType.SUCCESS.equals(msg.getType())){
			retmsg=ReturnJosnMsg.newSuccess();
			retmsg.setMessage("发送成功");
		}else{
			retmsg.setMessage("发送失败,服务器错误");
		}
		EhCache.getInstance().addDymsg(dynamicService.transformationDynamic(dynamic));
//		EhCache.getInstance().setNewDynamic(true);
		return retmsg.toJson(); 
	}
	
	/**
	 * 保存动态
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/operTop")
	@ResponseBody
	public String operTop(HttpServletRequest request,@RequestBody String pjson){
		BigDecimal bd_ytb = new BigDecimal(100);//消耗宇拓币数量
		AjaxMsg ajaxMsg=AjaxMsg.newError();
		String user_id=getUserId();
		Map<String,String> map = JSONUtils.json2Map(pjson);
		String dynamic_id = map.get("dynamic_id");
		Dynamic dynamic = dynamicService.getEntityById(dynamic_id);
		if(dynamic!=null){
			UserAmount uas = userAmountService.getEntityById(user_id);
			if (uas != null) {
				if (uas.getAmount().compareTo(bd_ytb)>=0) {
					uas.setAmount(uas.getAmount().subtract(bd_ytb));
					uas.setReal_amount(uas.getReal_amount().subtract(bd_ytb));
					//userAmountService.save(uas);
				}else{
					ajaxMsg=AjaxMsg.newError();
					ajaxMsg.addMessage("宇拓币不够,请充值后再试");
				}
			}else{
				ajaxMsg=AjaxMsg.newError();
				ajaxMsg.addMessage("宇拓币不够,请充值后再试");
			}
			dynamic.setSet_top_time(new Date());
			dynamic.setIs_top(1);
			dynamic.setTop_count(10);
			dynamicService.update(dynamic);
			ajaxMsg=AjaxMsg.newSuccess();
		}else{
			ajaxMsg.addMessage("要置顶的消息不存在");
		}
		
		return ajaxMsg.toJson();
	}
	

	
	@RequestMapping(value="/def")
	@ResponseBody
	public String def(HttpServletRequest request, HttpSession session,
			@RequestBody String pjson) {
		Map<String,String> map = JSONUtils.json2Map(pjson);
		Map<String, Object> params = new HashMap<String, Object>();
		String userid=getUserId();
		params.put("userid", userid);
		params.put("session_id", session.getId());
		params.put("show_count",0);
		params.put("rows",10);
		String loadData = map.get("loadData");
		
		List<DynamicMsg> retList = new ArrayList<DynamicMsg>(); 
		List<DynamicMsg> cachels = initEhcache(params);
		
		if("news".equals(loadData)){
			for(DynamicMsg dymsg:cachels){
				DynamicMsg dd = dymsg.clone();
				retList.add(dd);
			}
		}else if("followers".equals(loadData)){
			if(userid!=null){
				List<String> userids = dynamicService.findMyFocus(userid);
				for(DynamicMsg dymsg:cachels){
					DynamicMsg dd = dymsg.clone();
					String dyuserid = dymsg.getUser_id();
					if(dyuserid.equals(userid)){
						retList.add(dd);
					}else if(userids.contains(dyuserid)){
						retList.add(dd);
					}
				}
			}
		}else if("my".equals(loadData)){
			for(DynamicMsg dymsg:cachels){
				DynamicMsg dd = dymsg.clone();
				if(dymsg.getUser_id().equals(userid)){
					retList.add(dd);
				}
			}
		}
		
		for(DynamicMsg dymsg:retList){
			if(dymsg.getUser_id().equals(userid)){
				dymsg.setMsg_me(true);
			}
		}
		
		return JSONUtils.bean2json(retList);
	}

	@RequestMapping(value="/index_top")
	@ResponseBody
	public String index_top(HttpServletRequest request, HttpSession session,
			@RequestBody String pjson) {
		List<DynamicMsg> retList =dynamicService.queryTopDynamics(2); 
		String userid=getUserId();
		for(DynamicMsg dymsg:retList){
			if(dymsg.getUser_id().equals(userid)){
				dymsg.setMsg_me(true);
			}
		}
		return JSONUtils.bean2json(retList);
	}

	private List<DynamicMsg> initEhcache(Map<String, Object> params) {
		List<DynamicMsg> cachels = EhCache.getInstance().getDymsgList();
		int size = cachels.size();
		if(size==0){
			Date curdate = new Date();
			String sDate = EhCache.dateModify(curdate, -5);
			String eDate = JSONUtils.formatDate(curdate, null);
			params.put("sDate",sDate);
			params.put("eDate",eDate);

			List<DynamicMsg> dyls = dynamicService.queryDynamicsDef(params);
			cachels.addAll(dyls);
			Collections.sort(cachels,new ComparatorDynamicMsg());
		}else if(size>50){
			for(;;){
				cachels.remove(0);
				if(cachels.size()<=50)break;
			}
		}
		return cachels;
	}
		
	@RequestMapping(value="/loadNewMsg")
	@ResponseBody
	public String loadNewMsg(HttpServletRequest request, HttpSession session,@RequestBody String pjson){
		Map<String,String> map = JSONUtils.json2Map(pjson);
		String userid=(String)session.getAttribute("session_user_id");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userid", userid);
		params.put("session_id", session.getId());
		params.put("lastTime", map.get("lastTime"));
		params.put("loadData", map.get("loadData"));
		
		List<DynamicMsg> retList = dynamicService.findNewMsg(params);
		for(DynamicMsg dymsg:retList){
			if(dymsg.getUser_id().equals(userid)){
				dymsg.setMsg_me(true);
			}
		}
		return JSONUtils.bean2json(retList);
	}

	/**
	 * 获取首页最新的消息
	 */
	@RequestMapping(value="/indexDynamic")
	public String indexDynamic(HttpServletRequest request, HttpSession session) {
		Map<String, Object> params = new HashMap<String, Object>();
		String userid=getUserId();
		params.put("userid", userid);
		return "index/dynamic";
	}
}
