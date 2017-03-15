package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserInvitesms;

/**
 *
 *@autor bo.xie
 *@date2015-7-21下午2:08:53
 */
public interface UserMapper extends BaseMapper<User>{

	/**
	 * 分页查询所有用户
	 *@param params
	 *@return List<User>
	 *@autor bo.xie
	 *@date2015-7-22下午6:17:03
	 */
	public List<User> findByPage(Map<String, Object> params);

	/**
	 *获取总条数
	 *@param params
	 *@return int
	 *@autor bo.xie
	 *@date2015-7-22下午6:17:30
	 */
	public int userCount(Map<String, Object> params);
	
	/**
	 * 获取用户信息
	 *@param username 用户名
	 *@param password 密码
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-7-23下午5:56:48
	 */
	public User getUserInfo(@Param(value="username")String username,@Param(value="password")String password);
	
	public List<User> getUserByUsername(@Param(value="type")String type,@Param(value="username")String username);
	
	/**
	 * 关注用户
	 *@param focus   f_type:0:非俱乐部，1 :俱乐部 ; f_user_id 关注ID   当关注俱乐部时存放俱乐部ID,非俱乐部时存放用户ID
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午2:28:57
	 */
	void saveFocus(Focus focus);
	
	/**
	 * 取消关注用户
	 *@param user_id 用户ID
	 *@param f_user_id 关注ID   当关注俱乐部时ID为俱乐部ID,非俱乐部时ID为用户ID
	 *@param type 0:非俱乐部 1：俱乐部
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午5:53:36
	 */
	void deleteFocus(@Param(value="user_id")String user_id,@Param(value="f_user_id")String f_user_id,@Param(value="type")int type);
	
	/**
	 * 获取所有关注用户的基本信息
	 *@param user_id 用户ID
	 *@param maps 分页其他条件  为null时不分页
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午2:35:35
	 */
	List<Map<String,Object>> getFocusUsersByUserId(@Param(value="maps")Map<String,Object> maps);
	/**
	 * 获取所有关注用户的基本信息无分页
	 *@param user_id 用户ID
	 *@param maps 分页其他条件 
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午2:35:35
	 */
	List<Map<String,Object>> getFocusUsersNoPage(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取关注用户总人数
	 *@param user_id
	 *@param maps
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午4:56:42
	 */
	int getFocusUsersCountByUserId(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 通过手机号码获取用户信息
	 *@param phone
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20上午10:58:36
	 */
	User getUserByPhone(@Param(value="phone")String phone);
	
	/**|
	 * 通过邮箱获取用户信息
	 *@param email
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-20上午10:58:57
	 */
	User getUserByEmail(@Param(value="email")String email);

	/**
	 * 个人中心查询用户信息
	 * @param uid
	 * @param userId
	 * @return AjaxMsg
	 */
	public Map<String, Object> getUserById(@Param(value="uid")String uid, @Param(value="meid")String meid);
	
	/**
	 * 获取关注信息表
	 *@param user_id
	 *@param teaminfo_id
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-8下午5:12:32
	 */
	public Focus getFocusByIds(@Param(value="user_id")String user_id,@Param(value="teaminfo_id")String teaminfo_id);
	
	/**
	 * 获取球员、经纪人，教练，俱乐部数量
	 *@param usernick
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-14下午3:00:21
	 */
	public void getCounts(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 判断当前登录用户是否关注某用户
	 * @param user_id
	 * @param f_user_id
	 * @return
	 */
	public int isOnFocusById(@Param(value="user_id")String user_id,@Param(value="f_user_id")String f_user_id);

	public List<User> getUserByNick(@Param(value="usernick")String usernick);
	
	/**
	 * 获取当前用户的粉丝
	 * @param maps
	 * @return
	 */
	List<Map<String,Object>> getUsersFansByUserId(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取当前用户粉丝数量
	 * @param maps
	 * @return
	 */
	int getUsersFansCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取关注用户ID信息表
	 * @param user_id
	 * @return
	 */
	List<String> getFocusByUserId(@Param(value="user_id")String user_id);
	
	
	/**
	 * 数据统计
	 * @return
	 */
	public Map<String,Object> getData();
	

	public List<String> getUserRole(@Param(value="user_id")String user_id);
	
	/**
	 * 保存用户发送短信邀请记录
	 * @param userInvitesms
	 */
	public void saveUserInviteSms(UserInvitesms userInvitesms);
	
	/**
	 * 当日用户邀请其他用户次数
	 */
	public int inviteUserCountByUserId(@Param("f_user_id")String f_user_id,@Param(value="user_id")String user_id,@Param(value="type")String type);
	
	/**
	 * 获取当天用户发送邀请总记录
	 * @param user_id 发起邀请用户ID
	 * @return
	 */
	public int getTodayUserInviteCount(@Param(value="user_id")String user_id,@Param(value="type")String type);
	/**
	 * 查询用户真实姓名
	 * @param id
	 * @return
	 */
	public String id2UserName(String id);
}
