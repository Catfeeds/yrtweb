package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.utils.PageModel;

/**
 * 后台足球宝贝管理
 * @author bo.xie
 * @date 2015年10月12日11:14:57
 */
public interface AdminBabyInfoService {

	/**
	 * 获取足球宝贝信息
	 * @param id 足球宝贝ID
	 * @return
	 */
	public BabyInfo getBabyInfoById(String id);
	
	/**
	 * 更新宝贝信息
	 * @param babyInfo
	 */
	public void updateBabyInfo(BabyInfo babyInfo);
	
	/**
	 * 判断当前排序是否存在
	 * @param show_num
	 * @return
	 */
	public int isExistByShowNum(String show_num);
	
	/**
	 * 获取宝贝数据，用于分页
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadBabyDataPage(Map<String,Object> maps,PageModel pageModel);
}
