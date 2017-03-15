package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.persistent.entity.GiftVO;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ReturnJosnMsg;

/**
 *
 *@autor bo.xie
 *@date2015-9-24下午6:43:30
 */
public interface BabyService extends BaseService<BabyInfo> {

	/**
	 * 保存或更新宝贝基本信息
	 *@param babyInfo
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-25上午11:34:30
	 */
	public AjaxMsg saveOrUpdateInfo(BabyInfo babyInfo,HttpServletRequest request) throws Exception;
	
	/**
	 * 获取宝贝
	 *@param babyInfo
	 *@return
	 *@autor ylt
	 *@parameter *
	 *@date2015-9-27上午11:34:30
	 */
	public AjaxMsg getBabyUser(String baby_id);
	
	/**
	 * 获取宝贝上传的所有视频
	 * @param user_id 用户ID
	 * @param type 类型 1：图片 2：视频
	 * @return
	 */
	public List<Map<String,Object>> loadAllBabyVideoByUserId(String user_id,String role_type);
	
	/**
	 * 获取宝贝上传的所有图片
	 * @param user_id 用户ID
	 * @param type 类型 1：图片 2：视频
	 * @return
	 */
	public List<Map<String,Object>> loadAllBabyImageByUserId(String user_id,String role_type);
	
	/**
	 * 获取宝贝已助威比赛场数跟已代言俱乐部个数
	 * @param user_id
	 * @return
	 */
	public Map<String,Object> getInviteAndCheerCount(String user_id);
	
	/**
	 * 保存baby上传的图片
	 * @param userId
	 * @param images
	 * @autor gl
	 * @return
	 */
	public AjaxMsg saveBabyImages(String userId,String images,String type);
	
	/**
	 * 查询宝贝图片
	 * @param params
	 * @param pageModel
	 * @autor gl
	 * @return
	 */
	public AjaxMsg queryBabyImages(Map<String, Object> params, PageModel pageModel);
	
	/**
	 * 查询宝贝图片总条数
	 * @param params
	 * @autor gl
	 * @return
	 */
	public int babyImgCount(Map<String, Object> params);
	/**
	 * 删除宝贝图片
	 * @param id 图片id
	 * @autor gl
	 * @return
	 */
	public AjaxMsg deleteBabyImg(String id);
	
	/**
	 * 获取推荐宝贝的第一张图片
	 * @return
	 */
	public List<Map<String,Object>> loadRecommendBabyImages(Map<String,Object>maps);
	
	/**
	 * 获取宝贝已代言俱乐部信息
	 * @param baby_user_id 足球宝贝用户ID
	 * @return
	 */
	public TeamInfo getTeamInfoByUserId(String baby_user_id);
	/**
	 * 通过用户获取宝贝
	 * @param baby_user_id 足球宝贝用户ID
	 * @return
	 */
	public BabyInfo getBabyInfoByUserId(String user_id);
	
	public ReturnJosnMsg buyGift(Map<String, String> maps) ;
	
	public List<GiftVO> getReceiveGiftList(String user_id) ;
	
}
