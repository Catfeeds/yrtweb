package com.yt.framework.service.Impl;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.core.task.TaskExecutor;
import org.springframework.core.task.TaskRejectedException;
import org.springframework.stereotype.Service;

import com.aliyun.oss.OSSClient;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.mapper.admin.AccountMapper;
import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserInvitesms;
import com.yt.framework.persistent.enums.SmsEnum;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.persistent.enums.UserEnum.BINDTYPE;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.FileSender;
import com.yt.framework.utils.Md5Encrypt;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.emailSend.EmailNoticeDto;
import com.yt.framework.utils.emailSend.MailService;
import com.yt.framework.utils.file.OssTool;
import com.yt.framework.utils.oss.OSSUploadFile;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 *@date2015-7-21下午2:09:25
 */
@Service(value="userService")
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService{
	
	protected static Logger logger = LogManager.getLogger(UserServiceImpl.class);

	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private MessageResourceService messageResourceService;
	
	@Override
	public AjaxMsg validateLogin(String ln, String password) {
		if(StringUtils.isBlank(ln) || StringUtils.isBlank(password))return AjaxMsg.newError().addMessage("账号或密码为空");
		String pwd = Md5Encrypt.md5(password);
		User user = userMapper.getUserInfo(ln, pwd);
		if(user==null)return AjaxMsg.newError().addMessage("账号或密码错误");
		
		user.setPassword(null);
		//登录成功，用户信息注入到session中
		Common.setSessionValue(User.LOGIN_USER_SESSION_NAME, user);
		
		return AjaxMsg.newSuccess().addMessage("登录成功");
		
	}
	
	@Override
	public AjaxMsg savaAccount(HttpServletRequest request,User u) {
		try {
			u.setPassword(Md5Encrypt.md5(u.getPassword()));
			//added by bo.xie 注册时，根据注册账号默认生成一个昵称 start
			String usernick = StringUtils.isNotBlank(u.getPhone())?u.getPhone():u.getEmail();
			u.setUsernick(Common.hiddenPhoneOrEmail(usernick));
			u.setHead_icon("headImg/headimg.png");
			//added by bo.xie 注册时，根据注册账号默认生成一个昵称 end
			if(StringUtils.isBlank(u.getId())){
				u.setId(UUIDGenerator.getUUID());
			}
			userMapper.save(u);
			if(StringUtils.isBlank(u.getId())){
				return AjaxMsg.newError().addMessage("注册失败！");
			}else{
				securityService.saveUserRole(u,"2",request);
				//added by bo.xie 生成资金账户
				UserAmount userAmount = new UserAmount();
				userAmount.setId(UUIDGenerator.getUUID());
				userAmount.setUser_id(u.getId());
				userAmount.setAmount(new BigDecimal(0));
				userAmount.setReal_amount(new BigDecimal(0));
				userAmount.setSend_amount(new BigDecimal(0));
				userAmount.setStatus(1);
				userAmount.setType(1);
				accountMapper.saveUserAmount(userAmount);
				
				return AjaxMsg.newSuccess().addMessage("注册成功！").addData("user", u);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage("系统错误！");
		}
	}
	@Override
	public AjaxMsg isAvailableUsername(String username){
		User user = getUserByUsername(username);
		if(user!=null){
			return AjaxMsg.newError().addMessage("用户名已经被占用");
		}else{
			return AjaxMsg.newSuccess().addMessage("该用户名可以使用");
		}
	} 
	@Override
	public User getUserByUsername(String username){
		String type = "phone";
		if(!Common.isMobile(username)){
			type = "email";
		}
		List<User> ulist = userMapper.getUserByUsername(type,username);
		if(ulist!=null&&ulist.size()==1){
			return ulist.get(0);
		}
		return null;
	}

	@Override
	public AjaxMsg saveFocus(Focus focus) {
		if(focus==null) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.focus.err"));
		try {
			if(StringUtils.isBlank(focus.getId())){
				focus.setId(UUIDGenerator.getUUID());
			}
			userMapper.saveFocus(focus);
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.error.focus.ok"));
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.focus.err"));
		}
	}

	@Override
	public AjaxMsg getFocusUsersByUserId(String user_id,String other_user_id,PageModel pageModel) {
		if(StringUtils.isBlank(user_id)) return AjaxMsg.newError().addMessage("用户不存在！");
		List<Map<String,Object>> datas = Lists.newArrayList();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("other_user_id", other_user_id);
		int totalCount = userMapper.getFocusUsersCountByUserId(maps);
		pageModel.setTotalCount(totalCount);
		
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		datas = userMapper.getFocusUsersByUserId(maps);
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("data", pageModel);
	}

	@Override
	public AjaxMsg getFocusUsersNoPage(String user_id) {
		if(StringUtils.isBlank(user_id)) return AjaxMsg.newError().addMessage("用户不存在！");
		List<Map<String,Object>> datas = Lists.newArrayList();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		datas = userMapper.getFocusUsersNoPage(maps);
		return AjaxMsg.newSuccess().addData("data", datas);
	}
	
	@Override
	public AjaxMsg deleteFocus(String user_id, String f_user_id,int type) {
		if(StringUtils.isNotBlank(user_id) && StringUtils.isNotBlank(f_user_id)){
			userMapper.deleteFocus(user_id, f_user_id,type);
			return AjaxMsg.newSuccess().addMessage("取消关注成功！");
		}else{
			return AjaxMsg.newError().addMessage("取消关注失败！");
			
		}
	}

	@Override
	public User getUserByPhoneOrEmail(String str) {
		if(StringUtils.isBlank(str)) return null;
		User user = new User();
		if(Common.isMobile(str)){
			user = userMapper.getUserByPhone(str);
		}else if(Common.isEmail(str)){
			user = userMapper.getUserByEmail(str);
		}
		return user;
		
	}

	@Override
	public AjaxMsg bindPhone(HttpServletRequest request,String user_id,String name, String code) {
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(name) || StringUtils.isBlank(code)) return msg.addMessage("手机号或验证码为空！");
		
		User ole_user = this.getUserByPhoneOrEmail(name);
		if(ole_user!=null) return msg.addMessage("该号已被绑定！");
		
		msg = this.validateCode(request, name, code);
		if(msg.isSuccess()){
			User user = this.getEntityById(user_id);
			user.setPhone(name);
			
			msg = this.update(user);
			if(msg.isSuccess())Common.setSessionValue(User.LOGIN_USER_SESSION_NAME, user);
		}
		return msg;
		
	}
	
	@Override
	public AjaxMsg validateCode(HttpServletRequest request, String name,
			String code) {
		AjaxMsg msg = AjaxMsg.newError();
		String bindName = String.valueOf(Common.getCurrentSessionValue(request, BINDTYPE.BINDNAME.toString()));
		String s_code = "";
		if(Common.isEmail(name)){
			if(!bindName.equals(name)) return msg.addMessage("邮箱与获取验证码的邮箱不一致！");
			s_code = String.valueOf(Common.getCurrentSessionValue(request, BINDTYPE.EMAIL.toString()));
		}else if(Common.isMobile(name)){
			if(!bindName.equals(name)) return msg.addMessage("手机号与获取验证码的手机号不一致！");
			s_code = String.valueOf(Common.getCurrentSessionValue(request, BINDTYPE.PHONE.toString()));
		}
		
		if(StringUtils.isBlank(s_code)) return msg.addMessage("验证码超时，请重新获取！");
		if(!s_code.equals(code)) return msg.addMessage("验证码输入错误！");
		
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg bindEmail(HttpServletRequest request, String user_id,
			String name, String code) {
		
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(name) || StringUtils.isBlank(code)) return msg.addMessage("邮箱或验证码为空！");
		
		User ole_user = this.getUserByPhoneOrEmail(name);
		if(ole_user!=null) return msg.addMessage("该号已被绑定！");
		
		msg = this.validateCode(request, name, code);
		if(msg.isSuccess()){
			User user = this.getEntityById(user_id);
			user.setEmail(name);
			
			msg = this.update(user);
			if(msg.isSuccess()) Common.setSessionValue(User.LOGIN_USER_SESSION_NAME, user);
		}
		
		return msg;
		
	}

	@Override
	public AjaxMsg getUserById(String uid, String meid) {
		if(StringUtils.isNotBlank(uid)){
			if(StringUtils.isBlank(meid)){
				meid = "";
			}
			Map<String, Object> user = userMapper.getUserById(uid,meid);
			if(user!=null){
				return AjaxMsg.newSuccess().addData("user", user);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public Focus getFocusByIds(String user_id, String teaminfo_id) {
		return userMapper.getFocusByIds(user_id, teaminfo_id);
		
	}

	@Override
	public Map<String,Object> userCounts(String usernick) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("u_counts", 0);
		map.put("a_counts", 0);
		map.put("c_counts", 0);
		map.put("t_counts", 0);
		map.put("f_counts", 0);
		map.put("g_counts", 0);
		//map.put("j_counts",0);
		map.put("usernick", usernick);
		userMapper.getCounts(map);
		return map;
		
	}

	@Override
	public int isOnFocusById(String user_id, String f_user_id) {
		return userMapper.isOnFocusById(user_id, f_user_id);
	}

	@Override
	public List<User> getUserByNick(String usernick) {
		return userMapper.getUserByNick(usernick);
	}

	@Override
	public boolean hasUserByNick(String uid,String usernick) {
		List<User> users = getUserByNick(usernick);
		for (User user : users) {
			if(user!=null&&!user.getId().equals(uid)){
				return true;
			}
		}
		return false;
	}

	@Override
	public AjaxMsg getUsersFansByUserId(String user_id,String other_user_id, PageModel pageModel) {
		if(StringUtils.isBlank(user_id)) return AjaxMsg.newError().addMessage("用户不存在！");
		List<Map<String,Object>> datas = Lists.newArrayList();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("other_user_id", other_user_id);
		int totalCount = userMapper.getUsersFansCount(maps);
		pageModel.setTotalCount(totalCount);
		
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		datas = userMapper.getUsersFansByUserId(maps);
		/*List<Map<String,Object>> lists = Lists.newArrayList();
		List<String> ids = userMapper.getFocusByUserId(user_id);
		for (Map<String, Object> map : datas) {
			String re_user_id = String.valueOf(map.get("id"));
			Boolean flag = Boolean.FALSE;
			Iterator<String> iterator = ids.iterator();
			while(iterator.hasNext()){
				String str = String.valueOf(iterator.next());
				if(str.equals(re_user_id)){
					flag = Boolean.TRUE;
					break;
				}
			}
			map.put("flag", flag);
			lists.add(map);
		}*/
		pageModel.setItems(datas);
		return AjaxMsg.newSuccess().addData("data", pageModel);
	}

	@Override
	public Map<String, Object> getData() {
		return userMapper.getData();
	}

	@Override
	public List<String> getUserRole(String uid) {
		List<String> ls = userMapper.getUserRole(uid);
		return ls;
	}

	@Override
	public AjaxMsg inviteUploadSMS(Map<String, Object> params) {
		String user_id = String.valueOf(params.get("user_id"));//邀请用户ID
		String type = String.valueOf(params.get("type"));
		String f_usernick = String.valueOf(params.get("f_usernick"));//发起邀请用户昵称
		String f_user_id = String.valueOf(params.get("f_user_id"));//发起邀请用户ID
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(type)||StringUtils.isBlank(f_user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
		
		//判断发起邀请用户今天是否已邀请过该用户
		int count = userMapper.inviteUserCountByUserId(f_user_id, user_id,type);
		if(count>0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.phone.invite"));
		//判断发起邀请用户今天邀请总次数，一天不能超过50次
		int totalCount = userMapper.getTodayUserInviteCount(f_user_id,type);
		if(totalCount>=50)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.phone.ceiling"));
		
		User user = userMapper.getEntityById(user_id);
		if(user!=null){
			String phone = user.getPhone();
			if(StringUtils.isNotBlank(phone)){
				UserInvitesms ui = new UserInvitesms();
				ui.setId(UUIDGenerator.getUUID32());
				ui.setF_user_id(f_user_id);
				ui.setType(Integer.valueOf(type));
				ui.setUser_id(user_id);
				
				SendMsg smg = SendMsg.getInstance();
				StringBuilder sb = new StringBuilder();
				sb.append("@1@=").append(f_usernick);
				if(type.equals("1")){//邀请上传精彩瞬间
					AjaxMsg msg = smg.sendSMS(phone, sb.toString(), SMSTEMP.JSM405880037.toString());
					if(msg.isSuccess()){
						userMapper.saveUserInviteSms(ui);
						return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.invite"));
					}else{
						logger.error(phone+"邀请上传精彩瞬间短信发送失败！");
						return msg;
					}
				}else if(type.equals("2")){//邀请录入足球生涯
					AjaxMsg msg = smg.sendSMS(phone, sb.toString(), SMSTEMP.JSM405880038.toString());
					if(msg.isSuccess()){
						userMapper.saveUserInviteSms(ui);
						return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.invite"));
					}else{
						logger.error(phone+"邀请录入足球生涯短信发送失败！");
						return msg;
					}
				}
			}else{
				//return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.phone.isnotexist"));
				String email = user.getEmail();
				if(StringUtils.isNotBlank(email)){
					UserInvitesms ui = new UserInvitesms();
					ui.setId(UUIDGenerator.getUUID32());
					ui.setF_user_id(f_user_id);
					ui.setType(Integer.valueOf(type));
					ui.setUser_id(user_id);
					
					if(type.equals("1")){//邀请上传精彩瞬间
						String txt = "（"+f_usernick+"）邀请你上传你的精彩瞬间，去完善它吧，说不一定有意外的惊喜哦。";
						EmailNoticeDto emailDto = new EmailNoticeDto();
						List<String> sendTo=new ArrayList<String>();
						sendTo.add(email);
						emailDto.setSendTo(sendTo);
						emailDto.setText(txt);
						try {
							MailService.getInstance().send(emailDto);
							userMapper.saveUserInviteSms(ui);
							return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.invite"));
						} catch (Exception e) {
							logger.error(email+":邮件发送失败");
						}
					}else if(type.equals("2")){//邀请录入足球生涯
						String txt = "（"+f_usernick+"）邀请你录入你的足球生涯，去完善它吧，说不一定有意外的惊喜哦。";
						EmailNoticeDto emailDto = new EmailNoticeDto();
						List<String> sendTo=new ArrayList<String>();
						sendTo.add(email);
						emailDto.setSendTo(sendTo);
						emailDto.setText(txt);
						try {
							MailService.getInstance().send(emailDto);
							userMapper.saveUserInviteSms(ui);
							return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.invite"));
						} catch (Exception e) {
							logger.error(email+":邮件发送失败");
						}
					}
				}
			}
		}
		
		return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
	}
	
	@Cacheable(value = "objCache",key = "'idName'+#id")
	@Override
	public String id2UserName(String id) {
		return userMapper.id2UserName(id);
	}

	@Override
	public AjaxMsg getUserCardInfo(String user_id,String me_id) {
		if(StringUtils.isBlank(user_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		
 
		Map<String,Object> reMap = Maps.newHashMap();
		Map<String,Object> map = userMapper.getUserById(user_id, me_id);
		reMap.put("user_id", user_id);
		reMap.put("head_icon", map.get("head_icon"));
		reMap.put("usernick", map.get("usernick"));
		reMap.put("guanzhu", map.get("guanzhu"));
		if((Boolean)map.get("sex")){
			reMap.put("sex",1);
		}else{
			reMap.put("sex",0);
		}
		reMap.put("current_price", map.get("current_price"));
		reMap.put("score", map.get("score"));
		TeamPlayer teamPlayer = teamInfoMapper.getTeamPlayerByUserId(user_id);
		if(teamPlayer!=null){
			String teaminfo_id = teamPlayer.getTeaminfo_id();
			TeamInfo ti = teamInfoMapper.getTeamInfoById(teaminfo_id);
			if(ti!=null){
				reMap.put("player_num", teamPlayer.getPlayer_num());
				reMap.put("position", teamPlayer.getPosition());
				reMap.put("team_name", ti.getName());
			}
		}
		
		List<String> praises = playerInfoMapper.praiseCount(user_id);
		 BigDecimal praise = new BigDecimal(praises.get(0));
		 BigDecimal cai = new BigDecimal(praises.get(0));
		 //设置认可度
		 if(praise.add(cai).compareTo(new BigDecimal(0))<1){
			 reMap.put("accept", 100);
		 }else{
			 reMap.put("accept", praise.divide(praise.add(cai),0,RoundingMode.HALF_UP).multiply(new BigDecimal(100)));
		 }
		return AjaxMsg.newSuccess().addData("data", reMap);
	}
	
	@Resource(name = "taskExecutor")
    private TaskExecutor taskExecutor;

	@Override
	public String task(String a) {
		/*while(true){
		    try{
		    	taskExecutor.execute(new Runnable() {
					@Override
					public void run() {
						File file = new File("E:/upload/player/picture/201511/24142750nqa1.jpg");
						System.out.println("12312312312312132");
						OssTool.test();
				 		String url = OssTool.uploadObject2OSS(file, "player/picture/201511/24142750nqa1.jpg");
				 		System.out.println(url);
					}
				});
		        break;
		    }catch(TaskRejectedException e){e.printStackTrace();
		        try{
		            Thread.sleep(500);
		        }catch(Exception e2){e2.printStackTrace();}
		    }catch(Exception ex){ex.printStackTrace();}
		}*/
		while(true){
		    try{
		    	//taskExecutor.execute(new OSSUploadFile("E:/upload/player/picture/201511/24142750nqa1.jpg", "player/picture/201511/24142750nqa1.jpg"));
		        break;
		    }catch(TaskRejectedException e){e.printStackTrace();
		        try{
		            Thread.sleep(500);
		        }catch(Exception e2){e2.printStackTrace();}
		    }catch(Exception ex){ex.printStackTrace();}
		}
		return a;
	}
	@Override
	public String task2(String a) {
		/*int aa = new OSSUploadFile("E:/upload/player/picture/201511/24142750nqa1.jpg","yrt2016", "player/picture/201511/24142750nqa1.jpg").uploadFile();
		System.out.println(aa);*/
		return a;
	}
	
	public static void main(String args[]){
		System.out.println(Md5Encrypt.md5("123456"));
	}
}
