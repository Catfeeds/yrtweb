package com.yt.framework.service;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *
 *@autor bo.xie
 *@date2015-7-21下午2:09:06
 */
public interface UserService extends BaseService<User>{

	/**
	 * 用户登录校验
	 *@param ln 登录名
	 *@param password 登录密码
	 *@return AjaxMsg
	 *@autor bo.xie
	 *@date2015-7-23下午5:51:35
	 */
	public AjaxMsg validateLogin(String ln,String password);
	/**
	 * @Title: savaAccount 
	 * @Description: 保存注册账户 
	 * @param  u	需要保存的User对象
	 * @return AjaxMsg   
	 * @throws 
	 * @date:2015年7月24日上午10:37:35
	 */
	public AjaxMsg savaAccount(HttpServletRequest request,User u);
	/**
	 * @Title: isAvailableUsername 
	 * @Description: 检查用户名是否可用 
	 * @param @param username
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date:2015年7月27日下午2:29:23
	 */
	public AjaxMsg isAvailableUsername(String username);
	
	/**
	 * 通过帐号获取User
	 * @param username
	 * @return
	 */
	public User getUserByUsername(String username);
	
	/**
	 * 关注用户
	 *@param focus f_type:0:非俱乐部，1 :俱乐部 ; f_user_id 关注ID   当关注俱乐部时存放俱乐部ID,非俱乐部时存放用户ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午4:40:50
	 */
	public AjaxMsg saveFocus(Focus focus);
	
	/**
	 * 取消关注
	 *@param user_id 用户ID
	 *@param f_user_id 关注ID   当关注俱乐部时ID为俱乐部ID,非俱乐部时ID为用户ID
	 *@param type 0:非俱乐部 1：俱乐部
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午6:06:43
	 */
	public AjaxMsg deleteFocus(String user_id,String f_user_id,int type);
	
	/**
	 * 获取所有关注用户的基本信息
	 *@param user_id
	 *@param pageModel 为null时，不分页
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午2:35:35
	 */
	public AjaxMsg getFocusUsersByUserId(String user_id,String other_user_id,PageModel pageModel);
	/**
	 * 获取所有关注用户的基本信息(不分页)
	 *@param user_id
	 *@param pageModel 为null时，不分页
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-12下午2:35:35
	 */
	public AjaxMsg getFocusUsersNoPage(String user_id);
	
	/**
	 * 通过邮箱或者手机号码获取用户信息
	 *@param str
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20上午11:01:25
	 */
	public User getUserByPhoneOrEmail(String str);
	
	/**
	 * 绑定手机号
	 * @param request
	 * @param user_id 用户ID
	 *@param name 手机号
	 *@param code
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20下午2:02:19
	 */
	public AjaxMsg bindPhone(HttpServletRequest request,String user_id,String name,String code);
	
	/**
	 * 绑定邮箱
	 *@param request
	 *@param user_id 用户ID
	 *@param name 邮箱
	 *@param code 验证码
	 *@param time 接收时间
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-21下午3:57:09
	 */
	public AjaxMsg bindEmail(HttpServletRequest request,String user_id,String name,String code);
	
	/**
	 * 校验验证码
	 *@param request
	 *@param name 手机或邮箱
	 *@param code 验证码值
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-21上午11:34:41
	 */
	public AjaxMsg validateCode(HttpServletRequest request, String name,String code);
	/**
	 * 个人中心查询用户信息
	 * @param uid
	 * @param userId
	 * @autor gl
	 * @return AjaxMsg
	 */
	public AjaxMsg getUserById(String uid, String meid);
	
	/**
	 * 获取关注信息表
	 *@param user_id
	 *@param teaminfo_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-8下午5:12:32
	 */
	public Focus getFocusByIds(String user_id,String teaminfo_id);
	
	/**
	 * 获取球员、经纪人，教练，俱乐部数量
	 *@param usernick
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-14下午3:00:21
	 */
	public Map<String,Object> userCounts(String usernick);
	
	/**
	 * 判断当前登录用户是否关注某用户
	 * @param user_id
	 * @param f_user_id
	 * @return
	 */
	public int isOnFocusById(String user_id,String f_user_id);
	
	/**
	 * 根据用户昵称查询用户
	 * @param usernick
	 * @autor gl
	 * @return
	 */
	public List<User> getUserByNick(String usernick);
	/**
	 * 判断用户的昵称是否存在
	 * @param usernick
	 * @autor gl
	 * @return
	 */
	public boolean hasUserByNick(String uid,String usernick);
	
	/**
	 * 获取当前用户粉丝
	 * @param user_id
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg getUsersFansByUserId(String user_id,String other_user_id,PageModel pageModel);
	
	/**
	 * 数据统计
	 * @return
	 */
	public Map<String,Object> getData();
	

	public List<String> getUserRole(String uid);
	
	/**
	 * 邀请上传、录入短信通知
	 * @param params
	 * @return
	 */
	public AjaxMsg inviteUploadSMS(Map<String,Object>params);
	
	/**
	 * 查询用户真实姓名
	 * @param params
	 * @return
	 */
	public String id2UserName(String id);
	
	/**
	 * 获取用户名片信息
	 * @param user_id
	 * @return
	 */
	public AjaxMsg getUserCardInfo(String user_id,String me_id);
	
	public String task(String i) throws Exception;
	
	public String task2(String a) throws Exception;
}
