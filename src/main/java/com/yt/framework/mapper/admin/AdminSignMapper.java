package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.AdminSign;
import com.yt.framework.persistent.entity.AdminSignCfg;

/**
 * @author ylt
 *
 */
public interface AdminSignMapper extends BaseMapper<AdminSign> {
	
	/**
	 * 获取报名录入信息
	 * @param mobile
	 * @param leagues_id
	 */
	public AdminSign getAdminSign(@Param(value="mobile")String mobile, @Param(value="s_id")String s_id);
	
	/**
	 * 获取报名录入信息
	 * @param mobile
	 * @param leagues_id
	 */
	public AdminSign getAdminSignBySign(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 保存报名配置
	 * @param mobile
	 * @param leagues_id
	 */
	public void saveAdminSignCfg(AdminSignCfg adminSignCfg);
	
	/**
	 * 更新报名配置
	 * @param mobile
	 * @param leagues_id
	 */
	public void updateAdminSignCfg(AdminSignCfg adminSignCfg);
	
	/**
	 * 删除报名配置
	 * @param mobile
	 * @param leagues_id
	 */
	public void deleteAdminSignCfg(@Param(value="id")String id);
	
	/**
	 * 获取报名配置
	 * @param mobile
	 * @param leagues_id
	 */
	public AdminSignCfg getCfgById(String id);
	
	/**
	 * 获取报名配置总数
	 * @param maps
	 */
	public int countCfg(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 获取报名配置列表
	 * @param maps
	 */
	public List<AdminSignCfg> queryCfgForPage(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 关键字查询
	 * @param maps
	 */
	public int queryKeyword(@Param(value="keyword")String keyword);
	

}
