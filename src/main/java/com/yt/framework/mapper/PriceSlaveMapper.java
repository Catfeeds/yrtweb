package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.PriceSlave;

/**
 *身价记录信息
 *@autor bo.xie
 *@date2015-8-3下午7:05:43
 */
public interface PriceSlaveMapper extends BaseMapper<PriceSlave> {

	/**
	 * 获取对应用户的当前身价
	 * @param user_id 用户ID
	 * @param role_type 角色类型
	 * @param status 身价状态
	 * @return
	 */
	public PriceSlave getPriceSlaveByUserAndType(@Param("user_id")String user_id,@Param(value="role_type")String role_type);
	
	/**
	 * 球员单次最高身价
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadPriceSlaveSingle(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 球员单次最高身价总数
	 * @param maps
	 * @return
	 */
	public int loadPriceSlaveSingleCount(@Param(value="maps")Map<String,Object> maps);
}
