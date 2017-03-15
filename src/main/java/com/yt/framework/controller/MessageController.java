package com.yt.framework.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.Message;
import com.yt.framework.service.MessageService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

@Controller
@RequestMapping(value="/message")
public class MessageController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(MessageController.class);

	@Autowired
	private MessageService messageService;
	
	/**
	 * 发送私信消息页面
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/toMsg/{s_id}/{usernick}")
	public String toMsg(HttpServletRequest request,@PathVariable String s_id,@PathVariable String usernick){
		request.setAttribute("s_id", s_id);
		request.setAttribute("usernick", usernick);
		return "center/sysmsg/sendmsg";
	}
	
	/**
	 * 进入信箱页
	 * @return
	 */
	@RequestMapping(value="")
	public String message(HttpServletRequest request){
		AjaxMsg msg = messageService.queryMsgUser(getUserId());
		request.setAttribute("users", msg.getData("data"));
		return "message/message";
	}
	
	
	/**
	 * 查询私信
	 * @return
	 */
	@RequestMapping(value="/queryMessage")
	@ResponseBody
	public String queryMessage(HttpServletRequest request,PageModel pageModel){
		String s_user_id = request.getParameter("s_user_id");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("user_id", getUserId());
		params.put("s_user_id", s_user_id);
		//params.put("type", "private");
		params.put("m_style", "0");
		messageService.updateMsgState(getUserId(),s_user_id, 1);
		AjaxMsg msg = messageService.queryForPageForMap(params, pageModel);
		return msg.toJson();
	}
	
	/**
	 * 查询未读消息
	 * @return
	 */
	@RequestMapping(value="/queryNotReadMsg")
	@ResponseBody
	public String queryNotReadMsg(HttpServletRequest request){
		AjaxMsg msg = messageService.queryNotReadMsg(getUserId());
		return msg.toJson();
	}
	/**
	 * <p>Description: 到达系统消息列表页面</p>
	 * @Author zhangwei
	 * @Date 2015年12月4日 下午12:06:23
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toSysMsgListPage")
	public String toSysMsgListPage(Model model,HttpServletRequest request){
		String user_id = getUserId();
		model.addAttribute("user_id",user_id);
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("user_id",user_id);
		params.put("m_style", 1);
		params.put("status", "0");
		/**查出未读系统消息，将其状态改为已读*/
		AjaxMsg msg = messageService.loadAllSysMsgList(params,new PageModel());
		PageModel pageModel = (PageModel) msg.getData("page");
		List<Map<String,Object>> listMessage = new ArrayList<Map<String,Object>>();
		
		listMessage = pageModel.getItems();
		if(listMessage.size() > 0){
			for (int i = 0; i < listMessage.size(); i++) {
				String type = listMessage.get(i).get("type").toString();
				if(type.equals("ptaq") || type.equals("ptaj") || type.equals("atpq") || type.equals("atpj") 
						&& type.equals("ttpa") || type.equals("ipk")|| type.equals("trial")|| type.equals("bbout")){
				}else{
					String id = listMessage.get(i).get("id").toString();
					Message newmsg = messageService.getEntityById(id);
					newmsg.setStatus(1);
					messageService.update(newmsg);
				}
			}
		}
		return "center/sysmsg/sysMsgList";
	}
	
	/**
	 * 查询系统消息(邀请入队等,具体类型见  SystemEnum.SYSTYPE)
	 * @return
	 */
	@RequestMapping(value="/querySysMsg")
	public String querySysMsg(Model model,HttpServletRequest request,PageModel pageModel){
		String type = request.getParameter("type");
		String user_id = request.getParameter("user_id");
		String m_style = request.getParameter("m_style");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("user_id",user_id);
		params.put("type", type);
		params.put("m_style", m_style);
		AjaxMsg msg = messageService.loadAllSysMsgList(params, pageModel);
		//update by ylt 查询系统消息为json
		model.addAttribute("rf", msg.getData("page"));
		model.addAttribute("user_id", user_id);
		//"center/sysmsg/msglist"
		return "center/sysmsg/sysMsgDatas";
	}
	/**
	 * <p>Description:查看 头部提醒系统消息</p>
	 * @Author zhangwei
	 * @Date 2015年12月5日 下午4:27:10
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/queryNotReadSysMsg")
	@ResponseBody
	public String queryNotReadSysMsg(HttpServletRequest request){
		String user_id = request.getParameter("user_id");
		String m_style = request.getParameter("m_style");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("user_id",user_id);
		params.put("m_style", m_style);
		params.put("status","0");
		
		AjaxMsg msg = messageService.loadAllSysMsgList(params,new PageModel());
		return msg.toJson();
	}
	
	/**
	 * 保存动态
	 * @param request
	 * @return AjaxMsg
	 */
	@RequestMapping(value="/saveMsg")
	@ResponseBody
	public String saveDyn(HttpServletRequest request,Message message){
		message.setS_user_id(getUserId());
		message.setType("private");
		message.setM_style(0);
		message.setId(UUIDGenerator.getUUID());
		AjaxMsg msg = messageService.save(message);
		return msg.toJson();
	}
}
