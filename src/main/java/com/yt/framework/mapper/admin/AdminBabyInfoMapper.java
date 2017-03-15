package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyInfo;

/**
 * 后台宝贝管理
 * @author bo.xie
 * @date 2015年10月12日10:46:35
 */
public interface AdminBabyInfoMapper {
	
	/**
	 * 获取足球宝贝信息
	 * @param id 足球宝贝ID
	 * @return
	 */
	public BabyInfo getBabyInfoById(@Param(value="id")String id);

	/**
	 * 更新宝贝信息
	 * @param babyInfo
	 */
	public void updateBabyInfo(BabyInfo babyInfo);
	
	/**
	 * 获取宝贝数据，用于分页
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadBabyDataPage(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 获取宝贝数据总条数
	 * @param maps
	 * @return
	 */
	public int loadBabyDataCount(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 判断当前排序是否存在
	 * @param show_num
	 * @return
	 */
	public int isExistByShowNum(@Param(value="show_num")String show_num);
}
