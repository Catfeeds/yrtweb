package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.yt.framework.persistent.entity.SysArea;
import com.yt.framework.utils.AjaxMsg;

/**
 * 区域
 *@autor ylt
 *@date2016-2-27上午11:50:59
 */
public interface AdminSysAreaMapper {

	/**
	 * 查询区域列表
	 * @param parent_code
	 * @return
	 */
	public List<Map<String, Object>> querySysArea(@Param(value="parent_code")String parent_code);
	
	/**
	 * 查询区域
	 * @param parent_code
	 * @return
	 */
	public List<SysArea> sysAreaList(@Param(value="parent_code")String parent_code);
	
	
	/**
	 * 保存区域
	 * @param sysArea
	 * @return
	 */
	public void saveSysArea(SysArea sysArea)throws Exception;
	
	/**
	 * 区域修改
	 * @param sysArea
	 * @return
	 */
	public void updateSysArea(SysArea sysArea)throws Exception;
	
	/**
	 * 区域查询
	 * @param maps pageModel
	 * @return
	 */
	public List<SysArea> queryForPage(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 区域查询总数
	 * @param maps pageModel
	 * @return
	 */
	public int count(@Param(value="maps")Map<String, Object> maps);
	
	/**
	 * 区域获取
	 * @param id
	 * @return
	 */
	public SysArea getEntityById(@Param(value="id")Long id);
	
	/**
	 * 区域获取
	 * @param area_code
	 * @return
	 */
	public SysArea getAreaByCode(@Param(value="area_code")String area_code);
	
	/**
	 * 所有区域
	 * @param id
	 * @return
	 */
	public List<SysArea> allSysArea();
	
	/**
	 * 返回对象中文显示名称
	 * @autor ylt
	 * @return area_code
	 */
	public String id2Name(@Param(value="area_code")String area_code);
	
	/**
	 * 删除区域
	 * @autor ylt
	 * @return id
	 */
	public void delSysArea(@Param(value="id")Long id);
}
