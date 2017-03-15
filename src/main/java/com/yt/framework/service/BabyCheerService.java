package com.yt.framework.service;

import java.util.List;

import com.yt.framework.persistent.entity.BabyCheer;
import com.yt.framework.utils.AjaxMsg;

/**
 * 宝贝助威
 * @autor ylt
 * @date2015-8-4上午10:59:16
 */
public interface BabyCheerService extends BaseService<BabyCheer> {
	
	/**
	 * 根据比赛ID获取宝贝信息
	 * @param user_id 经纪人用户ID
	 * @return
	 * @autor ylt
	 * @parameter *
	 * @date2015-9-16下午4:03:24
	 */
	public AjaxMsg getByBabyByGame(String game_id,String teaminfo_id);
	
	/**
	 * 查询俱乐部某场比赛已有助威宝贝数量
	 * @param teaminfo_id 俱乐部ID
	 * @param teamgame_id 比赛ID
	 * @return
	 */
	public int babyCheerCount(String teaminfo_id,String teamgame_id);
	
	/**
	 * 批量保存俱乐部宝贝助威
	 * @param listCheer 宝贝列表
	 * @return
	 */
	public AjaxMsg saveCheerBatch(List<BabyCheer> listCheer)throws Exception;
	
}
